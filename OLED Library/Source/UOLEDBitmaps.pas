{ ============================================
  Software Name : 	OLED Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit UOLEDBitmaps;

interface

uses
  Winapi.Windows, System.SysUtils,  System.Classes, Vcl.Graphics, Vcl.Imaging.pngimage;

(* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: EBITMAPS *)
type  eBitmaps = (Bmpdunebutton,Bmpduneosc,BmpOLED7Led,BmpOLEDButton,BmpOLEDFoot4,BmpOLEDKnob,BmpOLEDKnob2,BmpOLEDVAFoot,BmpOLEDVAFOOT4,BmpOLEDVAKnob,BmpOLEDVALFO,
          BmpOLEDVALFO1,BmpOLEDVALFO2,BmpOLEDVALFOSEL,BmpOLEDVAWave,BmpOLEDVAWave4,BmpOLEDWave,BmpRolandHSlider,BmpRolandKnob,BmpRolandVSlider,BmpSliderHorBot,
          BmpSliderHorUpp,BmpSliderVerBot,BmpSliderVerUpp,BmpSunriseButFull,BmpSunriseButOff,BmpSunriseButOn,BmpSunriseKnob,BmpSunriseLedOff,BmpSunriseLedOn,
          BmpSunriseNoise,BmpSunriseSaw,BmpSunriseSin,BmpSunriseSlider,BmpSunriseSliderKnob,BmpSunriseSquare,BmpSunriseTri,BmpTRANBUTTON0,BmpTRANBUTTON1

);
(* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: _EBITMAPS *)

function getBitmap(e:eBitmaps):TBitmap;
function getRotKnob(value:integer):TPngImage;

implementation

VAR   OLEDBitmapsBmp : array [eBitmaps] of TBitmap;
(* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: OLEDBITMAPS *)
const OLEDBitmapNames : array[eBitmaps] of string =('DUNEBUTTON','DUNEOSC','OLED7LED','OLEDBUTTON','OLEDFOOT4','OLEDKNOB','OLEDKNOB2','OLEDVAFOOT','OLEDVAFOOT4',
          'OLEDVAKNOB','OLEDVALFO','OLEDVALFO1','OLEDVALFO2','OLEDVALFOSEL','OLEDVAWAVE','OLEDVAWAVE4','OLEDWAVE','ROLANDHSLIDER','ROLANDKNOB','ROLANDVSLIDER',
          'SLIDERHORBOT','SLIDERHORUPP','SLIDERVERBOT','SLIDERVERUPP','SUNRISEBUTFULL','SUNRISEBUTOFF','SUNRISEBUTON','SUNRISEKNOB','SUNRISELEDOFF',
          'SUNRISELEDON','SUNRISENOISE','SUNRISESAW','SUNRISESIN','SUNRISESLIDER','SUNRISESLIDERKNOB','SUNRISESQUARE','SUNRISETRI','TRANBUTTON0','TRANBUTTON1'
);
(* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: _OLEDBITMAPS *)


function getBitmap(e:eBitmaps):TBitmap;
begin
  if OLEDBitmapsBmp[e]<>NIL then result:=OLEDBitmapsBmp[e]
  else
  begin
     OLEDBitmapsBmp[e]:=TBitmap.Create;
     OLEDBitmapsBmp[e].LoadFromResourceName(HInstance, OLEDBitmapNames[e]);
     result:=OLEDBitmapsBmp[e];
  end
end;


function ThreeStr(n:integer):string;
begin
  result:=inttostr(n);
  if n<10 then result:='00'+result
  else if n<100 then result:='0'+result;
end;
VAR pngs:array[0..100] of TPngImage;
function getRotKnob(value:integer):TPngImage;
begin
  if (value>127) then value:=127;
  if (value<0) then value:=0;
  value:=round(100*value/127);
  if pngs[value]=NIL then
  begin
    pngs[value]:=TPngImage.Create;
    pngs[value].LoadFromResourceName(HInstance,'SP_ROT_'+ThreeStr(value));
  end;
  result:=pngs[value];
end;



end.
