// preview[view:south, tilt:top]

/* [Image] */

// Load a 100x100 pixel image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox!
image_file = "image-surface.dat"; // [image_surface:100x100]

/* [Adjustments] */

hole_diameter = 10;

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;

// The lower the layer height, the more layers you can use.
number_of_layers = 12; // [5:20]

/* [Hidden] */

length = 100;
width = 100;
// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;

union() {
  // take just the part of surface we want
  difference() {
    translate([0, 0, min_layer_height]) scale([1,1,height]) surface(file=image_file, center=true, convexity=5);
    translate([0,0,-(height+min_layer_height)]) linear_extrude(height=height+min_layer_height) square([length, width], center=true);
  }
  linear_extrude(height=layer_height*2) square([length+4, width+4], center=true);

  linear_extrude(height=height+min_layer_height){
	  difference(){
		union(){
	      square([length+4, width+4], center=true);
		  translate([0, width/2+hole_radius+2, 0])
		    circle(r=hole_radius+5);
		}
	    union(){
	      square([length, width], center=true);
		  translate([0, width/2+hole_radius+2, 0])
	        circle(r=hole_radius);
	    }
	  }
  }
}
