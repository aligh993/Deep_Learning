% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com
% Autoassociative Memory _ Neural Networks

close all;
clear all;
clc;


fileName = 'autoAsMemDataset.xlsx';
xlRange = {'A1:E6','H1:L6','O1:S6','V1:Z6','A10:E15',...
    'H10:L15','O10:S15','V10:Z15','A19:E24','H19:L24'};

x = inputdlg({'Enter Number of Samples to train  (from 3 to 10)',...
    'Choose Kind of Noise  (1 => None,  2 => 50% Occluded,  3 => 67% Occluded,  4 => Noisy Patterns (7 Pixels))'},...
    'Input', [1 55], {'3','1'});
x1 = str2num(x{1});

im = cell(1,x1);
P = cell(1,x1);
W = 0;


for i = 1:x1  % Train
    im{i} = xlsread(fileName, 1, xlRange{i});
    P{i} = im{i}(:);
    W = W + P{i}*P{i}';
end


if(x{2} == '1')  % No Noise
elseif(x{2} == '2')  % 50% Occluded
    for i = 1:x1
        im{i}(4:6,:) = 0;
    end
elseif(x{2} == '3')  % 67% Occluded
    for i = 1:x1
        im{i}(3:6,:) = 0;
    end
elseif(x{2} == '4')  % Noisy Patterns (7 Pixels)
    m1 = ones(6,5);
    for i=1:7
        rnd = randi([1 30]);
        while(m1(rnd) == -1)
            rnd = randi([1 30]);
        end
        m1(rnd) = -1;
    end
    for i = 1:x1
        im{i} = im{i}.*m1;
    end
end


for i = 1:x1  % Test
    Pi = im{i}(:);
    A = hardlims(W*Pi);
    
    out = reshape(A,[6 5]);  out = imcomplement(out);
    figure,  im{i} = imcomplement(im{i});
    subplot(1,2,1); imshow(im{i}); title("Input Number: "+(i-1));
    subplot(1,2,2); imshow(out); title("Output");
end

