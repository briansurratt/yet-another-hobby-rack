$fn = $preview ? 32 : 256;

fit_margin = 0.5;
inch_to_mm = 25.4;

max_edge = 240;

version = "0.1.0";


// how this the frame elementes will print
frame_thickness = 10;
frame_width = 2 * frame_thickness;
frame_edge = max_edge;
frame_negative = frame_edge - 2 *frame_width;

// derived from the reference model
// tray_z = 7;
// tray_x = 216.5;
// tray_y = 140;
// tray_rail_z = 5.4;
// tray_rail_x = 4.6;
// tray_corner_od = 4;

alignment_blade_thickness = 3;
alignment_blade_relief = alignment_blade_thickness + 0.5;

// this is the flat surface on any plate
interior_surface = frame_negative;

rail_z_spacing = 5;
rail_z = rail_z_spacing - fit_margin;



