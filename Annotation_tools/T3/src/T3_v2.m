clearvars;
close all;

%% Path configuration %%
% gtPath: Path to groundtruth directory
% infPath: Path to prediction directory 
% fidPath: A text file directory to capture all individual results
imgPath = '../T3/Example/img';
predPath = '../T3/Example/suggestion';
outPath = '../T3/Example/out';

% This script will look to load your result files(infPath) based on what you have in
% gtPath.
allFiles = dir(imgPath);
allNames = { allFiles.name };

start = input('Which image would you like to start with?')
noOfImages = input('How many images would you like to annotate?')

start = start + 2;
finish = start + (noOfImages-1);

for i=start:finish
    disp(allNames{i})
    img = imread([imgPath '/' allNames{i}]);
    
    pred_name = strsplit(allNames{i}, '.');
%     pred_id = fopen([predPath '/' pred_name{1} '.txt']);
    
    pred_fid = fopen('/media/ckchng/1TBHDD/Dropbox/Total_Text++/T3/Example/suggestion/example_suggestions', 'r');
    pred = textscan(pred_fid,'%s','Delimiter','\n');
    pred = pred{1,1}; 
    fclose(pred_fid);
    gt = [];

    if (size(pred,1) >0) && (size(pred,2) >0)
    % For loop to run through every prediction 
        for k = 1:size(pred,1)
            rect_img = img;
            curr_pred = pred{k};
            curr_pred = split(curr_pred, ',');
            poly_x = int16(str2double(curr_pred(1:2:end)));
            poly_y = int16(str2double(curr_pred(2:2:end)));
            
            xmin = int16(max(min(poly_x), 1));
            xmax = int16(max(max(poly_x), 1));
            ymin = int16(max(min(poly_y), 1));
            ymax = int16(max(max(poly_y), 1));
            w = xmax - xmin;
            h = ymax - ymin;
            close all;
            imshow(img);
            hold on;
            r = rectangle('Position', [xmin, ymin, w, h]);
            set(r,'edgecolor','g');
            is_rect_alright = input('Is the text patch alright?(y/n) Options: 1) It is a background patch, remove it. 2) The prediction bbox doesnt bind text properly, reannotate the box.', 's')
            if is_rect_alright == 'n'
                continue;
            else
                %annotate (option 2)
                imgPatch = img(ymin:ymax, xmin:xmax, :);
                poly_x = (poly_x - xmin) + 1;
                poly_y = (poly_y - ymin) + 1;
                figure;
                imshow(imgPatch, 'InitialMagnification', 800);
                poly_vertices = [double(poly_x), double(poly_y)];
                h = impoly(gca, poly_vertices);

                close('all') 
                imshow(imgPatch, 'InitialMagnification', 800);
                [first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, top_line_matrix, btm_line_matrix] = reannotate(imgPatch, xmin, ymin, xmax, ymax);
                %%%%%%% grid being finalize, annotation starts%%%%%%%%
                close('all')    
                fprintf('Red to green. \n')
                top_img_patches = insertShape(imgPatch, 'Line', top_line_matrix, 'Color', 'yellow', 'LineWidth', 3);
                top_img_patches = init_point_vis(top_img_patches, first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, xmin, ymin);
                imshow(top_img_patches, 'InitialMagnification', 800);

                [x, y] = getpts;
                x = max(x, 1);
                y = max(y, 1);
                %scale it back
                x0 = first_x;
                x1 = x(1) + xmin;
                x2 = x(2) + xmin;
                x3 = x(3) + xmin;
                x4 = third_x;

                y0 = first_y;
                y1 = y(1) + ymin;
                y2 = y(2) + ymin;
                y3 = y(3) + ymin;
                y4 = third_y;

                fprintf('Blue to yellow. \n')
                btm_img_patches = insertShape(imgPatch, 'Line', btm_line_matrix, 'Color', 'green', 'LineWidth', 3);
                btm_img_patches = init_point_vis(btm_img_patches, first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, xmin, ymin);
                close all;
                imshow(btm_img_patches, 'InitialMagnification', 800);

                [x, y] = getpts;
                x = max(x, 1);
                y = max(y, 1);
                %scale it back
                x9 = sixth_x;
                x8 = x(1) + xmin;
                x7 = x(2) + xmin;
                x6 = x(3) + xmin;
                x5 = fourth_x;

                y9 = sixth_y;
                y8 = y(1) + ymin;
                y7 = y(2) + ymin;
                y6 = y(3) + ymin;
                y5 = fourth_y;

                new_gt_x = reshape([x0, x1, x2, x3, x4, x5, x6, x7, x8, x9], [], 1);
                new_gt_y = reshape([y0, y1, y2, y3, y4, y5, y6, y7, y8, y9], [], 1);
                text = input('What is the text?','s');
                ornt = input('What is the orientation?','s');
                tmp_output = {'x:', new_gt_x, 'y:', new_gt_y, text, ornt};
                gt = [gt ; tmp_output];
            end
        end
    end
    %%% display image with annotation%%%%
    for gt_id = 1:size(gt, 1)
        reshaped_pred = [];
        curr_x = gt{gt_id, 2};
        curr_y = gt{gt_id, 4};
        curr_xy = [curr_x, curr_y];
        
        % insertShape requirement [x1, y1, x2, y2 .... xn, yn]
        for i = 1:size(curr_xy, 1)
            reshaped_pred = [reshaped_pred, curr_xy(i, :)];            
        end
        
        img = insertShape(img, 'Polygon', reshaped_pred, 'LineWidth',5, 'Color', {'green'});
    end
    close all;
    imshow(img);
    
    %%Ask if there are any left out patches%%
    left_out = input('Is there any left out instances?', 's');
    if left_out == 'y'
        left_out_count = input('How many of them were unannotated?', 's');
        left_out_count = str2double(left_out_count);
        for count = 1:left_out_count
            [x,y] = ginput(2);
            x = int16(x);
            y = int16(y);
            ymin = max(min(y), 1);
            xmin = max(min(x), 1);
            ymax = max(max(y), 1);
            xmax = max(max(x), 1);
            img_patches = img(ymin:ymax, xmin:xmax, :);

            close('all') 
            imshow(img_patches, 'InitialMagnification', 800);
            [first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, top_line_matrix, btm_line_matrix] = reannotate(img_patches, xmin, ymin, xmax, ymax);
            %%%%%%% grid being finalize, annotation starts%%%%%%%%
            close('all')    
            fprintf('Red to green. \n')
            top_img_patches = insertShape(img_patches, 'Line', top_line_matrix, 'Color', 'yellow', 'LineWidth', 3);
            top_img_patches = init_point_vis(top_img_patches, first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, xmin, ymin);
            imshow(top_img_patches, 'InitialMagnification', 800);

            [x, y] = getpts;
            x = max(x, 1);
            y = max(y, 1);
            %scale it back
            x0 = first_x;
            x1 = x(1) + xmin;
            x2 = x(2) + xmin;
            x3 = x(3) + xmin;
            x4 = third_x;

            y0 = first_y;
            y1 = y(1) + ymin;
            y2 = y(2) + ymin;
            y3 = y(3) + ymin;
            y4 = third_y;

            fprintf('Blue to yellow. \n')
            btm_img_patches = insertShape(img_patches, 'Line', btm_line_matrix, 'Color', 'green', 'LineWidth', 3);
            btm_img_patches = init_point_vis(btm_img_patches, first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, xmin, ymin);
            close all;
            imshow(btm_img_patches, 'InitialMagnification', 800);

            [x, y] = getpts;
            x = max(x, 1);
            y = max(y, 1);
            %scale it back
            x9 = sixth_x;
            x8 = x(1) + xmin;
            x7 = x(2) + xmin;
            x6 = x(3) + xmin;
            x5 = fourth_x;

            y9 = sixth_y;
            y8 = y(1) + ymin;
            y7 = y(2) + ymin;
            y6 = y(3) + ymin;
            y5 = fourth_y;

            new_gt_x = reshape([x0, x1, x2, x3, x4, x5, x6, x7, x8, x9], [], 1);
            new_gt_y = reshape([y0, y1, y2, y3, y4, y5, y6, y7, y8, y9], [], 1);
            
            text = input('What is the text?','s');
            ornt = input('What is the orientation?','s');
            tmp_output = {'x:', new_gt_x, 'y:', new_gt_y, text, ornt}
            gt = [gt ; tmp_output]
            
            for gt_id = 1:size(gt, 1)
                reshaped_pred = [];
                curr_x = gt{gt_id, 2};
                curr_y = gt{gt_id, 4};
                curr_xy = [curr_x, curr_y];
                % insertShape requirement [x1, y1, x2, y2 .... xn, yn]
                for i = 1:size(curr_xy, 1)
                    reshaped_pred = [reshaped_pred, curr_xy(i, :)];            
                end
        
                img = insertShape(img, 'Polygon', reshaped_pred, 'LineWidth',5, 'Color', {'green'});
            end
            close all;
            imshow(img);
        end
    end
    gt_savepath = strcat(outPath, '/gt_', pred_name{1});
    save(gt_savepath, 'gt');
end

