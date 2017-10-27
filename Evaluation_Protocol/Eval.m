%% Evaluation method for Total-Text.  
% Chee Kheng Ch'ng and Chee Seng Chan.
% "Total-Text:  A Comprehensive Dataset for Scene Text Detection and
% Recognition.
% It's built on top of Wolf & Jolion's method. 
% Wolf, Christian, and Jean-Michel Jolion. 
% "Object count/area graphs for the evaluation of object detection and segmentation algorithms." 
% International Journal of Document Analysis and Recognition (IJDAR) 8.4 (2006): 280-296.
%

%% Initialization

clearvars;
close all;

%% Path configuration %%
% gtPath: Path to groundtruth directory
% infPath: Path to prediction directory 
% fidPath: A text file directory to capture all individual results
gtPath = '/home/ck/Dropbox/Evaluation_Protocol/Examples/Groundtruth';
predPath = '/home/ck/Dropbox/Evaluation_Protocol/Examples/Prediction';
fidPath = '/home/ck/Dropbox/Evaluation_Protocol/Examples/Result.txt';

% This script will look to load your result files(infPath) based on what you have in
% gtPath.
allFiles = dir(gtPath);
allNames = { allFiles.name };

% constants
tr = 0.8;   % recall threshold
tp = 0.4;   % precision threshold
k_t = 2;      % min number of matches, used in penalizing split & merge
fsc_k = 0.8;    % penalize value of split or merge

%% Prepare overlap matrices
numFiles_test = numel(allNames) - 2;
sigma = cell(numFiles_test,1);  % overlap matrix recall
tau = cell(numFiles_test,1);    % overlap matrix precision

for i=3:(numFiles_test + 2)
    % Outer for loop to run through every groundtruth mat files.
    disp(allNames{i})
    
    gt = load([gtPath '/' allNames{i}]);
    pred_name = strsplit(allNames{i}, '_');
    pred = load([predPath '/' pred_name{3}]);
    %We stored our groundtruth and prediction result in structure, feel
    %free too change according to your need.
    gt = gt.polygt;
    pred = pred.accuInf;
    
    % Get the number of polygon boundaries in result file
    numPolyinTestData = size(pred,1);

    % Get the number of polygon boundaries in ground truth file
    numPolyinGTData = size(gt,1);

    % initialized overlap matrices to zeros
    sigma{i-2} = zeros(numPolyinGTData, numPolyinTestData);
    tau{i-2} = zeros(numPolyinGTData, numPolyinTestData);
    clear gt_poly;
    for j = 1:size(gt,1)
        % For loop to run through groundtruth
        gt_Ph_x = gt{j,2}(:);
        gt_Ph_y = gt{j,4}(:);
        
        gt_poly(j).x_ = double(gt_Ph_x);
        gt_poly(j).y_ = double(gt_Ph_y);
        poly_gt_x = gt_poly(j).x_; poly_gt_y = gt_poly(j).y_;
        % The order of polygon points need to be clockwise
        if ~ispolycw(poly_gt_x, poly_gt_y)
            [poly_gt_x, poly_gt_y] = poly2cw(poly_gt_x, poly_gt_y);
        end

        gt_area = polyarea(poly_gt_x, poly_gt_y);
        clear pred_poly;
        % For loop to run through every prediction 
        for k = 1:size(pred,1)
            pred_Ph = pred{k};
            pred_poly(k).x_ = pred_Ph(:,1);
            pred_poly(k).y_ = pred_Ph(:,2);
            poly_pred_x = pred_poly(k).x_; poly_pred_y = pred_poly(k).y_;
            % The order of polygon points need to be clockwise
            if ~ispolycw(poly_pred_x, poly_pred_y)
                [poly_pred_x, poly_pred_y] = poly2cw(poly_pred_x, poly_pred_y);
            end

            pred_area = polyarea(poly_pred_x, poly_pred_y);

            % Get polygon intersection from two polygons
            [sx, sy] = polybool('intersection', poly_gt_x, poly_gt_y, poly_pred_x, poly_pred_y);

            if ~isempty(sx) || ~isempty(sx)
                % update sigma and tau if it is intercepted
                if isShapeMultipart(sx, sy)
                    % if the intersection has multi-part
                    [sx1,sy1] = polysplit(sx,sy);
                    intersec_area = 0;
                    for m=1:numel(sx1)
                        intersec_area = intersec_area + polyarea(sx1{m}, sy1{m});
                    end
                else
                    intersec_area = polyarea(sx, sy);
                end

                % compute intersection
                recall = intersec_area/gt_area;
                precision = intersec_area/pred_area;
                fid = fopen(fidPath, 'a');
                temp = ([allNames{i} ' ' mat2str(precision) ' ' mat2str(recall)  '\n']); 
                fprintf(fid,temp);
                fclose(fid);
                % fill in the overlap matrix
                sigma{i-2}(j, k) = recall;
                tau{i-2}(j, k) = precision;
            end
        end
    end
end

[ precision, recall ] = ComputePrecisionRecall( tau, sigma, tp,tr,k_t,fsc_k );

%% Display final result
disp(sprintf('\nPrecision = %f', precision));
disp(sprintf('Recall    = %f', recall));
f_score = 2*precision*recall/(precision+recall);
disp(sprintf('F-Score   = %f\n', f_score));

disp('Finish processing...');