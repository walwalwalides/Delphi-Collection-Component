unit uCalendarBitmaps;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Imaging.pngimage;

(* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: EBITMAPS *)
type
  eBitmaps = (BmpCalendarBlue, BmpCalendarCyan, BmpCalendarGreen, BmpCalendarMagenta, BmpCalendarRed, BmpCalendarYellow);
  (* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: _EBITMAPS *)
  TCalendarColor = (CalBlue, CalCyan, CalGreen, CalMagenta, CalRed, CalYellow);

function getBitmap(e: eBitmaps): TBitmap;
function getRotKnob(value: integer): TPngImage;

implementation

{$R BMPresource.res}


VAR
  CalendarBitmapsBmp: array [eBitmaps] of TBitmap;

  (* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: OLEDBITMAPS *)
const
  OLEDBitmapNames: array [eBitmaps] of string = ('CalendarBlue', 'CalendarCyan', 'CalendarGreen', 'CalendarMagenta', 'CalendarRed', 'CalendarYellow');
  (* DON'T REMOVE THIS IT IS NEEDED BY RESOURCE CREATER RH: _OLEDBITMAPS *)

function getBitmap(e: eBitmaps): TBitmap;
begin
  if CalendarBitmapsBmp[e] <> NIL then
    result := CalendarBitmapsBmp[e]
  else
  begin
    CalendarBitmapsBmp[e] := TBitmap.Create;
    CalendarBitmapsBmp[e].LoadFromResourceName(HInstance, OLEDBitmapNames[e]);
    result := CalendarBitmapsBmp[e];
  end
end;

function ThreeStr(n: integer): string;
begin
  result := inttostr(n);
  if n < 10 then
    result := '00' + result
  else if n < 100 then
    result := '0' + result;
end;

VAR
  pngs: array [0 .. 100] of TPngImage;

function getRotKnob(value: integer): TPngImage;
begin
  if (value > 127) then
    value := 127;
  if (value < 0) then
    value := 0;
  value := round(100 * value / 127);
  if pngs[value] = NIL then
  begin
    pngs[value] := TPngImage.Create;
    pngs[value].LoadFromResourceName(HInstance, 'SP_ROT_' + ThreeStr(value));
  end;
  result := pngs[value];
end;

end.
