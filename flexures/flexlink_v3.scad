// Scalable buildable flexure-based mechanical link logic
// 2017 Matt Moses


// MODULE flink(linkLength, linkWidth, flexureLength, flexureWidth, flexureRadius, tabLength)
module flink(ll, lw, fl, fw, fr, tl)
{
	rotate([0,0,90])
	difference(){
		cube([ll + fl + 2*fr + 2*tl,lw,gt], center = true);
			// this is one notch for one side of one flexure
			translate([ll/2+fl/2,fr+fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([ll/2-fl/2,fr+fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([ll/2, lw/2 + fw/2, 0])
				cube([fl, lw, 1.1*gt], center=true);
			translate([ll/2, lw/2 + fw/2 + fr, 0])
				cube([fl+2*fr, lw, 1.1*gt], center=true);
			
			// this is one notch for one side of one flexure
			translate([ll/2+fl/2,-fr-fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([ll/2-fl/2,-fr-fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([ll/2, -lw/2 - fw/2, 0])
				cube([fl, lw, 1.1*gt], center=true);
			translate([ll/2, -lw/2 - fw/2 - fr, 0])
				cube([fl+2*fr, lw, 1.1*gt], center=true);
				
			// this is one notch for one side of one flexure
			translate([-ll/2-fl/2,fr+fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([-ll/2+fl/2,fr+fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([-ll/2, lw/2 + fw/2, 0])
				cube([fl, lw, 1.1*gt], center=true);
			translate([-ll/2, lw/2 + fw/2 + fr, 0])
				cube([fl+2*fr, lw, 1.1*gt], center=true);
			
			// this is one notch for one side of one flexure
			translate([-ll/2-fl/2,-fr-fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([-ll/2+fl/2,-fr-fw/2, 0]) 
				cylinder(1.1*gt, r=fr, center=true);
			translate([-ll/2, -lw/2 - fw/2, 0])
				cube([fl, lw, 1.1*gt], center=true);
			translate([-ll/2, -lw/2 - fw/2 - fr, 0])
				cube([fl+2*fr, lw, 1.1*gt], center=true);
	}
}
// END FLINK ///////////////////////////////


// MODULE SINGLE SUPPORT ////////////////////////////
module singlesupport(XX,YY,bctheta)
{
	translate([XX*16, YY*16, 0])
	rotate([0,0,bctheta])
	{
		translate([0,10,0])
		cube([4,2,gt], center=true);
		linear_extrude(height = gt, center = true, convexity = 10, twist = 0)
		{
			polygon([[-5,-1], [-8,2], [-8,-2], [-7,-3], [7,-3], [8,-2], [8,2], [5,-1] ]);  
		}
		translate([0,4,0])
			flink(8,2,flen,fwid,frad,tablen);
		// and now the ring segment
		//intersection(){
		//	difference(){
		//		cylinder(h=gt, r=4.5, center=true);
		//		cylinder(h=1.1*gt, r=2.5, center=true);
		//	}
		//	linear_extrude(height = gt, center=true, convexity = 10, twist = 0)
		//	{
		//		polygon([[0,0], [0,8], [-8,4]]);
		//	}
		}
}
// END SINGLE SUPPORT ////////////////////////////////////


// MODULE BELL CRANK INNER ////////////////////////////
module bellcranki(XX,YY,bctheta)
{
	translate([XX*16, YY*16, 0])
	rotate([0,0,bctheta])
	{
		translate([0,10,0])
		cube([4,2,gt], center=true);
		linear_extrude(height = gt, center = true, convexity = 10, twist = 0)
		{
			polygon([[-5,-1], [-8,2], [-8,-2], [-7,-3], [7,-3], [8,-2], [8,2], [5,-1] ]);  
		}
		translate([0,4,0])
			flink(8,2,flen,fwid,frad,tablen);
		// and now the ring segment
		intersection(){
			difference(){
				cylinder(h=gt, r=5.5, center=true);
				cylinder(h=1.1*gt, r=2.5, center=true);
			}
			linear_extrude(height = gt, center=true, convexity = 10, twist = 0)
			{
				polygon([[0,0], [0,8], [-8,4]]);
			}
		}
	}
}
// END BELL CRANK INNER ////////////////////////////////////


// MODULE BELL CRANK OUTER ////////////////////////////
module bellcranko(XX,YY,bctheta)
{
	translate([XX*16, YY*16, 0])
	rotate([0,0,bctheta])
	{
		translate([0,10,0])
		cube([4,2,gt], center=true);
		linear_extrude(height = gt, center = true, convexity = 10, twist = 0)
		{
			polygon([[-5,-1], [-8,2], [-8,-2], [-7,-3], [7,-3], [8,-2], [8,2], [5,-1] ]);  
		}
		// here's the link
		translate([0,4,0])
			flink(8,2,flen,fwid,frad,tablen);
	
		// and now the ring segment
		intersection(){
			difference(){
				cylinder(h=gt, r=5.5, center=true);
				cylinder(h=1.1*gt, r=2.5, center=true);
			}
			linear_extrude(height = gt, center=true, convexity = 10, twist = 0)
			{
				polygon([[0,0], [0,8], [8,4]]);
			}
		}
	}
}
// END BELL CRANK OUTER ////////////////////////////////////


// MODULE LOCK ////////////////////////////////////////////////////////////////
module lock(flen, fwid, frad, tablen)
{
	// this is the top bar lock
	linear_extrude(height = gt, center = true, convexity = 10, twist = 0)
	{
		polygon([[-1,4], [-1,7], [-3,9], [-18,9], [-18,11],
				[18,11], [18,9], [3,9], [1,7], [1,4] ]);
	}

	// this is the bottom bar of the lock
	linear_extrude(height = gt, center = true, convexity = 10, twist = 0)
	{
		polygon([[-1,-4], [-1,-7], [-3,-9], [-18,-9], [-18,-11],
				[18,-11], [18,-9], [3,-9], [1,-7], [1,-4] ]);
	}

	// this creates the main rectangle, cuts out the inside opening, and adds the five flex links
	difference()
	{
		cube([52, 36, gt], center=true);
		linear_extrude(height = 1.1*gt, center = true, convexity = 10, twist = 0)
		{
			polygon([[-7,1], [-10,1], [-11,2], [-22,2], [-22,14], [22,14], [22,2], [11,2], [10,1], [7,1],
			[7,-1], [10,-1], [11,-2], [22,-2], [22,-14], [-22,-14], [-22,-2], [-11,-2], [-10,-1], [-7,-1] ]);  
		}
	}

	// reminder: flink(linkLength, linkWidth, flexureLength, flexureWidth, flexureRadius, tabLength)
	flink(6, 2, flen, fwid, frad, tablen);
	translate([-8,5,0])
		flink(6, 2, flen, fwid, frad, tablen);
	translate([8,5,0])
		flink(6, 2, flen, fwid, frad, tablen);
	translate([-8,-5,0])
		flink(6, 2, flen, fwid, frad, tablen);
	translate([8,-5,0])
		flink(6, 2, flen, fwid, frad, tablen);
}
// END LOCK ////////////////////////////////////////////////////////////////


// MODULE BALANCE ////////////////////////////////////////////////////////////////
module balance(bwid)
{
	// this creates the main rectangle, cuts out the inside opening, and adds the four support flexures
	difference()
	{
		cube([36, 52, gt], center=true);
		linear_extrude(height = 1.1*gt, center = true, convexity = 10, twist = 0)
		{
		polygon([ [2,8+bwid], [5-bwid,8+bwid], [5-bwid,16+bwid], [11+bwid,16+bwid], [11+bwid, 8+bwid], [14, 8+bwid], [14,22],
			[-14,22], [-14, 8+bwid], [-11-bwid, 8+bwid], [-11-bwid,16+bwid], [-5+bwid,16+bwid], [-5+bwid,8+bwid], [-2,8+bwid],
			[-2,19], [2,19], [2,8+bwid] ]);
		}
		linear_extrude(height = 1.1*gt, center = true, convexity = 10, twist = 0)
		{
		polygon([ [2,-8-bwid], [5-bwid,-8-bwid], [5-bwid,-16-bwid], [11+bwid,-16-bwid], [11+bwid, -8-bwid], [14, -8-bwid], [14,-22],
			[-14,-22], [-14, -8-bwid], [-11-bwid, -8-bwid], [-11-bwid,-16-bwid], [-5+bwid,-16-bwid], [-5+bwid,-8-bwid], [-2,-8-bwid],
			[-2,-19], [2,-19], [2,-8-bwid] ]);
		}
		linear_extrude(height = 1.1*gt, center = true, convexity = 10, twist = 0)
		{
		polygon([ [2,8-bwid], [5+bwid,8-bwid], [5+bwid,16-bwid], [11-bwid,16-bwid], [11-bwid, 8-bwid], [14, 8-bwid], 
			[14,-8+bwid], [11-bwid,-8+bwid], [11-bwid,-16+bwid], [5+bwid,-16+bwid], [5+bwid,-8+bwid], [2,-8+bwid] ]);
		}
		linear_extrude(height = 1.1*gt, center = true, convexity = 10, twist = 0)
		{
		polygon([ [-2,8-bwid], [-5-bwid,8-bwid], [-5-bwid,16-bwid], [-11+bwid,16-bwid], [-11+bwid, 8-bwid], [-14, 8-bwid], 
			[-14,-8+bwid], [-11+bwid,-8+bwid], [-11+bwid,-16+bwid], [-5-bwid,-16+bwid], [-5-bwid,-8+bwid], [-2,-8+bwid] ]);
		}
	}
}


// MODULE LOCK NEGATIVE SPACE /////////////////////////////////////////////////////
module locknspace()
{
	cube([0.99*52, 0.99*36, 1.1*gt], center=true);
}
// END LOCK NEGATIVE SPACE /////////////////////////////////////////////////////


// MODULE BALANCE NEGATIVE SPACE /////////////////////////////////////////////////////
module balancenspace()
{
	cube([0.99*36, 0.99*52, 1.1*gt], center=true);
}
// END BALANCE NEGATIVE SPACE /////////////////////////////////////////////////////


// MODULE INNER FRAME /////////////////////////////////////////////////////
module innerFrame(rows, cols)
{
	difference(){
		translate([-2,-2,-gt/2])
		union(){
			cube([16*(cols-1)+4, 4, gt]);
				translate([0,16*(rows-1),0])
					cube([16*(cols-1)+4, 4, gt]);
				for (i = [1:cols])
				{
					translate([(i-1)*16, 0, ])
					cube([4,16*(rows-1)+4,gt]);
				}
		}
//		for (i = [1:cols])
//			for (j = [1:rows])
//				translate([16*(i-1), 16*(j-1), 0])
//					cylinder(h=1.1*gt, r=0.5, center=true);
	}
}
// END INNER FRAME /////////////////////////////////////////////////////


// MODULE OUTER FRAME /////////////////////////////////////////////////////
module outerFrame(rows, cols)
{
	translate([-2,-2,-gt/2])
	union(){
		cube([4, 16*(rows-1)+4, gt]);
		translate([16*(cols-1),0,0])
			cube([4,16*(rows-1)+4, gt]);
		for (i = [1:rows])
			translate([0, (i-1)*16, 0])
				cube([16*(cols-1)+4,4,gt]);
	}
}
// END OUTER FRAME /////////////////////////////////////////////////////


// MODULE FULL_OUTER_FRAME //////////////////////////////////////////
// this puts together an instance of an outer frame with all components
// first by starting with a blank frame,
// and then removing the negative space for
// all the components.
module full_outer_frame(gt, ltol, flen, fwid, frad, tablen, bwid)
{
color("orange"){

difference(){
	outerFrame(7,11);
    // negative space for the lock inputs
	translate([7.5*16,16,0])
		cube([0.99*4, 1.01*4, 1.1*gt], center=true);
	translate([7.5*16,3*16,0])
		cube([0.99*4, 1.01*4, 1.1*gt], center=true);

	// negative space for bellcrank at (6,3)
	translate([6*16, 3*16, 0])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// negative space for bellcrank at (6,5)
	translate([6*16, 5*16, 0])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);

	// negative space for bellcrank at (5,4)
	translate([5*16, 4*16, 0])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// negative space for bellcrank at (5,1)
	translate([5*16, 1*16, 0])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// Now do negative space for single supports
	// negative space for single support at (4,3)
	translate([4*16, 3*16, 0])
	//rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// Now do negative space for single supports
	// negative space for single support at (4,1)
	translate([4*16, 1*16, 0])
	//rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);

	// negative space for single support at (1,2)
	translate([1*16, 2*16, 0])
	//rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);

	// negative space for single support at (2,2)
	translate([2*16, 2*16, 0])
	//rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);

	// negative space for single support at (1,4)
	translate([1*16, 4*16, 0])
	//rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);

	// negative space for single support at (1,5)
	translate([1*16, 5*16, 0])
	//rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);

	// negative space for the two adjacent single supports at (1,2,0) and (2,2,0)
	translate([1.5*16, 2*16, 0])
		cube([10,10,1.1*gt], center=true);
}
}

// these are the lock inputs
color("orange"){
translate([7.5*16,16,0])
	cube([1.1*4, 2, gt], center=true);
translate([7.5*16,21,0])
			flink(6, 2, flen, fwid, frad, tablen);
translate([7.5*16,11,0])
			flink(6, 2, flen, fwid, frad, tablen);

translate([7.5*16,3*16,0])
	cube([1.1*4, 2, 1.1*gt], center=true);
translate([7.5*16,3*16+5,0])
			flink(6, 2, flen, fwid, frad, tablen);
translate([7.5*16,3*16-5,0])
			flink(6, 2, flen, fwid, frad, tablen);

// these are the tabs for the lock inputs to connect to the lock bars
translate([7.5*16, 16+10, 0])
	cube([4, 2, gt], center=true);
translate([7.5*16, 16-10, 0])
	cube([4, 2, gt], center=true);
translate([7.5*16, 3*16+10, 0])
	cube([4, 2, gt], center=true);
translate([7.5*16, 3*16-10, 0])
	cube([4, 2, gt], center=true);

// this is link from bellcrank at (6,3,0) to lock input at (7.5, 3.5)
translate([6*16+12, 3*16+10, 0])
rotate([0,0,270])
flink(18,2, flen, fwid, frad, tablen);
// this covers the extra unnecessary flexure in the above link
translate([6*16+3, 3*16+10, 0])
	cube([4, 2, gt], center=true);

// this is link from bellcrank at (5,1,0) to lock input at (7.5, 1.5)
translate([5*16+20, 1*16+10, 0])
rotate([0,0,270])
flink(34,2, flen, fwid, frad, tablen);
// this covers the extra unnecessary flexure in the above link
translate([5*16+3, 1*16+10, 0])
	cube([4, 2, gt], center=true);

// this is link from single support at (4,3,0) to lock input at (7.5, 2.5)
translate([5*16+12, 3*16-10, 0])
rotate([0,0,270])
flink(50,2, flen, fwid, frad, tablen);
// this covers the extra unnecessary flexure near (4,3,0) in the above link
translate([4*16+3, 3*16-10, 0])
	cube([4, 2, gt], center=true);

// this is link from single support at (4,3,0) to lock input at (7.5, 2.5)
translate([5*16+12, 1*16-10, 0])
rotate([0,0,270])
flink(50,2, flen, fwid, frad, tablen);
// this covers the extra unnecessary flexure near (4,3,0) in the above link
translate([4*16+3, 1*16-10, 0])
	cube([4, 2, gt], center=true);

// this is link from bellcrank at (5,1,0) to lock input at (7.5, 1.5)
translate([5*16+20, 1*16+10, 0])
rotate([0,0,270])
flink(34,2, flen, fwid, frad, tablen);
// this covers the extra unnecessary flexure in the above link
translate([5*16+3, 1*16+10, 0])
	cube([4, 2, gt], center=true);
	
	
// this is the bell crank and support at (6,3,0)
bellcranko(6,3,0);

// this is the bell crank and support at (6,5,0)
bellcranko(6,5,0);

// this is the bell crank and support at (5,4,0)
bellcranko(5,4,0);

// this is the bell crank and support at (5,1,0)
bellcranko(5,1,0);

// this is single support at (4,1,180)
singlesupport(4,1,180);

// this is single support at (4,3,180)
singlesupport(4,3,180);

difference()
{
	union()
	{
		// this is single support at (1,2,180)
		singlesupport(1,2,180);
		// this is single support at (2,2,180)
		singlesupport(2,2,180);
	}
	// negative space for the two adjacent single supports at (1,2,0) and (2,2,0)
	translate([1.5*16, 2*16, 0])
		cube([10,10,1.1*gt], center=true);
}

translate([1.5*16, 2*16+2, 0])
	cube([12,2,gt], center=true);

// this is single support at (1,4,0)
singlesupport(1,4,0);

// this is single support at (1,5,0)
singlesupport(1,5,0);

// solid link from single support at (1,5,0) to bellcrank at (6,5,0)
translate([3.5*16, 5*16+10, 0])
	cube([5*16, 2, gt], center=true);

// solid link from single support at (1,4,0) to bellcrank at (5,4,0)
translate([3*16, 4*16+10, 0])
	cube([4*16, 2, gt], center=true);

// flexlink from clock input link to balance input
translate([2.5*16, 2*16-10, 0])
rotate([0,0,270])
flink(10,2, flen, fwid, frad, tablen);
// tab at center of balance
translate([3*16, 2*16-10, 0])
	cube([4, 2, gt], center=true);

// solid link from single support at (1,2,0) to single support at (2,2,0)
translate([1.5*16+4, 2*16-10, 0])
	cube([16+4, 2, gt], center=true);

// flexlink from balance top to (4,3,0)
translate([3.5*16, 3*16-10, 0])
rotate([0,0,270])
flink(10,2, flen, fwid, frad, tablen);
// tab at center of balance
translate([3*16, 3*16-10, 0])
	cube([4, 2, gt], center=true);
	
// flexlink from balance top to (4,3,0)
translate([3.5*16, 1*16-10, 0])
rotate([0,0,270])
flink(10,2, flen, fwid, frad, tablen);
// tab at center of balance
translate([3*16, 1*16-10, 0])
	cube([4, 2, gt], center=true);
	
}
}
// END FULL_OUTER_FRAME //////////////////////////////////////////


// MODULE FULL_INNER_FRAME ///////////////////////////////////////////
// this puts together the inner frame,
// first by starting with a blank frame,
// and then removing the negative space for
// all the components.
module full_inner_frame(gt, ltol, flen, fwid, frad, tablen, bwid)
{

// BLUE BLUE BLUE BLUE BLUE BLUE BLUE BLUE BLUE BLUE 
color("SkyBlue"){
difference(){
	// first create the base frame
	innerFrame(7,11);
	
	// make the negative space where the locks will go
	translate([8.5*16,16,0])
		locknspace();
	translate([8.5*16,3*16,0])
		locknspace();

	// negative space for the balance
	translate([3*16,1.5*16,0])
		balancenspace();

	// negative space for bellcrank at (6,3)
	translate([6*16, 3*16, 0])
	rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// negative space for bellcrank at (6,5)
	translate([6*16, 5*16, 0])
	rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// negative space for bellcrank at (5,4)
	translate([5*16, 4*16, 0])
	rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
		
	// negative space for bellcrank at (5,1)
	translate([5*16, 1*16, 0])
	rotate([0,0,90])
		cube([0.99*16, 1.01*4, 1.1*gt], center=true);
}

// add the locks
translate([8.5*16,16,0])
lock(flen, fwid, frad, tablen);

translate([8.5*16,3*16,0])
lock(flen, fwid, frad, tablen);

// add the balance
translate([3*16,1.5*16,0])
balance(bwid);

// Add the bellcranks
// this is the bell crank and support at (6,3,270)
bellcranki(6,3,270);

// this is the bell crank and support at (6,5,270)
bellcranki(6,5,270);

// this is the bell crank and support at (5,4,270)
bellcranki(5,4,270);

// this is the bell crank and support at (5,1,270)
bellcranki(5,1,270);

// solid link from bellcrank at (6,5,270) to (6,3,270)
translate([6*16+10, 4*16, 0])
cube([2,32,gt], center=true);

// solid link from bellcrank at (5,4,270) to (5,1,270)
translate([5*16+10, 2.5*16, 0])
cube([2,3*16,gt], center=true);

}
} 
// END FULL_INNER_FRAME ///////////////////////////////////////////

// MODULE RIVET //////////////////////////////////
module rivet(x,y)
{
	translate([x*16,y*16,0])
		color("Indigo")
		cube([1,1,4], center=true); // square rivets - comment out if necessary
//		cylinder(h = 4, r = 0.4, center=true); // round rivets - use to make round holes for single layers

}

// MAIN /////////////////////////////////////////////////////
$fn=30;
gt = 1; // global thickness
ltol = 0.99;
flen = ltol*1;
fwid = 0.3; // flexure width
frad = 0.5; // flexure corner radius
tablen = 1.0; //
bwid = 0.15; // balance width

// uncomment this to create individual layers with holes instead of rivets
//difference(){

// inner layer - can be commented out if necessary
full_inner_frame(gt, ltol, flen, fwid, frad, tablen, bwid);

// outer layer - can be commented out if necessary
translate([0,0,1.2*gt])
full_outer_frame(gt, ltol, flen, fwid, frad, tablen, bwid);

// outer layer - can be commented out if necessary
translate([0,0,-1.2*gt])
full_outer_frame(gt, ltol, flen, fwid, frad, tablen, bwid);

// GRID RIVETS
rivet(0,6);
rivet(0,5);
rivet(0,4);
rivet(0,3);
rivet(0,2);
rivet(0,1);
rivet(0,0);

rivet(1,6);
//rivet(1,5);
//rivet(1,4);
rivet(1,3);
//rivet(1,2);
rivet(1,1);
rivet(1,0);

rivet(2,6);
rivet(2,5);
rivet(2,4);
rivet(2,3);
//rivet(2,2);
rivet(2,1);
rivet(2,0);

rivet(3,6);
rivet(3,5);
rivet(3,4);
rivet(3,3);
//rivet(3,2);
//rivet(3,1);
rivet(3,0);

rivet(4,6);
rivet(4,5);
rivet(4,4);
//rivet(4,3);
rivet(4,2);
//rivet(4,1);
rivet(4,0);

rivet(5,6);
rivet(5,5);
//rivet(5,4);
rivet(5,3);
rivet(5,2);
//rivet(5,1);
rivet(5,0);

rivet(6,6);
//rivet(6,5);
rivet(6,4);
//rivet(6,3);
rivet(6,2);
rivet(6,1);
rivet(6,0);

rivet(7,6);
rivet(7,5);
rivet(7,4);
rivet(7,3);
rivet(7,2);
rivet(7,1);
rivet(7,0);

rivet(8,6);
rivet(8,5);
rivet(8,4);
//rivet(8,3);
rivet(8,2);
//rivet(8,1);
rivet(8,0);

rivet(9,6);
rivet(9,5);
rivet(9,4);
//rivet(9,3);
rivet(9,2);
//rivet(9,1);
rivet(9,0);

rivet(10,6);
rivet(10,5);
rivet(10,4);
rivet(10,3);
rivet(10,2);
rivet(10,1);
rivet(10,0);
// END GRID RIVIETS //////////////////

// BALANCE RIVETS ///////////////
rivet(3, 6/16);
rivet(3, 22/16);
rivet(3, 38/16);
// END BALANCE RIVETS /////////////

// BELLCRANK RIVETS ////////////
rivet(5.17678, 1.17678);
rivet(5.17678, 4.17678);
rivet(6.17678, 3.17678);
rivet(6.17678, 5.17678);

// LOCK INPUT RIVETS //////////////
rivet(7.5, 6/16);
rivet(7.5, 26/16);
rivet(7.5, 38/16);
rivet(7.5, 58/16);

// end of "difference()" line above for creating single layers - uncomment if needed
// }