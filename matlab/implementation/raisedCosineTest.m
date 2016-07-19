time = -1.5:0.01:1.5;

figure;
hold all;
plot(time, raised_cosine(time, 1, 0));
plot(time, raised_cosine(time, 1, 0.1));
plot(time, raised_cosine(time, 1, 0.5));
plot(time, raised_cosine(time, 1, 1.0));
hold off;
axis([-2 2 -0.1 1.5]);