/* Gear set for Shapeoko to invert the z-axis motor and provied more clearance
 * This use 2 modules from the MCAD library that you can
 *  get from https://github.com/elmom/MCAD.
 * 
 *
 * Based roughly on extruder gear set for TechZone Huxley Copyright (C) 2011 by
 *  Guy 'DeuxVis' P. (thanks DeuxVis) which is derrived from
 *  http://www.thingiverse.com/thing:3104
 *  (thanks GilesBathgate) which is under GPL CC license.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation, 
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */ 
 // Go to the bottom of this file and remove selected comments to get parts you can print.
// flip stl exported part over before printing and print each part separately for best results.

include <MCAD/teardrop.scad>
include <MCAD/involute_gears.scad>

/* Herringbone gear module, adapted from MCAD/involute_gears */
module herringbone_gear( teeth=12, circles=0, shaft=5, height=14 ) {
  twist=200;
//  height=14;
  pressure_angle=30;

  gear(
    number_of_teeth=teeth,
    circular_pitch=320,
		pressure_angle=pressure_angle,
		clearance = 0.2,
		gear_thickness = height/2,
		rim_thickness = height/2,
		rim_width = 1,
		hub_thickness = height/2,
		hub_diameter=1,
		bore_diameter=shaft,
		circles=circles,
		twist=twist/teeth
  );

	mirror( [0,0,1] )
	  gear(
      number_of_teeth=teeth,
		  circular_pitch=320,
		  pressure_angle=pressure_angle,
		  clearance = 0.2,
		  gear_thickness = height/2,
		  rim_thickness = height/2,
		  rim_width = 1,
		  hub_thickness = height/2,
		  hub_diameter=1,
		  bore_diameter=shaft,
		  circles=circles,
		  twist=twist/teeth
    );
}
// Idler Gear
module idler_gear(){
tears = 8; 
  union() {
    //gear
    herringbone_gear( teeth=32, circles=0, shaft=25*2, height=12 );
	 translate([0,0,12/2-4/2]) difference() {
				cylinder(r=25.1, h=4,center = true);
				cylinder(r=22/2, h=4.1,center = true, $fn = 100);

		//teardrop shaped holes 
  				for(i=[0:tears-1])
   				 rotate( [0, 0, i*360/tears] )
    				  translate( [19, 0, 0] )
    				    rotate( [0, 90, 50] ) teardrop( 6, 11, 90 );

				}
	difference(){
	 translate([0,0,0]) cylinder(r=(22+3)/2, h=12,center = true, $fn = 100);
    translate([0,0,0]) cylinder(r=22/2, h=12.1,center = true,$fn = 100);
	 }
    //608 bearing trap
    difference() {
      translate( [0, 0, 0] ) cylinder( r=11.5, h=.5, center = true );
      translate( [0, 0, 0] ) cylinder( r=11, h=10, $fn=10, center = true );
    	}
    }
// shaft position
% cylinder (r=4, h = 60, center = true);
// bearing positions
% translate([0,0,-3.7])cylinder (r=22/2, h = 7, center = true);
% translate([0,0, 3.7])cylinder (r=22/2, h = 7, center = true);
// Nut clearance
% translate( [0, 0, -14] ) cylinder( r=6.6, h=7, $fn=6 );
% translate( [0, 0, -30] ) cylinder( r=6.6, h=7, $fn=6 );
// radius mesh
% cylinder (r=28.44444, h=1);

}

// Leadscrew Gear
module leadscrew_gear(){
difference() {
  union() {
    //gear
    herringbone_gear( teeth=13, circles=0, shaft=8.2 );

    //M8 hobbed bolt head fit washer
    difference() {
      translate( [0, 0, -13] ) cylinder( r=9.4, h=6 );
      translate( [0, 0, -13.5] ) cylinder( r=6.6, h=7, $fn=6 );
    }
  }
}
// shaft position
% cylinder (r=4, h = 60, center = true);
// radius mesh
% cylinder (r=11.5556, h=1);
// Nut clearance
% translate( [0, 0, -14] ) cylinder( r=6.6, h=7, $fn=6 );
% translate( [0, 0, 7] ) cylinder( r=6.6, h=7, $fn=6 );
}
 
// Motor gear
module Nema17_motor_gear(){
 union() difference() {	 
  union() {

    //gear
    herringbone_gear( teeth=13 );

    translate( [0, 0, 13.9] ) mirror( [0, 0, 1] ) difference() {
      union() {

        //base
			cylinder(h=7, r1=10.5, r2=13.0, $fn = 80);


        //shaft
 //%       cylinder( r=5, h=18 );
      }

      //captive nut and grub holes
      translate( [0, 20, 4] ) rotate( [90, 0, 0] ) union() {
        //enterance
        translate( [0, -3, 14.5] ) cube( [5.4, 6, 2.4], center=true );
        //nut
        translate( [0, 0, 13.3] ) rotate( [0, 0, 30] ) cylinder( r=3.12, h=2.4, $fn=6 );
        //grub hole
        translate( [0, 0, 5] ) cylinder( r=1.5, h=15 );
      }
    }
  }

  //shaft hole
  translate( [0, 0, 0] ) cylinder( r=2.55, h=35, center = true );
 }
// Nema 17 specs
	case = 42.3;
	holes17=31;
	collar_d = 22.05;
	collar_h = 2;
	shaft_l = 24;
	shaft_d = 5;
	m3 = 3.1;
	$fn = 30;
// show nema17 outline for positioning
	% cylinder (r=shaft_d/2, h=shaft_l);
	% translate([0,0, 24]) cylinder(r = collar_d/2, h = collar_h);
	% translate([holes17/2,holes17/2, 22])cylinder(r=m3/2, h = 9);
	% translate([-holes17/2,holes17/2, 22])cylinder(r=m3/2, h = 9);
	% translate([holes17/2,-holes17/2, 22])cylinder(r=m3/2, h = 9);
	% translate([-holes17/2,-holes17/2, 22])cylinder(r=m3/2, h = 9);
   % translate([0,0, 26]) cube([case,case,1], center = true);
// radius mesh
% cylinder (r=11.5556, h=1);
}

// Assembly  -maximum separation center to center of 80
module gearbox(){
rotate([0,180,0])translate( [0, 0, 0] )idler_gear();
translate( [40, 0, 0] )leadscrew_gear();
translate( [-40, 0, 0] ) Nema17_motor_gear();
}

//gearbox();  // for test fit only do not export
//idler_gear();  // for stl export
//translate( [0, 45, -1] ) leadscrew_gear(); // for stl export
//translate( [-45, 0, -8] )Nema17_motor_gear(); // for stl export
