
%import data: gabor wavelet phi.mat and images dataset.mat.
phi = importdata('psi_hat_6x2x8.mat');
images1 = importdata('dataset.mat');
phi = phi_ex_fft;
images1 = class2;
K = size(phi,4);
s = size(phi,3);
width = size(images1,1);
n = size(images1,3);
n_moment = 2;

%parallel
p = gcp;
addAttachedFiles(p, {'myfeature.m','expand.m'});%maybe add path

%add another scale
f = zeros(n, K*s, n_moment);
parfor i = 1:n
    i
    f(i,:,:) = myfeature(images1(:,:,i), width, phi, n_moment);
    
end

for i = 1:n
    for j = 1:n_moment
        f(i,:,j) = f(i,:,j)/norm(f(i,:,j),1);
    end
end
save('/mnt/home/hejieqia/Gabor_EMD/feature_orig_data/f_16x5x4.mat','f');