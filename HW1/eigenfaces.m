%Saugat Dawadi
%CS 383 Assignment 1
%eigenfaces, Problem 3

clear all;
pattern = fullfile("yalefaces", 'subject*.*');
theFiles = dir(pattern);
cell = struct2cell(theFiles);
filenames = [" "];
imageMatrix = zeros(154,1600);

for i = 1:length(theFiles)
    filenames(1,i) = string(cell(1,i));  
    read_images = imread("yalefaces/" + filenames(1,i));
    subject2 = imread("yalefaces/" + filenames(1,1)); %%%I load the subject2 here
    resized_image = imresize(read_images,[40,40]);
    row_vector = resized_image(:)';
    imageMatrix(i,:) = row_vector(1,:);    
end

Mean = mean(imageMatrix);
SD = std(imageMatrix,0,1);
standarizedMatrix = (imageMatrix-Mean)./SD;

covMatrix = cov(standarizedMatrix);

[evectors,evalues] = eig(covMatrix);

etranspose = evectors.';
%%%%%%%%%%%%%% Used the same code as eigenfaces.m until here. comments
%%%%%%%%%%%%%% there explain the code %%%



video = VideoWriter("sd984_video.avi"); %%calls the videowriter class
open(video);
resizedS2 = imresize(subject2,[40,40]); %%resizes the Subject2 image
rowS2 = resized_image(:)';

rowS2 = double(rowS2);
standarizedSubject2 = ((rowS2 - Mean)./SD); %%Standarizes the subject2 image

pca = []; %%empty set, where it adds eigenvector every iteration
for j = 1:1600
    pca = [pca, evectors(:,j)];
    projected = standarizedSubject2*pca;
    original = projected * transpose(pca);
    unStandarize = (original.*SD) + Mean;
    smallImage = reshape(unStandarize, 40,40);
    writeVideo(video, uint8(smallImage));
end
close(video);




