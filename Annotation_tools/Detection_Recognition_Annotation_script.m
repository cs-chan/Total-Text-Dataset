clear;
image_path = ''; %image directory
out_path = ''; %save directory

allFiles = dir(image_path);
allNames = { allFiles.name };

start = input('Which image would you like to start with?')
noOfImages = input('How many images would you like to annotate?')

start = start + 3;
finish = start + (noOfImages-1);
for j = start:finish
    allNames{j}
    %load an image
    disp = imread([image_path '/' allNames{j}]);
    close('all');
    imshow(disp);
  
    polygt = [];
    %prompt for number of groundtruth
    n = input('How many unannotated word(s) is/are there?')    
    count = n; %to keep track of how many ground-truths left to be annotated
    %Poly GT
    for i = 1:n
        %%%the part where you get you annotate the spatial location in
        %%%polygon format
        h = impoly(gca); 
        pos = getPosition(h);
        pos = int16(pos);
        posT = pos.';
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        text = input('What is the text?','s'); %transcription annotation
        ornt = input('What is the orientation?','s'); %orientation annotation
        poly_output = { 'x:', posT(1,:), 'y:', posT(2,:), text, ornt}
        polygt = [polygt ; poly_output] 
        
        count = count - 1 %counter update
    end
    
    gt_name = strsplit(allNames{j}, '.');
    GT_savepath = strcat(out_path, '/Polygon/poly_gt_', gt_name(1), '.mat');
    save(GT_savepath{1},'polygt');

    imshow(disp);
    disp_poly(polygt);
    dummy = input('Is it alright? Press any key to move on.', 's')
    close('all');
end



        
    
    
    
    

    
    
    

