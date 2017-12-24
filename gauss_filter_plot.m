%plot 3D
g1=Gaussian_filter(50,2);
g2=Gaussian_filter(50,7);
g3=Gaussian_filter(50,11);
figure(1);
subplot(1,3,1);surf(g1);title('filter size = 50, sigma = 2');
subplot(1,3,2);surf(g2);title('filter size = 50, sigma = 7');
subplot(1,3,3);surf(g3);title('filter size = 50, sigma = 100');