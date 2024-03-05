part = "3001"; // ["3001", "3002", "3003", "3004", "3005", "3006", "3007", "3008", "3009", "3010", "3011", "3020", "3021", "3022", "3023", "3024", "3026", "3027", "3028", "3029", "3030", "3031", "3032", "3033", "3034", "3035", "3036", "3037", "3038", "3039", "3040", "3068b", "3623", "3641", "3710", "3788", "3821", "3822", "3823", "3828", "3829a", "3937", "3938", "4070", "4079", "4213", "4214", "4215", "4315", "4600", "4624", "6141"]

// minimum angle for a fragment
$fa=1;
// minimum size of a fragment
$fs=0.2;

sc=2/5;
eps=1/128;

function v2(d) = [d, d];
function v2d(s, d=0) = [s.x, s.y] * 20 - v2(d);
function v2dl(s, d=0) = [s.x, s.y] * 40 - v2(d);

module loc(s) for(i=[0:1:s.x], j=[0:1:s.y])
    translate([i*20-(s.x)*10, j*20-(s.y)*10]) children();
module locl(s) for(i=[0:1:s.x], j=[0:1:s.y])
    translate([i*40-(s.x)*20, j*40-(s.y)*20]) children();

module stud(h, r1, r2=0, dir=1) mirror([0, 0, dir==-1?1:0])
    linear_extrude(h, center=dir==0) difference() {
        circle(d=r1);
        circle(d=r2);
    }

module basic(s, stud=[true, true, false], cut=false,
    chamfer=false) render() scale(sc)
    translate([0, chamfer?-10:0, 0]) difference() {
    union() {
        mirror([0, 0, 1]) difference() {
            union() {
                linear_extrude((s.z?24*s.z:8)-(cut?1:0))
                    square(v2d(s), center=true);
                linear_extrude(s.z?24*s.z:8)
                    square(v2d(s, 2), center=true);
            }
            translate([0, 0, 4]) linear_extrude(s.z?24*s.z:8)
                square(v2d(s, 8), center=true);
        }
        if(stud.x) loc(s-v2(1)) stud(4, 12, stud.z?8:0);
        if(stud.y)
            if(s.x>1 && s.y>1) loc(s-v2(2))
                stud(s.z?24*s.z:8, 16, 12, dir=-1);
            else loc(s-(s.x==1?[1, 2]:[2, 1]))
                stud(s.z?24*s.z:8, 8, dir=-1);
        if(chamfer) rotate([0, 90, 0])
            linear_extrude(s.x*20, center=true) polygon([
                [0, 0], [4, 0], [20, -16], [20, -20]]);
    }
    if(chamfer) rotate([45, 0, 0])
        translate([-50, -100, 0]) cube(100);
}

module large(s, stud=[true, true, true], cut=false)
    render() scale(sc) {
    mirror([0, 0, 1]) difference() {
        union() {
            linear_extrude((s.z?48*s.z:8)-(cut?1:0))
                square(v2dl(s), center=true);
            linear_extrude(s.z?48*s.z:8)
                square(v2dl(s, 2), center=true);
        }
        translate([0, 0, 4])
            linear_extrude(s.z?48*s.z:8)
                square(v2dl(s, 8), center=true);
    }
    if(stud.x) locl(s-v2(1)) stud(11, 24, stud.z?18:0);
    if(stud.y)
        if(s.x>1 && s.y>1) locl(s-v2(2))
            stud(s.z?44*s.z:8, 32, 28, dir=-1);
        else locl(s-(s.x==1?[1, 2]:[2, 1]))
            stud(s.z?24*s.z:8, 8, dir=-1);
    locl([s.x-1, 0]) for(i=[-1, 1])
        translate([0, i*(s.y*20-4), -23.5])
            cube([3, 8, 47], center=true);
    locl([0, s.y-1]) for(i=[-1, 1])
        translate([i*(s.x*20-4), 0, -23.5])
            cube([8, 3, 47], center=true);
}

module p3001() /*[3001]*/ basic([4, 2, 1]);
module p3002() /*[3002]*/ basic([3, 2, 1]);
module p3003() /*[3003]*/ basic([2, 2, 1]);
module p3004() /*[3004]*/ basic([2, 1, 1]);
module p3005() /*[3005]*/ basic([1, 1, 1]);
module p3006() /*[3006]*/ basic([10, 2, 1]);

module p3007() /*[3007]*/ render() {
    basic([8, 2, 1]);
    scale(sc) mirror([0, 0, 1]) linear_extrude(18.5)
        for(i=[-40,0,40], j=[-12, 12]) translate([i, j])
            square([2, 10], center=true);
}

module p3008() /*[3008]*/ basic([8, 1, 1]);
module p3009() /*[3009]*/ basic([6, 1, 1]);
module p3010() /*[3010]*/ basic([4, 1, 1]);
module p3011() /*[3011]*/ large([4, 2, 1]);
module p3020() /*[3020]*/ basic([4, 2, 0]);
module p3021() /*[3021]*/ basic([3, 2, 0]);
module p3022() /*[3022]*/ basic([2, 2, 0]);
module p3023() /*[3023]*/ basic([2, 1, 0]);
module p3024() /*[3024]*/ basic([1, 1, 0]);
module p3026() /*[3026]*/ basic([24, 6, 0]);
module p3027() /*[3027]*/ basic([16, 6, 0]);
module p3028() /*[3028]*/ basic([12, 6, 0]);
module p3029() /*[3029]*/ basic([12, 4, 0]);
module p3030() /*[3030]*/ basic([10, 4, 0]);
module p3031() /*[3031]*/ basic([4, 4, 0]);
module p3032() /*[3032]*/ basic([6, 4, 0]);
module p3033() /*[3033]*/ basic([10, 6, 0]);
module p3034() /*[3034]*/ basic([8, 2, 0]);
module p3035() /*[3035]*/ basic([8, 4, 0]);
module p3036() /*[3036]*/ basic([8, 6, 0]);
module p3037() /*[3037]*/ basic([4, 2, 1], chamfer=true);
module p3038() /*[3038]*/ basic([3, 2, 1], chamfer=true);
module p3039() /*[3039]*/ basic([2, 2, 1], chamfer=true);
module p3040() /*[3040]*/ basic([1, 2, 1], chamfer=true);
module p3068b() /*[3068b]*/
    basic([2, 2, 0], stud=[false, true], cut=true);
module p3623() /*[3623]*/ basic([3, 1, 0]);

// wheel
module p3641() /*[3641]*/ render() {
    for(i=[0:45/2:360], j=[0, 1])
        rotate([90-j*180, i-j*eps, 0])
            rotate_extrude(angle=45/4+eps) scale(sc) polygon([
                [14, 0], [14, 8], [10, 8], [10, 4], [8, 3],
                [8, -3], [10, -4], [10, -8], [18, -8], [18, 0]]);
}

module p3710() /*[3710]*/ basic([4, 1, 0]);

module p3788() /*[3788]*/ render() {
    translate([0, 0, -8*sc]) basic([2, 2, 0]);
    for(i=[0, 1]) mirror([i, 0, 0])
    translate([30*sc, 0, 0]) difference() {
        basic([1, 2, 2/3], stud=[true, false]);
        scale(sc) rotate([0, 90, 0]) linear_extrude(20)
        polygon([[17, 16], [16, 16], [5, 8],
                 [5, -8], [16, -16], [17, -16]]);
        scale(sc) rotate([90, 180, 0]) linear_extrude(32, center=true)
        polygon([[0, 17], [10, 17], [10, 16], [6, 6]]);
    }
}

module p3821() /*[3821]*/ render() scale(sc) {
    stud(4, 12);
    stud(4, 20, dir=-1);
    difference() {
        union() {
            mirror([0, 0, 1]) linear_extrude(24) difference() {
                union() {
                    circle(d=20);
                    rotate(90) square(10);
                    translate([-10, 0, 0]) square([4, 50]);
                }
                circle(d=12);
            }
            rotate([0, -90, 0]) translate([0, 0, 7])
                linear_extrude(8) hull() for(i=[36, 44])
                    translate([-12, i]) circle(d=4);
        }
        rotate([0, -90, 0]) translate([0, 0, 5])
            linear_extrude(8) translate([-12, 44]) circle(d=4);
    }
}

module p3822() /*[3822]*/ render() mirror([1, 0, 0]) p3821();

module p3823() /*[3823]*/ render() scale(sc) {
    for(i=[-30, 30]) translate([i, 0]) stud(4, 12, 8);
    translate([0, -20, -40]) loc([2, 0]) stud(8, 8, dir=-1);
    for(i=[-30, 30]) translate([i, -10, -40]) stud(8, 8, dir=-1);
    translate([0, 0, -48]) difference() {
        linear_extrude(8) difference() {
            hull() {
                for(i=[-30, 30]) translate([i, -20])
                    circle(d=20);
                square([80, 20], center=true);
            }
            for(i=[-20, 20]) translate([i, 10]) circle(d=20);
            square([40, 20], center=true);
        }
        linear_extrude(4) {
            difference() {
                hull() {
                    for(i=[-30, 30]) translate([i, -20])
                        circle(d=12);
                    square([72, 12], center=true);
                }
                square([48, 28], center=true);
            }
            for(i=[-20, 20]) translate([i, 10])
                square(20, center=true);
        }
    }
    multmatrix([[1, 0, 0, 0],
                [0, 1, 1/2, 0],
                [0, 0, 1, 0]]) mirror([0, 0, 1])
        linear_extrude(40) difference() {
            hull() {
                for(i=[-30, 30]) translate([i, 0])
                    circle(d=20);
                translate([0, 5]) square([80, 10], center=true);
            }
            hull() {
                for(i=[-30, 30]) translate([i, 0])
                    circle(d=12);
                translate([0, 5]) square([72, 10], center=true);
            }
        }
    for(i=[-38, 38], j=[0, 10]) translate([i, 5-j, -20-j])
        cube([4, 10, 40-2*j], center=true);
    mirror([0, 0, 1]) linear_extrude(4) for(i=[0, 1])
        mirror([i, 0]) translate([30, 0]) {
            circle(d=20);
            for(i=[0, 180]) rotate(i) square(10);
        }
}

module p3828() /*[3828]*/ render() scale(sc) {
    linear_extrude(4, center=true) difference() {
        circle(d=28);
        circle(d=24);
    }
    mirror([0, 0, 1]) linear_extrude(6) difference() {
        circle(d=12);
        circle(d=8);
    }
    for(i=[0, 120, 240]) rotate([90, 180, i])
        linear_extrude(3, center=true)
            polygon([[4, 0], [6, 0], [12, 0],
                     [12, 2], [6, 6], [4, 6]]);
}

module p3829a() /*[3829a]*/ render() {
    basic([2, 1, 0], stud=[false, true]);
    scale(sc) {
        translate([0, -6, 0]) difference() {
            linear_extrude(24) {
                translate([-10, -4]) square([20, 4]);
                difference() {
                    scale([1, 3/4]) circle(d=12);
                    translate([-10, -8]) square([20, 4]);
                }
            }
            translate([0, 0, 24]) rotate([-53.13, 0, 0])
                translate([0, 0, 10]) cube(20, center=true);
        }
        translate([0, -10, 24]) rotate([-53.13, 0, 0]) translate([0, 4, 0]) cylinder(9, d=8);
    }
}

module p3937() /*[3937]*/ render() scale(sc)
    for(i=[0, 1]) mirror([i, 0, 0]) {
    translate([0, 7, -24]) cube([20, 3, 22]);
    translate([0, -8, -20]) cube([20, 18, 4]);
    translate([0, -10, -24]) linear_extrude(4) difference() {
        square([20, 20]);
        polygon([[2, 4], [16, 4], [16, 16], [2, 16],
                 [2, 12], [4, 12], [4, 8], [2, 8]]);
    }
    rotate([0, 90, 0]) linear_extrude(2) hull()
        for(i=[10, 16]) translate([i, 0]) circle(d=4);
    rotate([0, 90, 0]) translate([0, 0, 16]) linear_extrude(4) translate([10, 0]) difference() {
        hull() {
            circle(d=16);
            translate([-8, 0]) square([16, 10]);
            translate([0, -8]) square(8);
        }
        circle(d=8);
        polygon([
            [0, 2.5],
            [-10, 5],
            [-10, -5],
            [0, -2.5],
        ]);
 difference() {
    translate([-8, -4])
        circle(d=6);
    translate([-4.92, -4.85])
        circle(d=2.2);
        }
    }
}

module p3938() /*[3938]*/ render() {
    basic([2, 1, 1/12], stud=[true, false, true]);
    scale(sc) rotate([0, 90, 0]) translate([10, 0]) {
        difference() {
            union() {
                cylinder(40, d=8, center=true);
                linear_extrude(32, center=true) {
                    circle(d=12);
                    translate([-5, 0])
                        square([10, 12], center=true);
                }
            }
            for(i=[-5, 5]) translate([0, i])
                cube([16, 6, 28], center=true);
             translate([3, 0]) cube([10, 6, 4], center=true);
        }
    }
}

// ample +double line
module p4070() /*[4070]*/ render() scale(sc) difference() {
    union() {
        cylinder(4, d=12);
        translate([0, -6, -10]) rotate([90, 0, 0])
            cylinder(4, d=12);
        translate([-10, -6, -24]) cube([20, 16, 24]);
        translate([-10, -10, -24]) cube([20, 20, 4]);
        translate([0, -6, -20]) rotate([45, 0, 0])
            cube([20, eps, eps], center=true);
    }
    translate([-6, -6, -24]) cube([12, 12, 4]);
    translate([-6, -2, -24]) cube([12, 8, 20]);
    translate([-6, -2, -16]) cube([12, 13, 12]);
    translate([0, 0, -10]) rotate([90, 0, 0]) cylinder(11, d=8);
}

module p4079() /*[4079]*/ render() scale(sc) {
    translate([0, -10]) loc([1, 0]) stud(4, 12);
    stud(8, 16, 12, dir=-1);
    difference() {
        union() {
            mirror([0, 0, -1]) linear_extrude(8) hull() {
                for(i=[-16, 16]) translate([i, -16]) circle(d=8);
                for(i=[-16, 16]) translate([i, 16])
                    square(8, center=true);
            }
            translate([0, 0, 40])
            multmatrix([[1, 0, 0, 0],
                        [0, 1, 1/16, 0],
                        [0, 0, 1, 0]])
            translate([0, 0, -40]) translate([0, 20, 0]) {
                rotate([-90, 0, 0]) linear_extrude(5) hull() {
                    for(i=[-16, 16]) translate([i, -36])
                        circle(d=8);
                    translate([0, -16])
                        square([40, 16], center=true);
                }
                translate([0, -8, 8]) rotate([0, 90, 0])
                    linear_extrude(40, center=true)
                        intersection() {
                            circle(d=26);
                            difference() {
                                square(13);
                                circle(d=16);
                            }
                        }
            }
        }
        rotate([0, 90, 0]) linear_extrude(28, center=true)
            hull() for(i=[-40, -7], j=[0, 13])
                translate([i, j]) circle(d=14);
        mirror([0, 0, -1]) translate([0, 0, 8])
           cube([32, 32, 8], center=true);
    }
}

module p4213() /*[4213]*/ render() scale(sc) {
    translate([0, -10]) loc([3, 2]) stud(4, 12);
    translate([0, -20]) difference() {
        loc([2, 0]) stud(8, 16, 12, dir=-1);
        mirror([0, 0, 1])
            for(i=[-22.5, 45, 112.5]) rotate(i) cube(8);
    }
    difference() {
        rotate([0, 90, 0]) linear_extrude(80, center=true)
            hull() {
                translate([4, 36]) circle(d=8);
                translate([0, -40]) square(8);
            }
        for(i=[-38, -20, 0, 20, 38]) translate([i, 40, 0])
            cube([4, 16, 20], center=true);
        for(i=[-43.25, 43.25]) translate([i, 36, -4])
            intersection() {
                sphere(d=16);
                cube([16, 8, 8], center=true);
            }
        mirror([0, 0, 1]) translate([0, 0, 3])
            linear_extrude(8) {
                translate([0, -4])
                    square([72, 64], center=true);
                for(i=[0, 1]) mirror([i, 0]) {
                    translate([10, 28])
                        square([8, 16], center=true);
                    translate([29, 28])
                        square([6, 16], center=true);
                }
            }
        mirror([0, 0, 1]) translate([0, 0, 2])
            linear_extrude(8) {
                translate([0, 4]) circle(d=42);
                translate([0, 16]) square([42, 24], center=true);
            }
    }
}

module p4214() /*[4214]*/ render() {
    for(i=[-30, 30]) translate([i, 0, -40]*sc)
        basic([1, 1, 0], [false, false, false]);
    scale(sc) {
        translate([-20, 10, -40])
            mirror([0, 0, 1]) mirror([0, 1, 0]) {
                cube([40, 4, 8]);
                cube([40, 10, 2]);
            }
        mirror([0, 0, 1]) linear_extrude(4) difference() {
            square([80, 20], center=true);
            hull() for(i=[-30, 30], j=[-4, -10])
                translate([i, j]) circle(d=12);
        }
        mirror([0, 0, 1]) linear_extrude(48) for(i=[-38, 38])
            translate([i, 0]) square([4, 20], center=true);
        for(j=[-38, -20, 0, 20, 38]) translate([j, 0, 0])
            rotate([0, -90, 0]) linear_extrude(4, center=true)
                hull() for(i=[0, 4]) translate([i, 6])
                    circle(d=8);
    }
}

module p4215() /*[4215]*/ render() {
    basic([4, 1, 1/6], [true, false, true]);
    translate([0, 0, -64]*sc)
        basic([4, 1, 0], [false, true, false]);
    scale(sc) translate([-40, 10, 0])
        mirror([0, 0, 1]) mirror([0, 1, 0]) cube([80, 4, 72]);
}

module p4315() /*[4315]*/ render() {
    basic([4, 1, 0]);
    scale(sc) {
        for(j=[-38, -20, 0, 20, 38]) translate([j, 0, 0])
            rotate([0, -90, 0]) linear_extrude(4, center=true)
                hull() for(i=[-10, -14]) translate([-4, i])
                    circle(d=8);
        for(i=[0, 1]) mirror([i, 0, 0])
            translate([43.25, -14, -4]) intersection() {
                sphere(d=16);
                translate([-11.25, 0, 0]) cube(8, center=true);
            }
    }
}

module p4600() /*[4600]*/ render() {
    basic([2, 2, 0]);
    scale(sc) for(i=[0, 1]) mirror([i, 0, 0]) {
        mirror([0, 0, 1]) linear_extrude(8) translate([13, 0])
            square([14, 4], center=true);
        translate([0, 0, -8]) linear_extrude(6)
            polygon([[20, -10], [22, -5], [22, 5], [20, 10]]);
        difference() {
            rotate([0, 90, 0]) translate([5, 0, 20]) {
                cylinder(2, d=10);
                cylinder(14, d=8);
                translate([0, 0, 13]) cylinder(1, d=8.6);
            }
            linear_extrude(20, center=true) hull()
                for(i=[26.6, 35]) translate([i, 0])
                    circle(d=1.3);
        }
    }
}

module p4624() /*[4624]*/ render() scale(sc) {
    difference() {
        rotate([-90, 0, 0]) rotate_extrude() polygon([
            [0, 8], [10, 8], [10, 4], [8, 2],
            [8, -2], [10, -4], [10, -8], [0, -8]]);
        rotate([-90, 0, 0]) translate([0, 0, -2])
            linear_extrude(11) {
                intersection() {
                    circle(d=12);
                    for(i=[0, 90]) rotate(i)
                        square([20, 3], center=true);
                }
                circle(d=8);
            }
        rotate([90, 0, 0]) translate([0, 0, 2])
            cylinder(3, d=12);
        rotate([90, 0, 0]) translate([0, 0, 5]) difference() {
            cylinder(3, d1=12, d2=16.7);
            linear_extrude(3) {
                circle(d=8);
                for(i=[0, 90]) rotate(i)
                    square([20, 3], center=true);
            }
        }
    }
}

module p6141() /*[6141]*/ render() scale(sc) {
    stud(4, 12);
    stud(3, 20, dir=-1);
    stud(8, 16, 12, dir=-1);
}

module not_there() {
    echo("WARNING: Unknown part number!");
    color("red") render() scale(sc) for(i=[90:90:360]) rotate(i)
        polyhedron([[-10, -10, -24], [-10, -10, -20],
                    [-10, -6, -24], [-10, -6, -20],
                    [-6, -10, -24], [-6, -10, -20],
                    [-6, -6, -24], [10, 10, 0],
                    [10, 10, -4], [10, 6, 0],
                    [10, 6, -4], [6, 10, 0],
                    [6, 10, -4], [6, 6, 0]],
                   [[1, 0, 2, 3], [0, 1, 5, 4],
                    [2, 0, 4, 6], [10, 9, 7, 8],
                    [11, 12, 8, 7], [13, 11, 7, 9],
                    [3, 2, 12, 11], [2, 6, 8, 12],
                    [6, 4, 10, 8], [4, 5, 9, 10],
                    [5, 1, 13, 9], [1, 3, 11, 13]]);
}

module soldraw(part) //[AUTOGEN MODULE]
    if(part=="3001") p3001(); else //[AUTODEL]
    if(part=="3002") p3002(); else //[AUTODEL]
    if(part=="3003") p3003(); else //[AUTODEL]
    if(part=="3004") p3004(); else //[AUTODEL]
    if(part=="3005") p3005(); else //[AUTODEL]
    if(part=="3006") p3006(); else //[AUTODEL]
    if(part=="3007") p3007(); else //[AUTODEL]
    if(part=="3008") p3008(); else //[AUTODEL]
    if(part=="3009") p3009(); else //[AUTODEL]
    if(part=="3010") p3010(); else //[AUTODEL]
    if(part=="3011") p3011(); else //[AUTODEL]
    if(part=="3020") p3020(); else //[AUTODEL]
    if(part=="3021") p3021(); else //[AUTODEL]
    if(part=="3022") p3022(); else //[AUTODEL]
    if(part=="3023") p3023(); else //[AUTODEL]
    if(part=="3024") p3024(); else //[AUTODEL]
    if(part=="3026") p3026(); else //[AUTODEL]
    if(part=="3027") p3027(); else //[AUTODEL]
    if(part=="3028") p3028(); else //[AUTODEL]
    if(part=="3029") p3029(); else //[AUTODEL]
    if(part=="3030") p3030(); else //[AUTODEL]
    if(part=="3031") p3031(); else //[AUTODEL]
    if(part=="3032") p3032(); else //[AUTODEL]
    if(part=="3033") p3033(); else //[AUTODEL]
    if(part=="3034") p3034(); else //[AUTODEL]
    if(part=="3035") p3035(); else //[AUTODEL]
    if(part=="3036") p3036(); else //[AUTODEL]
    if(part=="3037") p3037(); else //[AUTODEL]
    if(part=="3038") p3038(); else //[AUTODEL]
    if(part=="3039") p3039(); else //[AUTODEL]
    if(part=="3040") p3040(); else //[AUTODEL]
    if(part=="3068b") p3068b(); else //[AUTODEL]
    if(part=="3623") p3623(); else //[AUTODEL]
    if(part=="3641") p3641(); else //[AUTODEL]
    if(part=="3710") p3710(); else //[AUTODEL]
    if(part=="3788") p3788(); else //[AUTODEL]
    if(part=="3821") p3821(); else //[AUTODEL]
    if(part=="3822") p3822(); else //[AUTODEL]
    if(part=="3823") p3823(); else //[AUTODEL]
    if(part=="3828") p3828(); else //[AUTODEL]
    if(part=="3829a") p3829a(); else //[AUTODEL]
    if(part=="3937") p3937(); else //[AUTODEL]
    if(part=="3938") p3938(); else //[AUTODEL]
    if(part=="4070") p4070(); else //[AUTODEL]
    if(part=="4079") p4079(); else //[AUTODEL]
    if(part=="4213") p4213(); else //[AUTODEL]
    if(part=="4214") p4214(); else //[AUTODEL]
    if(part=="4215") p4215(); else //[AUTODEL]
    if(part=="4315") p4315(); else //[AUTODEL]
    if(part=="4600") p4600(); else //[AUTODEL]
    if(part=="4624") p4624(); else //[AUTODEL]
    if(part=="6141") p6141(); else //[AUTODEL]
    not_there();

soldraw(part);
