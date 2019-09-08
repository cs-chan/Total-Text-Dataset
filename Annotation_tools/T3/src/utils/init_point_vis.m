function img_patch = init_point_vis(img_patch, first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, xmin, ymin)
    %%normalize 'em bitch
    first_x = max(first_x, xmin) - xmin;
    third_x = max(third_x, xmin) - xmin;
    fourth_x = max(fourth_x, xmin) - xmin;
    sixth_x = max(sixth_x, xmin) - xmin;
    first_y = max(first_y, ymin) - ymin;
    third_y = max(third_y, ymin) - ymin;
    fourth_y = max(fourth_y, ymin) - ymin;
    sixth_y = max(sixth_y, ymin) - ymin;
    img_patch = insertShape(img_patch, 'Circle', [first_x first_y 1], 'Color', 'red', 'LineWidth', 3);
    img_patch = insertShape(img_patch, 'Circle', [third_x third_y 1], 'Color', 'green', 'LineWidth', 3);
    img_patch = insertShape(img_patch, 'Circle', [fourth_x fourth_y 1], 'Color', 'blue', 'LineWidth', 3);
    img_patch = insertShape(img_patch, 'Circle', [sixth_x sixth_y 1], 'Color', 'yellow', 'LineWidth', 3);
end