%Wavelet transform in frequency
%Input: padded image, padded wavelet phi_ex
function W = wave_trans_freq(image_ex, phi_ex_fft)

%compute Fourier transform of W(shift first)
Wf = fft2(fftshift(image_ex)) .* fftshift(phi_ex_fft);

%inverse Fourier transform and shift back
W = fftshift(ifft2(Wf));