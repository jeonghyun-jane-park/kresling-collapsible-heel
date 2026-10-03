clearvars
m = 6;
a = 3;
b = 4.249;
% beta = acos(a/(2*b)*(1-1/cos(pi/2-pi/m)));  % for dual tensegrity geometry: phi = pi/2 - pi/m.
beta = deg2rad(110.5);
%5.318
%



ch = -1; % chirality = 1 or -1

r = a/2/sin(pi/m); % radius of circumscribed circle
d = sqrt(a^2+b^2-2*a*b*cos(beta));

if round((1-2*b/a*cos(beta))*sin(pi/m),10)<=1
    phi = (asin(round((1-2*b/a*cos(beta))*sin(pi/m),10)) - pi/m)*ch; % phi1 (high)
    phi1 = rad2deg(phi);
    % phi = (pi - asin(round((1-2*b/a*cos(beta))*sin(pi/m),10)) - pi/m)*ch; % phi2 (low)
else
    disp('Config. does not exist! (phi)')
end

if b^2-2*r^2+2*r^2*cos(phi)>=0
    h = sqrt(b^2-2*r^2+2*r^2*cos(phi));
else
    disp('Config. does not exist! (h)')
end

v = zeros(m*2,3);
[v(1:m,1), v(1:m,2), v(1:m,3)] = pol2cart(linspace(0,2*pi*(m-1)/m,m),r,0);
[v(m+1:2*m,1), v(m+1:2*m,2), v(m+1:2*m,3)] = pol2cart(phi+linspace(0,2*pi*(m-1)/m,m),r,h);

f = zeros(m*2,3);
for k=1:m % index of parallelogram
    if k < m
        kp1 = k+1;
    elseif k == m
        kp1 = 1;
    end

    if ch == 1
        f(k*2-1,:) = [k,kp1+m,k+m];
        f(k*2,:) = [k,kp1,kp1+m];
    elseif ch == -1
        f(k*2-1,:) = [k,kp1,k+m];
        f(k*2,:) = [kp1,kp1+m,k+m];
    end
end

figure(1); set(clf,'Color','w');
patch(struct('faces',f([1:4:end,2:4:end],:),'vertices',v), 'FaceColor',[255,165,0]/255, 'LineWidth',1.0);
patch(struct('faces',f([3:4:end,4:4:end],:),'vertices',v), 'FaceColor',[0.4,0.4,0.4], 'LineWidth',1.0);
box on; axis equal tight; set(gca,'tickdir','in','FontSize',18,'Linewidth',1.2); hold on
xlabel('$x$','Color','k','FontSize',24,'interpreter','latex')
ylabel('$y$','Color','k','FontSize',24,'interpreter','latex')
zlabel('$z$','Color','k','FontSize',24,'interpreter','latex')
view([1,1,1])
material dull
light('Position', [1,1,1])

