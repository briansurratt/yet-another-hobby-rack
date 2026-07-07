include <constants.scad>
use <freudian.scad>
use <constructs.scad>

module blank_frame() {
    
    linear_extrude(height=frame_thickness, center=true) {
    
        difference() {
            square([frame_edge, frame_edge], center=true);
            square([frame_negative, frame_negative], center=true);
        }

        
        rotate([0, 0, 45])
        square([frame_edge * sqrt(2) - frame_width, frame_width], center=true);

        rotate([0, 0, -45])
        square([frame_edge * sqrt(2) - frame_width, frame_width], center=true);

        // circle(r=frame_width * 2);

    }

}


// back();
// vertical_side();
horizontal_side();


module horizontal_side() {

    edge_shift =  frame_thickness;
    support_length = frame_edge - 2 * frame_thickness;


    
    difference() {

        // corner    
        translate([1/2 * frame_edge - frame_thickness,-edge_shift , 0]) 
        rotate([0, 0, 90])     interior_support(support_length, frame_thickness);

        // alignment blade socket
        translate([1/2 * frame_edge - frame_thickness,0  , 0]) 
        rotate([0, 0, 90])
        alignment_blade(frame_thickness, width = alignment_blade_relief, frame_thickness);

    }

    difference() {

        // corner    
        mirror([1, 0, 0])  {
            translate([1/2 * frame_edge - frame_thickness,-edge_shift , 0]) 
            rotate([0, 0, 90])     interior_support(support_length, frame_thickness);
        }

        // alignment blade socket
        mirror([1, 0, 0])  {
            translate([1/2 * frame_edge - frame_thickness,0, 0]) 
            rotate([0, 0, 90])
            alignment_blade(frame_thickness, width = alignment_blade_relief, frame_thickness);
        }


    }


    // alignment blades for the edge that interfaces with the back of the frame
    translate([0, frame_edge / 2 - frame_thickness,0])
    mirror([0, 1, 0]) 
    alignment_blade(frame_thickness, width = alignment_blade_thickness, frame_thickness);

    difference() {
        blank_frame();
        translate([frame_edge / 2 - frame_thickness, 0, frame_thickness/2]) freudian_miter(frame_edge, frame_thickness, receiver=false);
        mirror([1,0, 0]) translate([frame_edge / 2 - frame_thickness, 0, frame_thickness/2]) freudian_miter(frame_edge, frame_thickness, receiver=false);
        translate([0, frame_edge / 2 - frame_thickness, frame_thickness/2]) rotate([0, 0, 90]) freudian_miter(frame_edge, frame_thickness, receiver=false);

        translate([0, 0, -frame_thickness/2]) 
        #negative_text("HORZ", height=frame_thickness, depth=1, text_size=5);

    }

}

module vertical_side() {

    // bottom
    translate([0, -frame_edge / 2 + frame_thickness , 0])
    alignment_blade(frame_thickness, width = alignment_blade_thickness, frame_thickness);

    // right
    rotate([0, 0, 90]) 
    translate([0, -frame_edge / 2 + frame_thickness , 0])
    #alignment_blade(frame_thickness, width = alignment_blade_thickness,frame_thickness);

    // top
    mirror([0, 1, 0]) {
        translate([0, -frame_edge / 2 + frame_thickness , 0])
        alignment_blade(frame_thickness, width = alignment_blade_thickness, frame_thickness);
    }

    difference() {

        blank_frame();

        //  this is the edge that interfaces with the back of the frame
        translate([frame_edge / 2 - frame_thickness, 0, frame_thickness/2]) freudian_miter(frame_edge, frame_thickness, receiver=false);

        rotate([0, 0, 90]) translate([-frame_edge / 2, 0, -frame_thickness/2]) freudian_miter(frame_edge, frame_thickness);
        mirror([0, 1, 0]) rotate([0, 0, 90]) translate([-frame_edge / 2, 0, -frame_thickness/2]) freudian_miter(frame_edge, frame_thickness);

        translate([0, 0, -frame_thickness/2]) 
        #negative_text("VERT", height=frame_thickness, depth=1, text_size=5);

    }

}


module back() {

    edge_shift = frame_edge / 2 - frame_thickness;
    support_length = frame_edge - 2 * frame_thickness;


    

    // bottom

    translate([0,-edge_shift , 0]) 
    difference() {
        interior_support(support_length,frame_thickness);
        alignment_blade(frame_thickness, width = alignment_blade_relief, frame_thickness);
    }

    // top
    mirror([0, 1, 0]) 
    translate([0,-edge_shift , 0]) 
    difference() {
        interior_support(support_length,frame_thickness);
        alignment_blade(frame_thickness, width = alignment_blade_relief, frame_thickness);
    }
    

    translate([edge_shift ,0, 0]) rotate([0, 0, 90])     difference() {
        interior_support(support_length,frame_thickness);
        alignment_blade(frame_thickness, width = alignment_blade_relief, frame_thickness);
    }
    mirror([1,0, 0]) translate([edge_shift ,0, 0]) rotate([0, 0, 90])     difference() {
        interior_support(support_length,frame_thickness);
        alignment_blade(frame_thickness, width = alignment_blade_relief, frame_thickness);
    }
    
    

    difference() {
        
        blank_frame();

        translate([-frame_edge / 2, 0, -frame_thickness/2]) freudian_miter(frame_edge, frame_thickness);
        translate([frame_edge / 2, 0, -frame_thickness/2]) mirror([1, 0, 0]) freudian_miter(frame_edge, frame_thickness);

        rotate([0, 0, 90]) translate([-frame_edge / 2, 0, -frame_thickness/2]) freudian_miter(frame_edge, frame_thickness);
        mirror([0, 1, 0]) rotate([0, 0, 90]) translate([-frame_edge / 2, 0, -frame_thickness/2]) freudian_miter(frame_edge, frame_thickness);

        translate([0, 0, -frame_thickness/2]) 
        #negative_text("BACK", height=frame_thickness, depth=1, text_size=5);

    }

}

