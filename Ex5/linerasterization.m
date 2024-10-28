%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function linerasterization(mesh, framebuffer)
%LINERASTERIZATION iterates over all faces of mesh and draws lines between
%                  their vertices.
%     mesh                  ... mesh object to rasterize
%     framebuffer           ... framebuffer

for i = 1:numel(mesh.faces)
    for j = 1:mesh.faces(i)
        v1 = mesh.getFace(i).getVertex(j);
        v2 = mesh.getFace(i).getVertex(mod(j, mesh.faces(i))+1);
        drawLine(framebuffer, v1, v2);
    end
end
end

function drawLine(framebuffer, v1, v2)
%DRAWLINE draws a line between v1 and v2 into the framebuffer using the DDA
%         algorithm.
%         ATTENTION: Coordinates of the line have to be rounded with the
%         function 'round(...)'.
%     framebuffer           ... framebuffer
%     v1                    ... vertex 1
%     v2                    ... vertex 2

[x1, y1, depth1] = v1.getScreenCoordinates();
[x2, y2, depth2] = v2.getScreenCoordinates();
v1Color = v1.getColor(); 
v2Color = v2.getColor(); 
dx = abs(x2 - x1);
dy = abs(y2 - y1);
m = dy/dx;
signX = 1;
signY = 1;

if x1 > x2
    signX = -1;
end    
if y1 > y2
    signY = -1;
end    

if m <= 1
    for i = 0 : dx
        t = i / dx;
        framebuffer.setPixel(round(x1 + i * signX), round(y1 + i * m * signY), MeshVertex.mix(depth1, depth2, t), MeshVertex.mix(v1Color, v2Color, t));
    end
else 
    for i = 0 : dy
        t = i / dy;
        %if dx equals 0 because then m is NaN
        m_new = max(m, 0.000000001 );
        framebuffer.setPixel(round(x1 + i / m_new * signX), round(y1 + i * signY), MeshVertex.mix(depth1, depth2, t), MeshVertex.mix(v1Color, v2Color, t));
    end
end

% TODO 1: Implement this function.
% BONUS:  Solve this task without using loops and without using loop
%         emulating functions (e.g. arrayfun).

end
