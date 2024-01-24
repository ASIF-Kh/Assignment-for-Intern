clc
clear all
close all

% Load grayscale image
originalImage = imread("coins.png"); % Replace with your image filename
originalImage = im2gray(originalImage);

% Convert to double for k-means
originalImage = double(originalImage);

% Reshape the image to a column vector for k-means
[m, n] = size(originalImage);
reshapedImage = reshape(originalImage, m * n, 1);

% Number of clusters for k-means
numClusters = 2;

% Apply k-means clustering
[idx, centers] = kmeans(reshapedImage, numClusters);

% Reshape the index back to the original image size
segmentedIndex = reshape(idx, m, n);

% Create segmented image using the cluster centers
segmentedImage = zeros(size(originalImage));
for i = 1:numClusters
    segmentedMask = segmentedIndex == i;
    segmentedImage(segmentedMask) = centers(i);
end

segmentedImagewithInFill = imfill(segmentedImage);



% Display the original and segmented images
subplot(1, 3, 1), imshow(originalImage, []), title('Original Image');
subplot(1, 3, 2), imshow(segmentedImage, []), title('Segmented Image');
subplot(1, 3, 3), imshow(segmentedImagewithInFill, []), title('Segmented Image with infill');

