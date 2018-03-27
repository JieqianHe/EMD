f = importdata('f_6x2x8_normalized.mat');
ground_dist = importdata('ground_dist_6x2x8.mat');
n_moment = size(f,3);

%p = gcp;
%addAttachedFiles(p, {'EMD_distance.m','emd_mex.mexa64'});%maybe add path

%calculate EMD
n = size(f,1);
EMD_matrix = zeros(n,n,n_moment);
for i = 1:(n-1)
    for j = (i+1):n
        for k = 1:n_moment
            EMD_matrix(i,j,k) = emd_mex(f(i,:,k),f(j,:,k),ground_dist); 
        end
    end 
    i
end


for k = 1:n_moment
    for i = 1:(n-1)
        for j = (i+1):n
            test(j,i,k) = test(i,j,k);
        end
    end
end

save('/mnt/home/hejieqia/Gabor_EMD/feature_orig_data/EMD_produce/EMD_matrix.mat','EMD_matrix');