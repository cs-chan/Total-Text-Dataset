# Copyright 2017 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

"""Faster RCNN box coder.

Faster RCNN box coder follows the coding schema described below:
  ty = (y - ya) / ha
  tx = (x - xa) / wa
  th = log(h / ha)
  tw = log(w / wa)
  where x, y, w, h denote the box's center coordinates, width and height
  respectively. Similarly, xa, ya, wa, ha denote the anchor's center
  coordinates, width and height. tx, ty, tw and th denote the anchor-encoded
  center, width and height respectively.

  See http://arxiv.org/abs/1506.01497 for details.
"""

import tensorflow as tf

from object_detection.core import box_coder
from object_detection.core import box_list
from object_detection.core import center_line_converter

EPSILON = 1e-8


class FasterRcnnBoxCoder(box_coder.BoxCoder):
  """Faster RCNN box coder."""

  def __init__(self, scale_factors=None):
    """Constructor for FasterRcnnBoxCoder.

    Args:
      scale_factors: List of 4 positive scalars to scale ty, tx, th and tw.
        If set to None, does not perform scaling. For Faster RCNN,
        the open-source implementation recommends using [10.0, 10.0, 5.0, 5.0].
    """
    if scale_factors:
      assert len(scale_factors) == 4
      for scalar in scale_factors:
        assert scalar > 0
    self._scale_factors = scale_factors

  @property
  def code_size_for_box(self):
    return 4

  @property
  def code_size_for_polygon(self):
    return 12

  @property
  def code_size_for_box_and_polygon(self):
    return 16

  def _encode_box(self, boxes, anchors):
    """Encode a box collection with respect to anchor collection.

    Args:
      boxes: BoxList holding N boxes to be encoded.
      anchors: BoxList of anchors.

    Returns:
      a tensor representing N anchor-encoded boxes of the format
      [ty, tx, th, tw].
    """
    # Convert anchors to the center coordinate representation.
    ycenter_a, xcenter_a, ha, wa = anchors.get_center_coordinates_and_sizes()
    ycenter, xcenter, h, w = boxes.get_center_coordinates_and_sizes()
    # Avoid NaN in division and log below.
    # ha = tf.Print(ha, [tf.shape(ha)], message='ha')
    ha += EPSILON
    wa += EPSILON
    h += EPSILON
    w += EPSILON

    tx = (xcenter - xcenter_a) / wa
    # tx = tf.Print(tx, [tf.shape(tx)], message='tx')
    ty = (ycenter - ycenter_a) / ha
    tw = tf.log(w / wa)
    th = tf.log(h / ha)
    # Scales location targets as used in paper for joint training.
    if self._scale_factors:
      ty *= self._scale_factors[0]
      tx *= self._scale_factors[1]
      th *= self._scale_factors[2]
      tw *= self._scale_factors[3]
    return tf.transpose(tf.stack([ty, tx, th, tw]))

  def _decode_box(self, rel_codes, anchors):
    """Decode relative codes to boxes.

    Args:
      rel_codes: a tensor representing N anchor-encoded boxes.
      anchors: BoxList of anchors.

    Returns:
      boxes: BoxList holding N bounding boxes.
    """
    ycenter_a, xcenter_a, ha, wa = anchors.get_center_coordinates_and_sizes()

    ty, tx, th, tw = tf.unstack(tf.transpose(rel_codes))
    if self._scale_factors:
      ty /= self._scale_factors[0]
      tx /= self._scale_factors[1]
      th /= self._scale_factors[2]
      tw /= self._scale_factors[3]
    w = tf.exp(tw) * wa
    h = tf.exp(th) * ha
    ycenter = ty * ha + ycenter_a
    xcenter = tx * wa + xcenter_a
    ymin = ycenter - h / 2.
    xmin = xcenter - w / 2.
    ymax = ycenter + h / 2.
    xmax = xcenter + w / 2.
    return box_list.BoxList(tf.transpose(tf.stack([ymin, xmin, ymax, xmax])))


  def _encode(self, boxes_line, anchors_line):
    """
    This helper turns encode boxes into offset with respect to anchors.
    :param boxes_line: [N, 15] Boxlist
    :param anchors_line: [N, 15]
    :return: encoded_boxes: [N, 15] [ty0, tx0, th0, tw0_1, tw0_2, ty1, tx1, th1, tw1_1, tw1_2, ty2, tx2, th2, tw2_1, tw2_2]
    """

    y = boxes_line.get()[:, 0::4]
    x = boxes_line.get()[:, 1::4]
    h = boxes_line.get()[:, 2::4]
    w = boxes_line.get()[:, 3::4]

    h += EPSILON
    w += EPSILON

    h0, h1, h2 = tf.split(h, num_or_size_splits=3, axis=1)
    w0, w1, w2 = tf.split(w, num_or_size_splits=3, axis=1)
    y0, y1, y2 = tf.split(y, num_or_size_splits=3, axis=1)
    x0, x1, x2 = tf.split(x, num_or_size_splits=3, axis=1)

    ya = anchors_line.get()[:, 0::4]
    xa = anchors_line.get()[:, 1::4]
    ha = anchors_line.get()[:, 2::4]
    wa = anchors_line.get()[:, 3::4]

    ha += EPSILON
    wa += EPSILON

    ha0, ha1, ha2 = tf.split(ha, num_or_size_splits=3, axis=1)
    wa0, wa1, wa2 = tf.split(wa, num_or_size_splits=3, axis=1)
    ya0, ya1, ya2 = tf.split(ya, num_or_size_splits=3, axis=1)
    xa0, xa1, xa2 = tf.split(xa, num_or_size_splits=3, axis=1)

    anchors = center_line_converter.line_to_polygon(anchors_line.get())
    overall_h, overall_w = center_line_converter.get_normalize_factor(anchors)

    overall_h += EPSILON
    overall_w += EPSILON

    ty0 = (y0 - ya0) / overall_h
    tx0 = (x0 - xa0) / overall_w
    th0 = (h0 - ha0) / overall_h
    tw0 = (w0 - wa0) / overall_w
    # th0 = tf.log(h0 / ha0)
    # tw0 = tf.log(w0 / wa0)
    # tw0_1 = (w0_1 - wa0_1) / overall_w
    # tw0_2 = (w0_2 - wa0_2) / overall_w
    # tw0 = tf.log(w0 / wa0)

    ty1 = (y1 - ya1) / overall_h
    tx1 = (x1 - xa1) / overall_w
    th1 = (h1 - ha1) / overall_h
    tw1 = (w1 - wa1) / overall_w
    # th1 = tf.log(h1 / ha1)
    # tw1 = tf.log(w1 / wa1)
    # tw1 = tf.log(w1 / wa1)
    # tw1_1 = (w1_1 - wa1_1) / overall_w
    # tw1_2 = (w1_2 - wa1_2) / overall_w

    ty2 = (y2 - ya2) / overall_h
    tx2 = (x2 - xa2) / overall_w
    th2 = (h2 - ha2) / overall_h
    tw2 = (w2 - wa2) / overall_w
    # th2 = tf.log(h2 / ha2)
    # tw2 = tf.log(w2 / wa2)
    # tw2_1 = (w2_1 - wa2_1) / overall_w
    # tw2_2 = (w2_2 - wa2_2) / overall_w

    if self._scale_factors:
      ty0 *= self._scale_factors[0]
      ty1 *= self._scale_factors[0]
      ty2 *= self._scale_factors[0]
      tx0 *= self._scale_factors[1]
      tx1 *= self._scale_factors[1]
      tx2 *= self._scale_factors[1]
      th0 *= self._scale_factors[0]
      th1 *= self._scale_factors[0]
      th2 *= self._scale_factors[0]
      tw0 *= self._scale_factors[1]
      tw1 *= self._scale_factors[1]
      tw2 *= self._scale_factors[1]

    encoded = tf.concat([ty0, tx0, th0, tw0, ty1, tx1, th1, tw1, ty2, tx2, th2, tw2], axis=1)
    return encoded


  def _decode(self, rel_codes, anchors_polygon):
    """Decode relative codes to boxes.
    Args:
      rel_codes: a tensor representing N anchor-encoded lines. [N, 15]
      anchors: BoxList of anchors. [N, 12]

    Returns:
      boxes: BoxList holding N bounding boxes.
    """

    anchors_line = center_line_converter.polygon_to_line(anchors_polygon.get())

    overall_h, overall_w = center_line_converter.get_normalize_factor(anchors_polygon.get())

    overall_h += EPSILON
    overall_w += EPSILON

    ty = rel_codes[:, 0::4]
    tx = rel_codes[:, 1::4]
    th = rel_codes[:, 2::4]
    tw = rel_codes[:, 3::4]

    ya = anchors_line[:, 0::4]
    xa = anchors_line[:, 1::4]
    ha = anchors_line[:, 2::4]
    wa = anchors_line[:, 3::4]

    if self._scale_factors:
      ty /= self._scale_factors[0]
      tx /= self._scale_factors[1]
      th /= self._scale_factors[0]
      tw /= self._scale_factors[1]

    ty0, ty1, ty2 = tf.split(ty, num_or_size_splits=3, axis=1)
    tx0, tx1, tx2 = tf.split(tx, num_or_size_splits=3, axis=1)
    th0, th1, th2 = tf.split(th, num_or_size_splits=3, axis=1)
    tw0, tw1, tw2 = tf.split(tw, num_or_size_splits=3, axis=1)

    ya0, ya1, ya2 = tf.split(ya, num_or_size_splits=3, axis=1)
    xa0, xa1, xa2 = tf.split(xa, num_or_size_splits=3, axis=1)
    ha0, ha1, ha2 = tf.split(ha, num_or_size_splits=3, axis=1)
    wa0, wa1, wa2 = tf.split(wa, num_or_size_splits=3, axis=1)

    y0 = (ty0 * overall_h) + ya0
    x0 = (tx0 * overall_w) + xa0
    h0 = (th0 * overall_h) + ha0
    w0 = (tw0 * overall_w) + wa0
    # h0 = tf.exp(th0) * ha0
    # w0 = tf.exp(tw0) * wa0
    # w0_1 = (tw0_1 * overall_w) + wa0_1
    # w0_2 = (tw0_2 * overall_w) + wa0_2

    y1 = (ty1 * overall_h) + ya1
    x1 = (tx1 * overall_w) + xa1
    h1 = (th1 * overall_h) + ha1
    w1 = (tw1 * overall_w) + wa1
    # h1 = tf.exp(th1) * ha1
    # w1 = tf.exp(tw1) * wa1
    # w1_1 = (tw1_1 * overall_w) + wa1_1
    # w1_2 = (tw1_2 * overall_w) + wa1_2

    y2 = (ty2 * overall_h) + ya2
    x2 = (tx2 * overall_w) + xa2
    h2 = (th2 * overall_h) + ha2
    w2 = (tw2 * overall_w) + wa2
    # h2 = tf.exp(th2) * ha2
    # w2 = tf.exp(tw2) * wa2
    # w2_1 = (tw2_1 * overall_w) + wa2_1
    # w2_2 = (tw2_2 * overall_w) + wa2_2

    polygon_line = tf.concat([y0, x0, h0, w0, y1, x1, h1, w1, y2, x2, h2, w2], axis=1)
    polygon = center_line_converter.line_to_polygon(polygon_line)
    return box_list.BoxList(polygon)
