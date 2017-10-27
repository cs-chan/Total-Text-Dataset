function [ precision, recall ] = ComputePrecisionRecall( tau, sigma, tp,tr,k,fsc_k )
%COMPUTEPRECISIONRECALL Summary of this function goes here
%   Detailed explanation goes here

if nargin == 2
    tr = 0.8;   % recall threshold
    tp = 0.4;   % precision threshold
    k = 2;      % min number of matches, used in penalizing split & merge
    fsc_k = 0.8;% penalize value of split or merge
end

tot_gt = 0;
recall_accum = 0;

tot_detected = 0;
precision_accum = 0;

num_images = numel(tau);
assert(num_images == numel(sigma));

flag_gt = cell(1, num_images);
flag_det = cell(1, num_images);

for ifile=1:num_images
    
    [num_gt, num_detected] = size( sigma{ifile} );
    tot_gt = tot_gt + num_gt;
    tot_detected = tot_detected + num_detected;
    
    % ----- mark unprocessed
    flag_gt{ifile} = zeros(num_gt, 1);
    flag_det{ifile} = zeros(num_detected, 1);
    
    % ---------------------------------------
    % check one-to-one match
    % ---------------------------------------
    for i_gt=1:num_gt
        
        num_detected_in_sigma = numel( find( sigma{ifile}(i_gt,:)>tr) );
        num_detected_in_tau = numel( find( tau{ifile}(i_gt,:)>tp) );
        
        if num_detected_in_sigma == 1 && num_detected_in_tau == 1
            recall_accum = recall_accum + 1.0;
            precision_accum = precision_accum + 1.0;
            
            % Mark the ground truth and detection, do not process twice
            flag_gt{ifile}(i_gt) = 1;
            idx_det = sigma{ifile}(i_gt,:)>tr;
            flag_det{ifile}(idx_det) = 1;
        end
    end
    
    % ---------------------------------------
    % check one-to-many match (split)
    % one gt with many detected rectangles
    % ---------------------------------------
    for i_gt=1:num_gt
        
        if flag_gt{ifile}(i_gt) > 0
            continue;
        end
        
        num_nonzero_in_sigma = sum( sigma{ifile}(i_gt,:)>0 );
        if num_nonzero_in_sigma >= k
            
            % -------------------------------------------------------------
            % Search the possible "many" partners for this	"one" rectangle
            % -------------------------------------------------------------
            
            % ----- satisfy 1st condition
            % only select unprocessed data
            idx_detected_in_tau = find( (tau{ifile}(i_gt,:)'>=tp) & (flag_det{ifile}==0) );
            num_detected_in_tau = numel( idx_detected_in_tau );
            
            if num_detected_in_tau == 1
                % Only one of the many-rectangles qualified ->
                % This match degraded to a one-to-one match
                if ( (tau{ifile}(i_gt, idx_detected_in_tau) >= tp) && ...
                        (sigma{ifile}(i_gt, idx_detected_in_tau) >= tr) )
                    recall_accum = recall_accum + 1.0;
                    precision_accum = precision_accum + 1.0;
                end
            else
                % satisfy 2nd condition
                if sum( sigma{ifile}(i_gt,idx_detected_in_tau) ) >= tr
                
                    % Mark the "one" rectangle
                    flag_gt{ifile}(i_gt) = 1;
                    
                    % Mark all the "many" rectangles
                    flag_det{ifile}(idx_detected_in_tau) = 1;
                    
                    recall_accum = recall_accum + fsc_k;
                    precision_accum = precision_accum + num_detected_in_tau * fsc_k;

                end
            end
            
        end
        
        % No match
        recall_accum = recall_accum + 0;
        precision_accum = precision_accum + 0;
        
    end
    
    % ---------------------------------------
    % check many-to-one match (merge)
    % one detected rectangle with many gt
    % ---------------------------------------
    for i_test=1:num_detected
        
        if flag_det{ifile}(i_test) > 0
            continue;
        end
        
        num_nonzero_in_tau = sum( tau{ifile}(:,i_test)>0 );
        if num_nonzero_in_tau >= k
            
            % satisfy 1st condition
            % only select unprocessed data
            idx_detected_in_sigma = find( (sigma{ifile}(:,i_test)>=tr) & (flag_gt{ifile}==0) );
            num_detected_in_sigma = numel( idx_detected_in_sigma );
            
            if num_detected_in_sigma == 1
                % Only one of the many-rectangles qualified ->
                % This match degraded to a one-to-one match
                if ( (tau{ifile}(idx_detected_in_sigma, i_test) >= tp) && ...
                        (sigma{ifile}(idx_detected_in_sigma, i_test) >= tr) )
                    recall_accum = recall_accum + 1.0;
                    precision_accum = precision_accum + 1.0;
                end
            else
                % satisfy 2nd condition
                if sum( tau{ifile}(idx_detected_in_sigma,i_test) ) >= tp
                    % Mark the "one" rectangle
                    flag_det{ifile}(i_test) = 1;
                    
                    % Mark all the "many" rectangles
                    flag_gt{ifile}(idx_detected_in_sigma) = 1;
                    
                    recall_accum = recall_accum + num_detected_in_sigma*fsc_k;
                    precision_accum = precision_accum + fsc_k;
%                     recall_accum = recall_accum + num_detected_in_sigma;
%                     precision_accum = precision_accum + 1.0;
                end
            end
            
        end
        
        % No match
        recall_accum = recall_accum + 0;
        precision_accum = precision_accum + 0;
    end
    
end
recall = recall_accum / tot_gt;
precision = precision_accum / tot_detected;

end

