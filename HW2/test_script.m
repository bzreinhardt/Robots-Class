%test script for integrateOdom - simple situations

X_0 = [0;0;0];

d = [pi/2,pi/2,pi/2,pi/2];
phi = [pi/2,pi/2,pi/2,pi/2];

X_f = integrateOdom(X_0,d,phi);

figure(1);clf;
plot(X_f(1,:),X_f(2,:))