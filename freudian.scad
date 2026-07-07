$fn = $preview ? 32 : 128;


freudian_right_array = [
    [-2,-1],
    [-1,-1],
    [2,2],
    [4,2],
    [4,3],
    [3,4],
    [3,4],
    [3,5],
    [5,5],
    [8,8],
    [8,9],
    [-2,9]
];

units = 9;

function scale(n = 1, s =1) = s * n;
function scale_coords(input = [], s) = [ for (x = input) [scale(x[0],s),scale(x[1],s)] ];

module freudian_silhouette(height = 10,scale_factor = 1)  {

    scaled_coords = scale_coords(freudian_right_array, scale_factor);

    difference() {
        union() {
            polygon(points=scaled_coords);
            translate([scale(4, scale_factor),scale(2.5, scale_factor)]) circle(d=scale(1, scale_factor));
        }

        translate([scale(3, scale_factor),scale(4.5, scale_factor)]) circle(d=scale(1, scale_factor));

    }
}



module freudian_miter(length = 100, height = 10, receiver = true) {

    scale_factor = height/units;

    // this is nessecary because the lowest point in the array is -1,-1
    // it must be scales to match the rest of the scaled values
    x_and_y_shift = scale(1, scale_factor);

    y_rotation = receiver ? 0 : 90;
    z_adjust = receiver ? 0 : scale(-2, scale_factor);

    // to get a clean render, the length is externded by 2
    // then centered on the y axis
    #translate([x_and_y_shift,(length / 2) + 1,x_and_y_shift + z_adjust]) 
    rotate([90, y_rotation, 0]) 
        linear_extrude(length + 2) 
            freudian_silhouette(height,scale_factor);
}