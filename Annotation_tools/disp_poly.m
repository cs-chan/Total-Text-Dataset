function disp_poly(polygon)
    dims = size(polygon);
    for i = 1:dims(1)
        x = reshape(polygon{i,2}, [], 1);
        y = reshape(polygon{i,4}, [], 1);
        poly_vertices = [x, y];
        h(1) = impoly(gca, poly_vertices);
    end
end
