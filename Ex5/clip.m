
%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [clipped_mesh] = clip(mesh, clipping_planes)
%CLIP clips all faces in the mesh M against every clipping plane defined in
%   clipplanes.
%     mesh              ... mesh object to clip
%     clipping_planes   ... array of clipping planes to clip against
%     clipped_mesh      ... clipped mesh

clipped_mesh = Mesh;

for f = 1:numel(mesh.faces)
    positions = mesh.getFace(f).getVertex(1:mesh.faces(f)).getPosition();
    colors = mesh.getFace(f).getVertex(1:mesh.faces(f)).getColor();
    vertex_count = 3;
    for i = 1:numel(clipping_planes)
        [vertex_count, positions, colors] = clipPlane(vertex_count, positions, colors, clipping_planes(i));
    end
    if vertex_count ~= 0
        clipped_mesh.addFace(vertex_count, positions, colors);
    end
end

end

function [vertex_count_clipped, pos_clipped, col_clipped] = clipPlane(vertex_count, positions, colors, clipping_plane)
%CLIPPLANE clips all vertices defined in positions against the clipping
%          plane clipping_plane. Clipping is done by using the Sutherland
%          Hodgman algorithm.
%     vertex_count          ... number of vertices of the face that is clipped
%     positions             ... n x 4 matrix with positions of n vertices
%                               one row corresponds to one vertex position
%     colors                ... n x 3 matrix with colors of n vertices
%                               one row corresponds to one vertex color
%     clipping_plane        ... plane to clip against
%     vertex_count_clipped  ... number of resulting vertices after clipping;
%                               this number depends on how the plane intersects
%                               with the face and therefore is not constant
%     pos_clipped           ... n x 4 matrix with positions of n clipped vertices
%                               one row corresponds to one vertex position
%     col_clipped           ... n x 3 matrix with colors of n clipped vertices
%                               one row corresponds to one vertex color

pos_clipped = zeros(vertex_count+1, 4);
col_clipped = zeros(vertex_count+1, 3);

% TODO 2:   Implement this function.
% HINT 1: 	Read the article about Sutherland Hodgman algorithm on Wikipedia.
%           https://en.wikipedia.org/wiki/Sutherland%E2%80%93Hodgman_algorithm
%           Read the tutorial.m for further explanations!
% HINT 2: 	There is an edge between every consecutive vertex in the positions
%       	matrix. Note: also between the last and first entry!

% NOTE:     The following lines can be removed. They prevent the framework
%           from crashing.

new_vertex_count = 0; 
    for i = 1 : vertex_count
        next_vertex = positions(i,:);
        next_color = colors(i,:); 
        if i == 1 
            pre_vertex = positions(vertex_count, :); 
            pre_color = colors(vertex_count, :); 
        else
            pre_vertex = positions(i-1,:); 
            pre_color = colors(i-1,:); 
        end
        t = intersect(clipping_plane, pre_vertex, next_vertex); 
        intersection = MeshVertex.mix(pre_vertex, next_vertex, t); 
        intersection_color = MeshVertex.mix(next_color, pre_color, t);
        
        if inside(clipping_plane, next_vertex)
            if ~inside(clipping_plane, pre_vertex)
                new_vertex_count = new_vertex_count + 1; 
                pos_clipped(new_vertex_count,:) = intersection; 
                col_clipped(new_vertex_count,:) = intersection_color; 
            end
            new_vertex_count = new_vertex_count + 1; 
            pos_clipped(new_vertex_count,:) = next_vertex; 
            col_clipped(new_vertex_count,:) = next_color; 
        elseif inside(clipping_plane, pre_vertex)
            new_vertex_count = new_vertex_count + 1; 
            pos_clipped(new_vertex_count,:) = intersection; 
            col_clipped(new_vertex_count,:) = intersection_color; 
        end
    end
    
    vertex_count_clipped = new_vertex_count; 
end
