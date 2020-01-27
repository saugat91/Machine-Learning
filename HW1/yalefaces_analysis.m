%Saugat Dawadi
%CS 383 Assignment 1
%yalefaces, Problem 2
clear all;

%in order for this to work, the pictures should be inside the folder
%"yalefaces" in the current directory

%Gets a pattern
pattern = fullfile("yalefaces", 'subject*.*');
theFiles = dir(pattern); %gets the files from the directory
cell = struct2cell(theFiles); %puts the name of the files from struct to cell format
filenames = [" "]; %array holding filenames
imageMatrix = zeros(154,1600); %holds the entire image matrix for 154 images

for i = 1:length(theFiles) %iterates once for each file
    filenames(1,i) = string(cell(1,i));  %gets the name of the file
    read_images = imread("yalefaces/" + filenames(1,i)); %reads the named image
    resized_image = imresize(read_images,[40,40]); %resizes image
    row_vector = resized_image(:)'; %appending the resized image matrix
    imageMatrix(i,:) = row_vector(1,:); %puts into the imagematrix    
end

Mean = mean(imageMatrix);
SD = std(imageMatrix,0,1);
standarizedMatrix = (imageMatrix-Mean)./SD %standarizes the 154x1600 matrix


%[standarizedMatrix, Mu, Sigma] = zscore(imageMatrix,0,'all'); %standarizes the 154x1600 matrix

covMatrix = cov(standarizedMatrix); %gets the covriant matrix for

[evectors,evalues] = eig(covMatrix); %gets eigenvectors and eigenvalues

etranspose = evectors.'; %transposes the eigenvector

selectedCol1 = evectors(:,end);%gets the final col, which has the biggest eigenvalue
selectedCol2 = evectors(:,end-1);%gets the second last column, which has the second biggest eigenvalue

values1 = standarizedMatrix * selectedCol1; %matrix multiplication for x-coords
values2 = standarizedMatrix * selectedCol2;%matrix multiplication for y-coords

scatter(values1, values2) %plots the scatterplot
title("sd984 HW1-2");






