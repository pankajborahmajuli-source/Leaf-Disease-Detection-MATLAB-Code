clc; 
clear;

% Step 1: Load the image
[filename, pathname] = uigetfile({'*.jpg;*.png;*.jpeg'}, 'Select an Image');
img = imread(fullfile(pathname, filename));
figure, imshow(img), title('Original Image')

% Step 2: Convert to HSV
hsvImg = rgb2hsv(img);
H = hsvImg(:,:,1);
S = hsvImg(:,:,2);
V = hsvImg(:,:,3);

% % Step 3: Create mask for diseased regions
% maskH = (H > 0.05) & (H < 0.15);
% maskS = (S > 0.6);
% maskV = (V > 0.6) & (V < 0.85);
% diseaseMask = maskH & maskS & maskV;


%Original  Step 3: Create mask for diseased regions
maskH = (H > 0.05) & (H < 0.15);
maskS = (S > 0.2);
maskV = (V > 0.2) & (V < 0.85);
diseaseMask = maskH & maskS & maskV;

% Step 4: Clean the mask
cleanMask = imopen(diseaseMask, strel('disk', 2));
cleanMask = imclose(cleanMask, strel('disk', 4));
cleanMask = imfill(cleanMask, 'holes');

% Step 5: Leaf mask (whole leaf)
grayLeaf = rgb2gray(img);
level = graythresh(grayLeaf);
leafMask = im2bw(grayLeaf, level);  % For MATLAB 2014
leafMask = imfill(leafMask, 'holes');
leafMask = imopen(leafMask, strel('disk', 10));

% Step 6: Healthy (white) and diseased (black) output
healthyLeafMask = leafMask & ~cleanMask;

% Step 7: Side-by-side display
figure;
%subplot(1,2,1);
imshow(img);
title('Original Leaf Image');

%subplot(1,2,2);
imshow(healthyLeafMask);
title('Diseased (in Black) Detect Mask');

% Step 8: Save output
imwrite(healthyLeafMask, 'Healthy_vs_Diseased_BW.png');

% Step 9: Area Calculation
diseaseArea = sum(cleanMask(:));
leafArea = sum(leafMask(:));

fprintf('Disease Area (pixels): %d\n', diseaseArea);
fprintf('Leaf Area (pixels): %d\n', leafArea);

if leafArea > 0
    diseasePercent = (diseaseArea / leafArea) * 100;
else
    diseasePercent = 0;
end

fprintf('Percentage of Diseased Area: %.2f%%\n', diseasePercent);
