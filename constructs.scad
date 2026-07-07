// this is all of the resusable elements

module negative_text (string ="test", height = 10, depth = 1, text_size= 10) {

    translate([0,0,height-1]) {
        linear_extrude(depth + 1) {
            text(string, size=text_size, font="Liberation Sans:style=Bold", halign = "center", valign = "center");
        }
    }
}

module poly_path(deltas) {
    points = build_points(deltas);
    polygon(points);
}

function build_points(deltas, index = 0, points = [[0, 0]]) =
    index >= len(deltas)
        ? points
        : build_points(
            deltas,
            index + 1,
            concat(points, [calc_point(points[len(points) - 1], deltas[index])])
        );

function calc_point(point, delta) = [point[0] + delta[0], point[1] + delta[1]];