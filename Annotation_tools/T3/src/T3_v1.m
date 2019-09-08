clear;

% make sure you modify these paths
addpath(genpath('../utils'));
addpath(genpath('../Example'));

image_path = '../img';
out_path = '../out';

allFiles = dir(image_path);
allNames = { allFiles.name };

start = input('Which image would you like to start with?')
noOfImages = input('How many images would you like to annotate?')

start = start + 2;
finish = start + (noOfImages-1);
for j = start:finish
    allNames{j}
    %load an image
    img = imread([image_path '/' allNames{j}]);  
    img_h = size(img,1);
    img_w = size(img,2);
    
    close('all');
    imshow(img);
    
    %prompt for number of groundtruth
    n = input('How many unannotated word(s) is/are there?')    
    count = n
    gt = {};
    %Poly GT
    for i = 1:n
        close('all');                
        imshow(img);
        %%%%prompt for bounding box%%%%%%%
        [x,y] = ginput(2);
        x = int16(x);
        y = int16(y);
        xmin = min(max(min(x), 1), img_w);
        xmax = min(max(max(x), 1), img_w);
        ymin = min(max(min(y), 1), img_h);
        ymax = min(max(max(y), 1), img_h);
        
        %%%%crop out the image patch%%%%%
        imgPatch = img(ymin:ymax, xmin:xmax, :);
        
        %%%%prompt for 4 pts
        [first_x, third_x, fourth_x, sixth_x, first_y, third_y, fourth_y, sixth_y, top_line_matrix, btm_line_matrix] = reannotate(imgPatch, xmin, ymin, xmax, ymax);
        
        close('all')    
        fprintf('Red to yellow. \n')
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
        
        text = input('What is the transcription?','s');
        ornt = input('What is the orientation?','s');
        tmp_output = { 'x:', new_gt_x, 'y:', new_gt_y, text, ornt}
        gt = [gt ; tmp_output];
        
        count = count - 1
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
    end
    gt_name = strsplit(allNames{j}, '.');
    GT_savepath = strcat(out_path, '/gt_', gt_name(1), '.mat');
    save(GT_savepath{1},'gt');
    done_msg = strcat('Done with image ', int2str(j - 3));
    fprintf(done_msg); 
    
end