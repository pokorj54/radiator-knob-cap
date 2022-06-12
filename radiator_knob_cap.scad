module ring(
    height,
    outer_diameter, 
    wall_width
){
     difference(){
        cylinder(height, d=outer_diameter);
        cylinder(height, d=outer_diameter-2*wall_width);
     }
}

module radiator_knob_cap(
    height,
    outer_diameter,
    hidden_outer_diameter,
    inner_diameter,
    n_teeth,
    wall_width
    ){
        // vertical walls
        ring(height, outer_diameter, wall_width);
        ring(height, hidden_outer_diameter, wall_width);
        // top
        translate([0,0,height])
            difference(){
            cylinder(wall_width, d=outer_diameter);
            cylinder(wall_width, d=inner_diameter);
            }
        //
        hidden_inner_diameter=hidden_outer_diameter-2*wall_width;
        hidden_inner_circumference=hidden_inner_diameter*PI;
        tooth_width=hidden_inner_circumference/n_teeth;
        tooth_side=sqrt(tooth_width*tooth_width/2);
        tooth_angle=360/n_teeth;
        // teeth
        for(i=[0:50]){
         rotate([0,0,i*tooth_angle])
            translate([hidden_inner_diameter/2,0,height/2])
                intersection(){
                    rotate([0,0,45])
                        cube([tooth_side, tooth_side, height],center=true);
                    translate([-tooth_side,0,0])
                    cube([tooth_side*2, tooth_side*2, height],center=true);
                }
        }
}

radiator_knob_cap(
height=4,
outer_diameter=47,
hidden_outer_diameter=40,
inner_diameter=29,
n_teeth=50, 
wall_width=1);