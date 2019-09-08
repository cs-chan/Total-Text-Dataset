function [first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, top_line_matrix, btm_line_matrix] = reannotate(img_patch, xmin, ymin, xmax, ymax)
    fprintf('Please draw 4 pts.\n');
    imshow(img_patch, 'InitialMagnification', 800);

    [x, y] = getpts;
    close('all');
    first_x = x(1) + xmin;
    third_x = x(2) + xmin;
    fourth_x = x(4) + xmin;
    sixth_x = x(3) + xmin;
    first_y = y(1) + ymin;
    third_y = y(2) + ymin;
    fourth_y = y(4) + ymin;
    sixth_y = y(3) + ymin;
    
    vertical_grids = 0;
    horizontal_grids = 0;
    if (third_x - first_x) > (third_y - first_y)
        vertical_grids = 1;
        horizontal_grids = 0;
    else
        vertical_grids = 0;
        horizontal_grids = 1;
    end

    norm_xmin = 1;
    norm_xmax = xmax - xmin + 1;
    norm_ymin = 1;
    norm_ymax = ymax - ymin + 1;
    
    %4 intervals between 5 lines
    %%%%%%%%x-grids%%%%%%%%%%%%%
    top_x_dev = (third_x - first_x) / 4.0;
    top_x1 = ((max(first_x, xmin) - xmin) + 1) + top_x_dev;
    top_x2 = top_x1 + top_x_dev;
    top_x3 = top_x2 + top_x_dev;
    btm_x_dev = (fourth_x - sixth_x) / 4.0;
    btm_x1 = ((max(sixth_x, xmin) - xmin) + 1)  + btm_x_dev;
    btm_x2 = btm_x1 + btm_x_dev;
    btm_x3 = btm_x2 + btm_x_dev;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%y-grids%%%%%%%%%%%%%
    top_y_dev = (third_y - first_y) / 4.0;
    top_y1 = (max(first_y, ymin) - ymin + 1) + top_y_dev;
    top_y2 = top_y1 + top_y_dev;
    top_y3 = top_y2 + top_y_dev;
    btm_y_dev = (fourth_y - sixth_y) / 4.0;
    btm_y1 = (max(sixth_y, ymin) - ymin + 1) + btm_y_dev;
    btm_y2 = btm_y1 + btm_y_dev;
    btm_y3 = btm_y2 + btm_y_dev;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%vertical grid matrix%%%%%%%%%%%%%%
    v_top_line_matrix = [[top_x1, norm_ymin, top_x1, norm_ymax]; ...
                            [top_x2, norm_ymin, top_x2, norm_ymax]; ...
                            [top_x3, norm_ymin, top_x3, norm_ymax]];
    v_btm_line_matrix = [[btm_x1, norm_ymin, btm_x1, norm_ymax]; ...
                            [btm_x2, norm_ymin, btm_x2, norm_ymax]; ...
                            [btm_x3, norm_ymin, btm_x3, norm_ymax]];

    %%%%%%%horizontal grid matrix%%%%%%%%%%%%%%
    h_top_line_matrix = [[norm_xmin, top_y1, norm_xmax, top_y1]; ...
                            [norm_xmin, top_y2, norm_xmax, top_y2]; ...
                            [norm_xmin, top_y3, norm_xmax, top_y3]];
    h_btm_line_matrix = [[norm_xmin, btm_y1, norm_xmax, btm_y1]; ...
                            [norm_xmin, btm_y2, norm_xmax, btm_y2]; ...
                            [norm_xmin, btm_y3, norm_xmax, btm_y3]];

    if vertical_grids == 1
        top_line_matrix = v_top_line_matrix;
        btm_line_matrix = v_btm_line_matrix;
    else
        top_line_matrix = h_top_line_matrix;
        btm_line_matrix = h_btm_line_matrix;
    end
end
    
    
    