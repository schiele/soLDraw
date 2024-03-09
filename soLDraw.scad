part = "3001"; // ["3001", "3002", "3003", "3004", "3005", "3006", "3007", "3008", "3009", "3010", "3011", "3020", "3021", "3022", "3023", "3024", "3026", "3027", "3028", "3029", "3030", "3031", "3032", "3033", "3034", "3035", "3036", "3037", "3038", "3039", "3040", "3041", "3042", "3043", "3044", "3045", "3046", "3048", "3049", "3058", "3068b", "3623", "3641", "3710", "3788", "3821", "3822", "3823", "3828", "3829a", "3937", "3938", "4070", "4079", "4213", "4214", "4215", "4315", "4600", "4624", "6141"]

$fn=32;

sc=2/5;
eps=1/128;
unit=[1, 1, 1];
bsp=1;

module sc() render() scale(sc) children();

module downext(h) mirror([0, 0, 1]) linear_extrude(h) children();
module filt(s=[100, 100]) render() intersection() {
    children();
    linear_extrude(200, center=true)
        translate(-eps*unit) square(s+eps*unit);
}

module cmirror() for(i=[0, 1]) mirror([i, -i, 0]) children();
module dmirror() for(i=[0, 1]) mirror([i, i, 0]) children();
module xmirror() for(i=[0, 1]) mirror([i, 0, 0]) children();
module ymirror() for(i=[0, 1]) mirror([0, i, 0]) children();
module fmirror() for(i=[0, 1], j=[0, 1])
    mirror([i, 0, 0]) mirror([0, j, 0]) children();

module acir(d, n=16) intersection_for(i=[360/n:360/n:90])
    rotate(i) square(d, center=true);

module bstud(stud=[true, true, false]) if(stud.x) filt() {
    translate([0, 0, -eps]) linear_extrude(3.5) difference() {
        acir(12);
        if(stud.z) acir(8);
    }
    linear_extrude(4) difference() {
        acir(11);
        if(stud.z) acir(8);
    }
}

module bstud3(h, stud=[true, true, false]) filt() {
    translate([0, 10])
        if(stud.y==2) {
            downext(h) hull() for(i=[-2.5, 2.5])
                translate([0, i]) acir(d=3);
            downext(h-5) square([20, 2], center=true);
        } else if(stud.y) downext(h) acir(8);
}

module bstud4(h, stud=[true, true, false]) if(stud.y) filt() {
    translate([10, 10]) downext(h) difference() {
        acir(20*sqrt(2)-12);
        acir(12);
    }
    cmirror() downext(min(4, h))
        translate([0, 9]) square(6, center=true);
} else cmirror() downext(min(4, h))
    translate([0, 9]) square([21, 6], center=true);


module bcorner(h, stud=[true, true, false]) filt() {
    bstud(stud);
    downext(min(4-bsp, h)) square(20, center=true);
    downext(h) cmirror()
        translate([8, 0]) square([4, 20], center=true);
}
    
module brcorner(h, stud=[true, true, false]) filt() {
    bstud(stud);
    downext(min(4-bsp, h)) acir(20, 32);
    downext(h) difference() {
        acir(20, 32);
        acir(12, 32);
     }
}
    
module bicorner(h, stud=[true, true, false]) filt([10+eps, 10+eps]) {
    bstud(stud);
    downext(min(4-bsp, h)) square(20, center=true);
    cmirror() {
        downext(min(4, h))
            translate([0, 9]) square([20, 6], center=true);
        downext(h)
            translate([8, 9]) square([4, 6], center=true);
    }
}
    
module bside(h, stud=[true, true, false]) filt([10, 10+eps]) {
    bstud(stud);
    downext(min(4-bsp, h)) square([20, 21], center=true);
    downext(min(4, h)) translate([0, 9])
        square([20, 6], center=true);
    downext(h) translate([8, 0]) square([4, 21], center=true);
}

module bside3(h, stud=[true, true, false]) filt([10, 10+eps]) {
    bside(h, stud);
    bstud3(h, stud);
}

module binside(h, stud=[true, true, false])
    filt([10+eps, 10+eps]) {
        bstud(stud);
        downext(min(4-bsp, h)) square([21, 21], center=true);
        cmirror() downext(min(4, h))
            translate([0, 9]) square([21, 6], center=true);
    }

module binside4(h, stud=[true, true, false])
    filt([10+eps, 10+eps]) {
        bstud(stud);
        downext(min(4-bsp, h)) square([21, 21], center=true);
        bstud4(h, stud);
    }

module ccorner(h, stud=[true, true, false]) render() {
    bcorner(h, stud);
    cmirror() rotate(90) bside(h, stud);
    rotate(180) binside4(h, stud);
}

module cicorner(h, stud=[true, true, false]) render() {
    rotate(180) bicorner(h, stud);
    for(i=[0, 90, -90]) rotate(i) binside4(h, stud);
}

module cdcorner(h, stud=[true, true, false]) render() {
    rotate(-90) brcorner(h, stud);
    dmirror() bside3(h, stud);
    rotate(90) {
        bicorner(h, stud);
        cmirror() bstud3(h);
    }
}

module cside(h, stud=[true, true, false]) render() xmirror() {
    rotate(90) bside(h, stud);
    rotate(180) binside4(h, stud);
}

module csideicorner(h, stud=[true, true, false]) render() {
    rotate(180) {
        bicorner(h, stud);
        mirror([1, -1, 0]) bstud3(h);
    }
    rotate(-90) binside4(h, stud);
    rotate(90) bside3(h, stud);
    rotate(90) mirror([0, 1, 0]) bside(h, stud);
}

module cdside(h, stud=[true, true, false]) render() fmirror()
    rotate(90) bside3(h, stud);

module cinside(h, stud=[true, true, false]) render() fmirror()
    binside4(h, stud);

module cterm(h, stud=[true, true, false]) render() ymirror() {
    bcorner(h, stud);
    rotate(90) bside3(h, stud);
}

module csingle(h, stud=[true, true, false]) render() fmirror()
    bcorner(h, stud);

module crsingle(h, stud=[true, true, false]) render() fmirror()
    brcorner(h, stud);

module dcore(s, stud=[true, true, false]) render()
    let(h=s.z?24*s.z:8) fmirror() {
        if(s.x==1 && s.y==1) {
            csingle(h, stud);
        } else if(s.x==1) {
            translate([0, s.y-1]*10) rotate(90) cterm(h, stud);
            for(i=[s.y-3:-2:0]) translate([0, i]*10)
                rotate(90) cdside(h, stud);
        } else if(s.y==1) {
            translate([s.x-1, 0]*10) cterm(h, stud);
            for(i=[s.x-3:-2:0])
                translate([i, 0]*10) cdside(h, stud);
        } else {
            translate([s.x-1, s.y-1]*10) ccorner(h, stud);
            for(i=[s.x-3:-2:0])
                translate([i, s.y-1]*10) cside(h, stud);
            for(i=[s.y-3:-2:0]) translate([s.x-1, i]*10)
                rotate(-90) cside(h, stud);
            for(i=[s.x-3:-2:0], j=[s.y-3:-2:0])
                translate([i, j]*10) cinside(h, stud);
        }
    }

module dbasic(s, stud=[true, true, false]) sc() dcore(s, stud);

module dchamfer1(s, stud=[true, true, false]) sc()
    translate([0, -10, 0]) difference() {
        union() {
            dcore(s, stud);
            rotate([0, 90, 0])
                linear_extrude(s.x*20, center=true)
                    polygon([[0, 0], [0, 4],
                        [20, -16], [20, -20]]);
        }
        rotate([45, 0, 0]) translate([-50, -100, 0]) cube(100);
    }

module dchamfer2(s, stud=[true, true, false]) sc()
    translate([10, -10, 0]) difference() {
        union() {
            dcore(s, stud);
            for(i=[0, 90])
                rotate([0, 90, i])
                    linear_extrude(s.x*20, center=true)
                        polygon([[0, 0], [0, 4],
                                 [20, -16], [20, -20]]);
        }
        for(i=[0, 90]) rotate([45, 0, i])
            translate([-50, -100, 0]) cube(100);
    }

module dchamfer3(s, stud=[true, true, false]) sc() difference() {
    union() {
        dcore(s, stud);
        for(i=[0, 180])
            rotate([0, 90, i])
                linear_extrude(s.x*20, center=true)
                    polygon([[0, 0], [0, 4],
                             [20, -16], [20, -20]]);
    }
    for(i=[0, 180]) rotate([45, 0, i])
        translate([-50, -100, 0]) cube(100);
}

module dchamfer4(s, stud=[true, true, false]) sc()  difference() {
    union() {
        dcore(s, stud);
        for(i=[0, 90, -90]) translate([0, i==0?10:0, 0])
            rotate([0, 90, i])
                linear_extrude((i?s.y:s.x)*20, center=true)
                    polygon([[0, 0], [4, 0],
                             [20, -16], [20, -20]]);
    }
    for(i=[0, 90, -90]) translate([0, i==0?10:0, 0])
        rotate([45, 0, i]) translate([-50, -100, 0]) cube(100);
}

module dchamfer5(s, stud=[true, true, false], chamfer=5) sc()
    translate([10, -10, 0]) difference() {
        union() {
            dcore(s, stud);
            for(i=[0, 1]) mirror([i, i, 0]) intersection() {
                rotate([0, 90, 0])
                    linear_extrude(s.x*20, center=true)
                        polygon([[0, 0], [0, 4],
                                 [20, -16], [20, -20]]);
                rotate([90, 90, 0])
                    linear_extrude(s.x*20, center=true)
                        polygon([[0, -4], [20, 16],
                                 [20, 20], [0, 20]]);
            }
        }
        intersection_for(i=[0, 90]) rotate([45, 0, i])
            translate([-50, -100, 0]) cube(100);
    }

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

module stud0(cut=false) stud(4, 12, cut?8:0);
module stud3(h) stud(h, 8, dir=-1);
module stud4(h) stud(h, 20*sqrt(2)-12, 12, dir=-1);

module large(s, stud=[true, true, true], cut=false)
    sc() {
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

module p3001() /*[3001]*/ dbasic([4, 2, 1]);
module p3002() /*[3002]*/ dbasic([3, 2, 1]);
module p3003() /*[3003]*/ dbasic([2, 2, 1]);
module p3004() /*[3004]*/ dbasic([2, 1, 1]);
module p3005() /*[3005]*/ dbasic([1, 1, 1]);
module p3006() /*[3006]*/ dbasic([10, 2, 1]);

module p3007() /*[3007]*/ sc() {
    dcore([8, 2, 1]);
    mirror([0, 0, 1]) linear_extrude(18.5)
        for(i=[-40,0,40], j=[-12, 12]) translate([i, j])
            square([2, 10], center=true);
}

module p3008() /*[3008]*/ dbasic([8, 1, 1]);
module p3009() /*[3009]*/ dbasic([6, 1, 1]);
module p3010() /*[3010]*/ dbasic([4, 1, 1]);
module p3011() /*[3011]*/ large([4, 2, 1]);
module p3020() /*[3020]*/ dbasic([4, 2, 0]);
module p3021() /*[3021]*/ dbasic([3, 2, 0]);
module p3022() /*[3022]*/ dbasic([2, 2, 0]);
module p3023() /*[3023]*/ dbasic([2, 1, 0]);
module p3024() /*[3024]*/ dbasic([1, 1, 0]);
module p3026() /*[3026]*/ dbasic([24, 6, 0]);
module p3027() /*[3027]*/ dbasic([16, 6, 0]);
module p3028() /*[3028]*/ dbasic([12, 6, 0]);
module p3029() /*[3029]*/ dbasic([12, 4, 0]);
module p3030() /*[3030]*/ dbasic([10, 4, 0]);
module p3031() /*[3031]*/ dbasic([4, 4, 0]);
module p3032() /*[3032]*/ dbasic([6, 4, 0]);
module p3033() /*[3033]*/ dbasic([10, 6, 0]);
module p3034() /*[3034]*/ dbasic([8, 2, 0]);
module p3035() /*[3035]*/ dbasic([8, 4, 0]);
module p3036() /*[3036]*/ dbasic([8, 6, 0]);
module p3037() /*[3037]*/ dchamfer1([4, 2, 1]);
module p3038() /*[3038]*/ dchamfer1([3, 2, 1]);
module p3039() /*[3039]*/ dchamfer1([2, 2, 1]);
module p3040() /*[3040]*/ dchamfer1([1, 2, 1]);
module p3041() /*[3041]*/ dchamfer3([4, 2, 1]);
module p3042() /*[3042]*/ dchamfer3([3, 2, 1]);
module p3043() /*[3043]*/ dchamfer3([2, 2, 1]);
module p3044() /*[3044]*/ dchamfer3([1, 2, 1], stud=[false, 2]);
module p3045() /*[3045]*/ dchamfer2([2, 2, 1]);
module p3046() /*[3046]*/ dchamfer5([2, 2, 1]);
module p3048() /*[3048]*/ dchamfer4([2, 1, 1], stud=[false, 2]);
module p3049() /*[3049]*/ render() {
    rotate(90) dchamfer3([1, 2, 1]);
    sc() intersection() {
        rotate([0, 90, 0]) linear_extrude(40, center=true)
            polygon([[0, 10], [0, 30], [20, 10]]);
        rotate([90, 90, 0]) linear_extrude(60, center=true)
            polygon([[0, 0], [20, 20], [20, 16],
                     [4, 0], [20, -16], [20, -20]]);
    }
}

module p3058() /*[3058]*/ sc() fmirror() {
    for(i=[7:-2:1]) translate([i, 5]*10) cdside(8);
    translate([15, 5]*10) ccorner(8);
    translate([9, 3]*10) rotate(180) ccorner(8);
    for(i=[13, 11]) translate([i, 5]*10) cside(8);
    for(i=[3, 1]) {
        translate([15, i]*10) rotate(-90) cside(8);
        translate([13, i]*10) cinside(8);
    }
    translate([11, 1]*10) rotate(90) cside(8);
    translate([11, 3]*10) cicorner(8);
    translate([9, 5]*10) csideicorner(8);
}

module p3068b() /*[3068b]*/ sc() difference() {
    dcore([2, 2, 0], stud=[false, true]);
    translate([0, 0, -7]) downext(10) difference() {
        square(41, center=true);
        square(38, center=true);
    }
}
module p3623() /*[3623]*/ dbasic([3, 1, 0]);

// wheel
module p3641() /*[3641]*/ sc() {
    for(i=[0:45/2:360], j=[0, 1])
        rotate([90-j*180, i-j*eps, 0])
            rotate_extrude(angle=45/4+eps, $fn=32) polygon([
                [14, 0], [14, 8], [10, 8], [10, 4], [8, 3],
                [8, -3], [10, -4], [10, -8], [18, -8], [18, 0]]);
}

module p3710() /*[3710]*/ dbasic([4, 1, 0]);

module p3788() /*[3788]*/ sc() {
    translate([0, 0, -8]) dcore([2, 2, 0]);
    for(i=[0, 1]) mirror([i, 0, 0])
    translate([30, 0, 0]) difference() {
        dcore([1, 2, 2/3], stud=[true, false]);
        rotate([0, 90, 0]) linear_extrude(20)
        polygon([[17, 16], [16, 16], [5, 8],
                 [5, -8], [16, -16], [17, -16]]);
        rotate([90, 180, 0]) linear_extrude(32, center=true)
        polygon([[0, 17], [10, 17], [10, 16], [6, 6]]);
    }
}

module p3821() /*[3821]*/ sc() {
    crsingle(24);
    rotate(90) bcorner(24);
    difference() {
        union() {
            downext(24) translate([-10, 0, 0]) square([4, 50]);
            rotate([0, -90, 0]) translate([0, 0, 7])
                linear_extrude(8) hull() for(i=[36, 44])
                    translate([-12, i]) acir(4);
        }
        rotate([0, -90, 0]) {
            translate([0, 0, 5]) linear_extrude(8)
                translate([-12, 44]) acir(4);
            translate([0, 0, 10]) linear_extrude(3)
                translate([-12, 49]) square(10, center=true);
        }
    }
}

module p3822() /*[3822]*/ render() mirror([1, 0, 0]) p3821();

module p3823() /*[3823]*/ sc() xmirror() {
    translate([30, 0]) fmirror() bstud([true, true, true]);
    translate([0, 0, -40]) {
        translate([10, -20]) cdside(8, [false, true]);
        translate([30, -20]) cdcorner(8, [false, true]);
        translate([30, 0]) {
            bcorner(8, [false, true]);
            xmirror() rotate(180) bside3(8, [false, true]);
            downext(4-bsp) difference() {
                square(20, center=true);
                translate([-10, 10]) acir(20, 32);
            }
        }
    }
    multmatrix([[1, 0, 0, 0],
                [0, 1, 1/2, 0],
                [0, 0, 1, 0]]) mirror([0, 0, 1])
        linear_extrude(40) difference() {
            hull() {
                translate([30, 0]) acir(20, 32);
                square([40, 10]);
                square([1, 20], center=true);
            }
            hull() {
                translate([30, 0]) acir(12, 32);
                square([36, 10]);
                translate([0, 4]) square([1, 20], center=true);
            }
        }
    for(i=[0, 10]) translate([38, 5-i, -20-i])
        cube([4, 10, 40-2*i], center=true);
    downext(4) translate([30, 0]) {
        circle(d=20);
        dmirror() square(10);
    }
}

module p3828() /*[3828]*/ sc() {
    linear_extrude(4, center=true) difference() {
        acir(28, 32);
        acir(24, 32);
    }
    mirror([0, 0, 1]) linear_extrude(6) difference() {
        acir(12, 32);
        acir(8, 32);
    }
    for(i=[0, 120, 240]) rotate([90, 180, i])
        linear_extrude(3, center=true)
            polygon([[4, 0], [6, 0], [12, 0],
                     [12, 2], [6, 6], [4, 6]]);
}

module p3829a() /*[3829a]*/ sc() {
    dcore([2, 1, 0], stud=[false, true]);
    translate([0, -6, 0]) difference() {
        linear_extrude(24) {
            translate([-10, -4]) square([20, 4]);
            difference() {
                scale([1, 3/4]) acir(12, 32);
                translate([-10, -8]) square([20, 4]);
            }
        }
        translate([0, 0, 24]) rotate([-53.13, 0, 0])
            translate([0, 0, 10]) cube(20, center=true);
    }
    translate([0, -10, 24]) rotate([-53.13, 0, 0])
        translate([0, 4, 0]) linear_extrude(9) acir(8, 32);
}

module p3937() /*[3937]*/ sc() xmirror() {
    translate([0, 7, -24]) cube([20, 3, 22]);
    translate([0, -8, -16]) {
        downext(4-bsp) square([20, 18]);
        downext(4) difference() {
            square([20, 18]);
            translate([4, 2]) square([12, 12]);
        }
    }
    translate([0, -10, -24]) linear_extrude(4) difference() {
        square([20, 20]);
        polygon([[2, 4], [16, 4], [16, 16], [2, 16],
                 [2, 12], [4, 12], [4, 8], [2, 8]]);
    }
    rotate([0, 90, 0]) {
        linear_extrude(2) hull()
            for(i=[10, 16]) translate([i, 0]) acir(4, 32);
        translate([0, 0, 16]) linear_extrude(4)
            translate([10, 0]) difference() {
                hull() {
                    acir(16, 32);
                    translate([-8, 0]) square([16, 10]);
                    translate([0, -8]) square(8);
                }
                acir(8, 32);
                polygon([[0, 2.5], [-10, 5],
                         [-10, -5], [0, -2.5]]);
                difference() {
                    translate([-8, -4]) acir(6, 32);
                    translate([-4.92, -4.85]) acir(2.2, 32);
                }
            }
    }
}

module p3938() /*[3938]*/ sc() {
    dcore([2, 1, 1/12], stud=[true, false, true]);
    rotate([0, 90, 0]) translate([10, 0]) {
        difference() {
            union() {
                linear_extrude(40, center=true) acir(8, 32);
                linear_extrude(32, center=true) {
                    acir(12, 32);
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

// ample
module p4070() /*[4070]*/ sc() difference() {
    union() {
        fmirror() bstud();
        translate([0, -6, -10]) rotate([90, 0, 0])
            fmirror() bstud();
        translate([-10, -6, -24]) cube([20, 16, 24]);
        translate([-10, -10, -24]) cube([20, 20, 4]);
    }
    translate([-6, -6, -24]) cube([12, 12, 4+bsp]);
    translate([-6, -10, -20]) cube([12, 16, bsp]);
    translate([-6, -2, -24]) cube([12, 8, 20]);
    translate([-6, -2, -16]) cube([12, 13, 12]);
    translate([0, 0, -10]) rotate([90, 0, 0])
        linear_extrude(11) acir(8);
}

module p4079() /*[4079]*/ sc() {
    intersection() {
        dcore([2, 2, 0], stud=[false, true]);
        downext(8) hull() for(i=[-16, 16]) {
            translate([i, -16]) acir(8, 32);
            translate([i, 16]) square(8, center=true);
        }
    }
    translate([0, -10]) loc([1, 0]) fmirror() bstud();
    difference() {
        translate([0, 0, 40])
        multmatrix([[1, 0, 0, 0],
                    [0, 1, 1/16, 0],
                    [0, 0, 1, 0]])
        translate([0, 0, -40]) translate([0, 20, 0]) {
            rotate([-90, 0, 0]) linear_extrude(5) hull() {
                for(i=[-16, 16]) translate([i, -36]) acir(8, 32);
                translate([0, -16])
                    square([40, 16], center=true);
            }
            translate([0, -8, 8]) rotate([0, 90, 0])
                linear_extrude(40, center=true) intersection() {
                    acir(26, 32);
                    difference() {
                        square([9, 13]);
                        acir(16, 32);
                    }
                }
        }
        rotate([0, 90, 0]) linear_extrude(28, center=true)
            hull() for(i=[-40, -7], j=[0, 13])
                translate([i, j]) acir(14, 32);
    }
}

module p4213() /*[4213]*/ sc() {
    translate([0, -10]) loc([3, 2]) fmirror() bstud();
    translate([0, -20]) difference() {
        loc([2, 0]) downext(8) difference() {
            acir(20*sqrt(2)-12);
            acir(12);
        }
        mirror([0, 0, 1])
            for(i=[-22.5, 45, 112.5]) rotate(i) cube(9);
    }
    difference() {
        rotate([0, 90, 0]) linear_extrude(80, center=true)
            hull() {
                translate([4, 36]) acir(8, 32);
                translate([0, -40]) square(8);
            }
        for(i=[-38, -20, 0, 20, 38]) translate([i, 40, 0])
            cube([4, 16, 20], center=true);
        for(i=[-43.25, 43.25]) translate([i, 36, -4])
            intersection() {
                sphere(d=16, $fn=32);
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

module hinge() {
        for(j=[-38, -20, 0, 20, 38]) translate([j, 0, 0])
            rotate([0, -90, 0]) linear_extrude(4, center=true)
                hull() for(i=[0, 4]) translate([i, 0])
                    acir(8, 32);
        for(i=[0, 1]) mirror([i, 0, 0])
            translate([43.25, 0, 4]) intersection() {
                sphere(d=16, $fn=32);
                translate([-11.25, 0, 0]) cube(8, center=true);
            }
}

module p4214() /*[4214]*/ sc() {
    for(i=[-30, 30]) translate([i, 0, -40])
        dcore([1, 1, 0], [false, false, false]);
    translate([-20, 6, -48]) cube([40, 4, 8]);
    translate([-20, 0, -42]) cube([40, 10, 2]);
    downext(4) difference() {
        square([80, 20], center=true);
        hull() for(i=[-30, 30], j=[-4, -10])
            translate([i, j]) acir(12, 32);
    }
    downext(48) for(i=[-38, 38])
        translate([i, 0]) square([4, 20], center=true);
    translate([0, 6, 0]) hinge();
}

module p4215() /*[4215]*/ sc() {
    dcore([4, 1, 1/6], [true, false, true]);
    translate([0, 0, -64])
        dcore([4, 1, 0], [false, true, false]);
    translate([-40, 6, -72]) cube([80, 4, 72]);
    translate([-40, -10, -4]) cube([80, 20, 4]);
}

module p4315() /*[4315]*/ sc() {
    dcore([4, 1, 0]);
    translate([0, -10, -4]) rotate([90, 0, 0]) hinge();
}

module p4600() /*[4600]*/ sc() {
    dcore([2, 2, 0]);
    xmirror() {
        downext(8) translate([13, 0])
            square([14, 4], center=true);
        translate([0, 0, -8]) linear_extrude(6)
            polygon([[20, -10], [22, -5], [22, 5], [20, 10]]);
        difference() {
            rotate([0, 90, 0]) translate([5, 0, 20]) {
                linear_extrude(2) acir(10, 32);
                linear_extrude(14) acir(8, 32);
                translate([0, 0, 13])
                    linear_extrude(1) acir(8.6, 32);
            }
            linear_extrude(20, center=true) hull()
                for(i=[26.6, 35]) translate([i, 0])
                    acir(1.3, 32);
        }
    }
}

module p4624() /*[4624]*/ sc() {
    difference() {
        rotate([-90, 0, 0]) rotate_extrude($fn=32) polygon([
            [0, 8], [10, 8], [10, 4], [8, 2],
            [8, -2], [10, -4], [10, -8], [0, -8]]);
        rotate([-90, 0, 0]) translate([0, 0, -2])
            linear_extrude(11) {
                intersection() {
                    acir(12, 32);
                    for(i=[0, 90]) rotate(i)
                        square([20, 3], center=true);
                }
                acir(8, 32);
            }
        rotate([90, 0, 0]) translate([0, 0, 2])
            cylinder(3, d=12, $fn=32);
        rotate([90, 0, 0]) translate([0, 0, 5]) difference() {
            cylinder(3, d1=12, d2=16.7, $fn=32);
            linear_extrude(3) {
                acir(8, 32);
                for(i=[0, 90]) rotate(i)
                    square([20, 3], center=true);
            }
        }
    }
}

module p6141() /*[6141]*/ sc() {
    fmirror() bstud();
    downext(3) acir(20, 32);
    downext(8) difference() {
            acir(20*sqrt(2)-12);
            acir(12);
        }
}

module not_there() {
    echo("WARNING: Unknown part number!");
    color("red") sc() for(i=[90:90:360]) rotate(i)
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
    if(part=="3041") p3041(); else //[AUTODEL]
    if(part=="3042") p3042(); else //[AUTODEL]
    if(part=="3043") p3043(); else //[AUTODEL]
    if(part=="3044") p3044(); else //[AUTODEL]
    if(part=="3045") p3045(); else //[AUTODEL]
    if(part=="3046") p3046(); else //[AUTODEL]
    if(part=="3048") p3048(); else //[AUTODEL]
    if(part=="3049") p3049(); else //[AUTODEL]
    if(part=="3058") p3058(); else //[AUTODEL]
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
