%This function can expand images and compute the wavelet transform. Input
%image is a two dimensional matrix, width is the width of expansion on each
%side, phi is the Gabor wavelet function(either direct wavelet or fft form, 
%n_moment is the number of moments we want to calculated. Output 
%wave_form_mean is the feature vector of this image. 
function wave_form_mean = myfeature(image, width, psi_hat, n_moment)
w = width;
image_size = size(image);
%expand image
if width > image_size(1)
    w = image_size(1);
end
image_ex = pad(image,w,0);

%build feature vector
s = size(psi_hat,3); %totalscale number
K = size(psi_hat,4); %total rotation number
f = zeros(s,K,n_moment);

%{
W0 = wave_trans_freq(image_ex,phi0);
W0 = W0(w+1:w+image_size(1),w+1:w+image_size(1));
f0 = zeros(1,n_moment);
f0(1) = mean(mean(abs(W0)));
st = (abs(W0) - f0(1) * ones(image_size(1))).^2;
f0(2) = sqrt(mean(mean(st)));
if n_moment > 2
    for i = 3:n_moment
        f0(i) = mean(mean( ( abs((abs(W0) - f0(1)) /f0(2) )) ^i));
    end
end
%}
for m = 1:s
    for n = 1:K
         %Current wavelet transform: convolution of image and wavelet, need to be cut
        W = wave_trans_freq(image_ex,psi_hat(:,:,m,n));
        %W = conv2(image_ex,phi(:,:,m,n),'same');
        
        %cut W_cur to get wavelet transform
        W = W(w+1:w+image_size(1),w+1:w+image_size(1));
        l = size(W,1);
        
        %calculate features
        %standarlized
        f(m,n,1) = mean(mean(abs(W)));
        st = (abs(W) - f(m,n,1) * ones(l)).^2;
        f(m,n,2) = sqrt(mean(mean(st)));
        if n_moment > 2
            for i = 3:n_moment
                f(m,n,i) = mean(mean( ( abs((abs(W) - f(m,n,1)) /f(m,n,2) )) ^i));
            end
        end
        %non_standarlized
        %{
        
         for i = 1:n_moment
             f(m,n,i) = mean(mean(abs(W)^i));
         end
        %}
        
        
    end
end
wave_form_mean = reshape(f,[K*s,n_moment]);
%wave_form_mean = [f0;wave_form_mean];
