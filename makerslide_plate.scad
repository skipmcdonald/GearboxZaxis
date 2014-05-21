// flip it over for viewing in the correct orientation.
// Skip McDonald copyright 2014 - GNU license use it and abuse it but give me some credit.
// Warning this desing is somewhat incomplete as of 21May2014 you have been warned.



include <gearbox.scad>

//new plate dimensions
in = 25.4;
cx = 3.5*in;
//cy = 1.5*in;
cy =37;
cz = 1/8*in;
screw3 = 3.2;
screw5 = 5.1;
screw8 = 8.1;
leadscrew = 8.5;
bearing_d = 21.80;
bearing_h = 7;
//original plate dimensions
ox = 57.15;
oy = 50.80;
oz = 6.35;
screw = 5;
rad = 5;

module makerslide(h=100) {
	linear_extrude(file="makerslide_extrusion_profile.dxf", layer="makerslide",height=100, center=true, convexity=10);
	}

% translate([0,0,50+cz/2])makerslide(20);
$fn=20;
//Clearance for screw head and washer
% translate([10,10,0])cylinder(h=12, r=5/2, center = true);
% translate([10,-10,0])cylinder(h=12, r=5/2, center = true);

module zplate(){   // alumium underplate for strength
// center
% cylinder(h=30, r=.5);
	difference(){
	cube([cx,cy,cz], center = true);
// Makerslide holes
//%	translate([10,10,0])cylinder(h=20, r=screw5/2, center = true);
//%	translate([10,-10,0])cylinder(h=20, r=screw5/2, center = true);
	translate([6,10,0])cylinder(h=20, r=screw5/2, center = true);
	translate([6,-10,0])cylinder(h=20, r=screw5/2, center = true);
	translate([14,10,0])cylinder(h=20, r=screw5/2, center = true);
	translate([14,-10,0])cylinder(h=20, r=screw5/2, center = true);
	translate([10,-10,0])cube([8,screw,20],center = true);
	translate([10,10,0])cube([8,screw,20],center = true);
// idler gear 
// hole 0.25mm too close to leadscrew gear on purpose in
// case of gear print tolerance, length of hole allows proper tensioning
	translate([-8.75,0,0])cylinder(h=20, r=screw8/2, center = true);
	translate([-8.75,-6,0])cylinder(h=20, r=screw8/2, center = true);
	translate([-8.75,-3,0])cube([screw8,screw8,20],center = true);
// Nema17 holes
	translate([-47.5,0,0])cylinder(h=20, r=22/2, center = true, $fn = 100);
	translate([-47.5+15.5,-15.5,0])cylinder(h=20, r=screw3/2, center = true);
	translate([-47.5+15.5,15.5,0])cylinder(h=20, r=screw3/2, center = true);
	translate([-49+15.5,-15.5,0])cube([3,screw3,20], center = true);
	translate([-49+15.5,15.5,0])cube([3,screw3,20], center = true);
	translate([-50.5+15.5,-15.5,0])cylinder(h=20, r=screw3/2, center = true);
	translate([-50.5+15.5,15.5,0])cylinder(h=20, r=screw3/2, center = true);





// radius the corners
	difference(){
		translate([(cx-rad)/2,(cy-rad)/2,0]) cube([rad,rad,20],center = true);		
		translate([cx/2-rad,(cy)/2-rad,0]) cylinder(h=20, r=rad, center = true);
		}
	difference(){
		translate([(-cx+rad)/2,(cy-rad)/2,0]) cube([rad,rad,20],center = true);		
		translate([-cx/2+rad,(cy)/2-rad,0]) cylinder(h=20, r=rad, center = true);
		}
	difference(){
		translate([(-cx+rad)/2,(-cy+rad)/2,0]) cube([rad,rad,20],center = true);	
		translate([-cx/2+rad,(-cy)/2+rad,0]) cylinder(h=20, r=rad, center = true);
		}
	difference(){
		translate([(cx-rad)/2,(-cy+rad)/2,0]) cube([rad,rad,20],center = true);		
		translate([cx/2-rad,(-cy)/2+rad,0]) cylinder(h=20, r=rad, center = true);
		}

//	translate([31.05,0,bearing_h/2])cylinder(h=bearing_h,r=bearing_d/2, center = true, $fn=50);
//translate([31.05,0,0])cylinder(h=bearing_h,r=bearing_d/2-2.5, center = true, $fn=50);
  translate([31.05,0,0])cylinder(h=15,r=bearing_d/2, center = true,$fn=100);



	}

}
/*	
module original_z_plate(){

	
translate([0,0,0])difference(){
	translate([0,0,0.01])cube([ox,oy,oz] );
//Makerslide holes
	translate([44.45,35.4,0])cylinder(h=20, r=screw/2);
	translate([44.45,15.40,0])cylinder(h=20, r=screw/2);
	translate([52.45,35.4,0])cylinder(h=20, r=screw/2);
	translate([52.45,15.40,0])cylinder(h=20, r=screw/2);
	translate([44.45,35.4-screw/2,0])cube([8,screw,20]);
	translate([44.45,15.40-screw/2,0])cube([8,screw,20]);
//Motor Nema17 holes
	translate([28.10,3.49,0])cylinder(h=20, r=3.2/2);
	translate([28.10,47.32,0])cylinder(h=20, r=3.2/2);
	translate([6.19,25.40,0])cylinder(h=20, r=3.2/2);
//Bearing hole
	translate([28.10,25.40,0])cylinder(h=20, r=bearing_d/2);

%  translate([28.10,25.40,0])cylinder(h=20, r=leadscrew/2);
%  translate([28.10,25.40,0])cylinder(h=20, r=0.1, center = true);
//Radius corners
	difference(){
		translate([0,0,0]) cube([rad,rad,20]);		
		translate([rad,rad,0]) cylinder(h=20, r=rad);
	}
	difference(){
		translate([ox-rad,0,0]) cube([rad,rad,20]);		
		translate([ox-rad,rad,0]) cylinder(h=20, r=rad);
	}
	difference(){
		translate([ox-rad,oy-rad,0]) cube([rad,rad,20]);		
		translate([ox-rad,oy-rad,0]) cylinder(h=20, r=rad);
	}
	difference(){
		translate([0,oy-rad,0]) cube([rad,rad,20]);		
		translate([rad,oy-rad,0]) cylinder(h=20, r=rad);
	}

	}
}
*/

//%rotate([0,180,0])translate([-ox-2,-oy/2,0])original_z_plate();
zplate();  // for stl export
% translate([-9,0,-17])gearbox();
//projection(cut = true) zplate();  // for dxf export