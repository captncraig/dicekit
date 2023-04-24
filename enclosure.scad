// -> increase the number for smoother edges
$fn = 20;
// -> the length of the box
length=110.0;
// -> the width of the box
width=70.0;
// -> the total height of the box 
height=30.0;
// -> the radius of fillets and outer roundings
filletRadius=3.0;

///////////////////////////////////////////////////////////////////////////////////////
// creates a box with rounded edges all around except on the top
module roundedBox01(length, width, height, radius)
{
    translate([radius,radius,radius])
    hull() 
    {
        sphere(radius);
        translate([length-2*radius, 0, 0])              sphere(radius);
        translate([length-2*radius, width-2*radius, 0]) sphere(radius);
        translate([0, width-2*radius, 0])               sphere(radius);
        
        translate([0, 0, height-radius])                            halfSphere(radius);
        translate([length-2*radius, 0, height-radius])              halfSphere(radius);
        translate([length-2*radius, width-2*radius, height-radius]) halfSphere(radius);
        translate([0, width-2*radius, height-radius])               halfSphere(radius);
    }
}

///////////////////////////////////////////////////////////////////////////////////////
// creates half of a sphere
module halfSphere(radius)
{
    difference()
    {
        sphere(radius);
        translate([-1.5*radius, -1.5*radius, 0]) cube(3*radius);
    }
}

module standoff(x,y){
    difference(){
        translate([x,y,2])cylinder(d=8,h=height-4);
        translate([x,y,height*3/4])cylinder(d=3,h=height);
        
    }
}

/////////////////////
// Main Box
sw_x = 8.85;
sw_hole_x = 5;
sw_x_pad = (sw_x-sw_hole_x) / 2;
sw_y = 3.86;
sw_hole_y = 2;
sw_y_pad = (sw_x-sw_hole_x) / 2;

cut_h = 15;
cut_y = 20;
difference(){
    translate([-5,-5,0])roundedBox01(length, width, height, filletRadius);
    translate([0,0,4])cube([100.5,60.5,100]);
    
    translate([-2,cut_y,cut_h])
            cube([10,sw_x,sw_y]);
    // cover over switch hole
        translate([-5,cut_y+sw_x_pad,cut_h+sw_y_pad])cube([3.1,sw_hole_x,sw_hole_y]);
};
standoff(5.25,5.25);
standoff(5.25,55.25);
standoff(95.25,5.25);
standoff(95.25,55.25);

// dummy battery
translate([35,25,6])cube([48,25,15]);
