use <soLDraw.scad>
use <LDraw/parts/3001.scad>
use <LDraw/parts/3002.scad>
use <LDraw/parts/3003.scad>
use <LDraw/parts/3004.scad>
use <LDraw/parts/3005.scad>
use <LDraw/parts/3020.scad>
use <LDraw/parts/3021.scad>
use <LDraw/parts/3023.scad>
use <LDraw/parts/3024.scad>
use <LDraw/parts/3031.scad>
use <LDraw/parts/3068b.scad>
use <LDraw/parts/3623.scad>
use <LDraw/parts/3641.scad>
use <LDraw/parts/3710.scad>
use <LDraw/parts/3788.scad>
use <LDraw/parts/3821.scad>
use <LDraw/parts/3822.scad>
use <LDraw/parts/3823.scad>
use <LDraw/parts/3828.scad>
use <LDraw/parts/3829a.scad>
use <LDraw/parts/3937.scad>
use <LDraw/parts/3938.scad>
use <LDraw/parts/4070.scad>
use <LDraw/parts/4079.scad>
use <LDraw/parts/4213.scad>
use <LDraw/parts/4214.scad>
use <LDraw/parts/4215.scad>
use <LDraw/parts/4315.scad>
use <LDraw/parts/4600.scad>
use <LDraw/parts/4624.scad>
use <LDraw/parts/6141.scad>

part = "3001"; // ["3001", "3002", "3003", "3004", "3005", "3020", "3021", "3023", "3024", "3031", "3068b", "3623", "3641", "3710", "3788", "3821", "3822", "3823", "3828", "3829a", "3937", "3938", "4070", "4079", "4213", "4214", "4215", "4315", "4600", "4624", "6141"]

// minimum angle for a fragment
$fa=1;
// minimum size of a fragment
$fs=0.2;

module ref(part)
    if(part=="3001") ldraw_lib__3001(); else
    if(part=="3002") ldraw_lib__3002(); else
    if(part=="3003") ldraw_lib__3003(); else
    if(part=="3004") ldraw_lib__3004(); else
    if(part=="3005") ldraw_lib__3005(); else
    if(part=="3020") ldraw_lib__3020(); else
    if(part=="3021") ldraw_lib__3021(); else
    if(part=="3023") ldraw_lib__3023(); else
    if(part=="3024") ldraw_lib__3024(); else
    if(part=="3031") ldraw_lib__3031(); else
    if(part=="3068b") ldraw_lib__3068b(); else
    if(part=="3623") ldraw_lib__3623(); else
    if(part=="3641") ldraw_lib__3641(); else
    if(part=="3710") ldraw_lib__3710(); else
    if(part=="3788") ldraw_lib__3788(); else
    if(part=="3821") ldraw_lib__3821(); else
    if(part=="3822") ldraw_lib__3822(); else
    if(part=="3823") ldraw_lib__3823(); else
    if(part=="3828") ldraw_lib__3828(); else
    if(part=="3829a") ldraw_lib__3829a(); else
    if(part=="3937") ldraw_lib__3937(); else
    if(part=="3938") ldraw_lib__3938(); else
    if(part=="4070") ldraw_lib__4070(); else
    if(part=="4079") ldraw_lib__4079(); else
    if(part=="4213") ldraw_lib__4213(); else
    if(part=="4214") ldraw_lib__4214(); else
    if(part=="4215") ldraw_lib__4215(); else
    if(part=="4315") ldraw_lib__4315(); else
    if(part=="4600") ldraw_lib__4600(); else
    if(part=="4624") ldraw_lib__4624(); else
    if(part=="6141") ldraw_lib__6141(); else
    ;

%ref(part);
soldraw(part);
