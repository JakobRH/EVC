%
% Copyright 2019 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[matrix_translate, matrix_rotate, matrix_scale, rotated_vertices, image1_vertices, image2_vertices, image3_vertices, image4_vertices] = Transformations()

%% General Hints:
% If you want to check your implementation you can:
% -) Set a breakpoint to access variables at a certain point in the script.
% You can inspect their contents in the 'Workspace' window to the right.
% -) Leave out the ';' at the end of a statement/line so the result will be
% printed out in the command window.
% -) Do not rename the predefined variables, or else our test-system won't
% work (which is bad for both parties ;) )

close all; % used for closing figures on each re-run

%% I. Transformations and Plotting

% 1) Implement the following matrix functions. They can be found at the
% bottom of the file
matrix_translate = mtranslate(1, 2);
matrix_rotate = mrotate(45);
matrix_scale = mscale(2, 3);

% 2) Finish the display_vertices function
quad = [0, 0, 1; 1, 0, 1; 1, 1, 1; 0, 1, 1; 0, 0, 1]';
display_vertices(quad, 11, 'Original Quad');

% 3) Implement the transform_vertices function
rotated_vertices = transform_vertices(quad, matrix_rotate);
display_vertices(rotated_vertices, 12, 'Rotated Quad');

% 4) Edit the next 4 lines and use the implemented functions to produce
% the Target Images 1-4 (see instructions) and display them.
% Please recall that you are supposed to call the transform_vertices function only once per image.
temp_matrix1 = mrotate(180);
image1_vertices = transform_vertices(quad, temp_matrix1); % TODO: edit this
temp_matrix2 = mrotate(55)*mtranslate(-3,0);
image2_vertices = transform_vertices(quad, temp_matrix2); % TODO: edit this
temp_matrix3 =mtranslate(2,1)* mrotate(-30)*mscale(2,1);
image3_vertices = transform_vertices(quad, temp_matrix3); % TODO: edit this
temp_matrix4 = mscale(1,(3*sqrt(2)/sqrt(2)))*mrotate(45);
image4_vertices = transform_vertices(quad, temp_matrix4); % TODO: edit this

display_vertices(image1_vertices, 13, 'Target Image 1');
display_vertices(image2_vertices, 14, 'Target Image 2');
display_vertices(image3_vertices, 15, 'Target Image 3');
display_vertices(image4_vertices, 16, 'Target Image 4');

end

% Returns a 3x3 translation matrix
% tx, ty: translation along x and y
function[matrix] = mtranslate(tx, ty)

% TODO: Implement this function
matrix = [1,0,tx;0,1,ty;0,0,1];

end

% Returns a 3x3 counter-clockwise rotation matrix
% angle: rotation angle in degrees
function[matrix] = mrotate(angle)

% TODO: Implement this function
matrix = [cosd(angle), -sind(angle),0; sind(angle), cosd(angle),0; 0,0,1];

end

% Returns a 3x3 scaling matrix
% sx, sy: scaling in x and y direction
function[matrix] = mscale(sx, sy)

% TODO: Implement this function
matrix = [sx,0,0;0,sy,0;0,0,1];

end

%Displays a list of vertices
%v: list of vertices ([x1, x2, x3, ...; y1, y2, y3, ...; 1, 1, 1, ....;)
%id: figure id
%head: title of the figure
function[] = display_vertices(v, id, head)

%Create new figure
figure(id);
clf;
%Set title
title(head);
%Fix axis and set aspect ratio
axis([-5, 5, -5, 5]);
pbaspect([1, 1, 1]);

%Plot coordinate axis
hold on;
plot([-100, 100], [0, 0], '-g');
plot([0, 0], [-100, 100], '-g');

% TODO: Display the vertices (v) using the plot function

plot(v(1,:),v(2,:),'-b');
%Finish drawing
hold off;

end

% Transforms a list of vertices by a matrix
% v: list of vertices ([x1, x2, x3, ...; y1, y2, y3, ...; 1, 1, 1, ....;)
% m: transformation matrix
% Returns a list of transformed vertices of the same size as v
function[result] = transform_vertices(v, m)

% TODO: Implement this function
result = m*v;

end