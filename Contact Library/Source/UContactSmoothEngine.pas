{ ============================================
  Software Name : 	TContactSmoothButton
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit UContactSmoothEngine;

interface

uses Windows, SysUtils, Classes, Controls, ImgList, Graphics;

type
 TSmoothColor = (clContact);

 TButtonState = (bsIdle, bsHover, bsPressed);
 TGlyphLayout = (glLeft, glRight);
 TCLR = array [Boolean, 0..3, 0..8] of TColor;  // Define Dimension of The Array Button

procedure DrawButton(Canvas: TCanvas; ARect: TRect; AFont: TFont; Enabled, Flat: Boolean; Images: TCustomImageList; ImageIndex: Integer; State: TButtonState; Caption: TCaption; Alignment: TAlignment; GlyphLayout: TGlyphLayout; Down: Boolean; Color: TSmoothColor);

const

 CLR: array [TSmoothColor] of TCLR = (
                                        { Define the Template }
 ((($000000FF, $00FFFFFF, $00FFFFFF, $00FFFFFF, $00FFFFFF, $00FFFFFF, $00FFFFFF, $00FFFFFF, $00FFFFFF),
   ($000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $00FFFFFF),
   ($000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $000000FF, $00FFFFFF),
   ($00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00FFFFFF)),
 (($0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $00FFFFFF),
   ($0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $00FFFFFF),
   ($0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $0000FF00, $00FFFFFF),
   ($00008000, $00008000, $00008000, $00008000, $00008000, $00008000, $00008000, $00008000, $00FFFFFF)))
 );

implementation

procedure Trunc(var R, G, B: Integer);
begin
//Set the limit of RGB Module
 if R > 255 then R := 255 else if R < 0 then R := 0;
 if G > 255 then G := 255 else if G < 0 then G := 0;
 if B > 255 then B := 255 else if B < 0 then B := 0;
end;

procedure Grayscale(var Bitmap: TBitmap);
Var
 P: PRGBQUAD;
 E: Pointer;
 M: Byte;
begin
 { when the Button is disabled}
 Bitmap.Pixelformat := pf32bit;
 P := Bitmap.ScanLine[Bitmap.Height - 1];
 E := Ptr(Longword(P) + Longword(Bitmap.Width * Bitmap.Height * 4));
 while P <> E do
  with P^ do
   begin

    M := (rgbRed + rgbGreen + rgbBlue) div 3;
    rgbRed := M;
    rgbGreen := M;
    rgbBlue := M;
    Inc(P);
   end;
end;

procedure GetGradientLine(var Bitmap: TBitmap; AStart, AEnd: TColor; Y1, Y2: Integer);
Var
 I: Integer;
 Delta: array [0..2] of Single;
 Value: array [0..2] of Single;
 R, G, B: Integer;
begin
 Bitmap.PixelFormat := pf32bit;
 Value[0] := GetRValue(AStart);
 Value[1] := GetGValue(AStart);
 Value[2] := GetBValue(AStart);
 Delta[0] := (GetRValue(AEnd) - Value[0]) / (Y2 - Y1);
 Delta[1] := (GetGValue(AEnd) - Value[1]) / (Y2 - Y1);
 Delta[2] := (GetBValue(AEnd) - Value[2]) / (Y2 - Y1);

 for I := Y1 to Y2 do
  begin
   R := Round(Value[0]);
   G := Round(Value[1]);
   B := Round(Value[2]);
   Trunc(R, G, B);
   Bitmap.Canvas.Pixels[0, I] := rgb(Round(R), Round(G), Round(B));

   Value[0] := Value[0] + Delta[0];
   Value[1] := Value[1] + Delta[1];
   Value[2] := Value[2] + Delta[2];
  end;
end;

procedure DrawButtonGradientLine(var Bitmap: TBitmap; ATop1, ATop2, ABottom1, ABottom2: TColor);
begin
 GetGradientLine(Bitmap, ATop1, ATop2, 0, Bitmap.Height div 2 - 1);
 GetGradientLine(Bitmap, ABottom1, ABottom2, Bitmap.Height div 2, Bitmap.Height - 1);
end;

procedure DrawGradient(var Bitmap: TBitmap; X, Width: Integer; ColorRef: Integer; CR2: Boolean; Color: TSmoothColor);
Var
 Bmp: TBitmap;
begin
 Bmp := TBitmap.Create;
 Bmp.Width := 1;
 Bmp.Height := Bitmap.Height - 3;

 DrawButtonGradientLine(Bmp, CLR[Color][CR2][ColorRef][5], CLR[Color][CR2][ColorRef][6], CLR[Color][CR2][ColorRef][7], CLR[Color][CR2][ColorRef][8]);

 StretchBlt(Bitmap.Canvas.Handle, X, 2, Width - 2, Bitmap.Height - 2, Bmp.Canvas.Handle, 0, 0, 1, Bmp.Height, SRCCOPY);
 Bmp.Free;
 if Width <> Bitmap.Width - 4 then
  begin
   Bitmap.Canvas.Pen.Color := CLR[Color][CR2][ColorRef][0];
   Bitmap.Canvas.MoveTo(Width, 2);
   Bitmap.Canvas.LineTo(Width, Bitmap.Height - 2);
  end;
end;

procedure DrawBorders(Bitmap: TBitmap; ColorRef: Integer; Down: Boolean; Color: TSmoothColor);
Var
 Value, Delta: array [0..2] of Single;
 Bmp: TBitmap;
 Tmp: TColor;
begin
 with Bitmap do
  begin

   Canvas.Pen.Color := CLR[Color][Down][ColorRef][0];
   Canvas.MoveTo(3, 0);
   Canvas.LineTo(Width - 3, 0);
   Canvas.MoveTo(3, Height - 1);
   Canvas.LineTo(Width - 3, Height - 1);

   Value[0] := GetRValue(CLR[Color][Down][ColorRef][0]);
   Value[1] := GetGValue(CLR[Color][Down][ColorRef][0]);
   Value[2] := GetBValue(CLR[Color][Down][ColorRef][0]);
   Delta[0] := (255 - Value[0]) / 3;
   Delta[1] := (255 - Value[1]) / 3;
   Delta[2] := (255 - Value[2]) / 3;
   Tmp := rgb(Round(Value[0]), Round(Value[1]), Round(Value[2]));
   Canvas.Pixels[2, 0] := Tmp;
   Canvas.Pixels[Width - 3, 0] := Tmp;
   Canvas.Pixels[2, Height - 1] := Tmp;
   Canvas.Pixels[Width - 3, Height - 1] := Tmp;
   Value[0] := Value[0] + Delta[0];
   Value[1] := Value[1] + Delta[1];
   Value[2] := Value[2] + Delta[2];
   Tmp := rgb(Round(Value[0]), Round(Value[1]), Round(Value[2]));
   Canvas.Pixels[1, 0] := Tmp;
   Canvas.Pixels[1, Height - 1] := Tmp;
   Canvas.Pixels[Width - 2, 0] := Tmp;
   Canvas.Pixels[Width - 2, Height - 1] := Tmp;

   Canvas.Pixels[0, 1] := Canvas.Pixels[1, 0];
   Canvas.Pixels[0, Height - 2] := Canvas.Pixels[1, Height - 1];
   Canvas.Pixels[1, 1] := Canvas.Pixels[2, 0];
   Canvas.Pixels[1, Height - 2] := Canvas.Pixels[2, Height - 1];
   Canvas.Pixels[Width - 1, 1] := Canvas.Pixels[Width - 2, 0];
   Canvas.Pixels[Width - 1, Height - 2] := Canvas.Pixels[Width - 2, Height - 1];
   Canvas.Pixels[Width - 2, 1] := Canvas.Pixels[Width - 3, 0];
   Canvas.Pixels[Width - 2, Height - 2] := Canvas.Pixels[Width - 3, Height - 1];

   Canvas.Pen.Color := CLR[Color][Down][ColorRef][0];
   Canvas.MoveTo(0, 2);
   Canvas.LineTo(0, Height - 2);
   Canvas.MoveTo(Width - 1, 2);
   Canvas.LineTo(Width - 1, Height - 2);

   Canvas.Pen.Color := CLR[Color][Down][ColorRef][1];
   Canvas.MoveTo(2, 1);
   Canvas.LineTo(Width - 2, 1);

   Canvas.Pen.Color := CLR[Color][Down][ColorRef][8];
   Canvas.MoveTo(2, Height - 2);
   Canvas.LineTo(Width - 2, Height - 2);


   Bmp := TBitmap.Create;
   Bmp.Width := 1;
   Bmp.Height := Bitmap.Height - 4;
   DrawButtonGradientLine(Bmp, CLR[Color][Down][ColorRef][1], CLR[Color][Down][ColorRef][2], CLR[Color][Down][ColorRef][3], CLR[Color][Down][ColorRef][4]);
   Canvas.Draw(1, 2, Bmp);
   Canvas.Draw(Width - 2, 2, Bmp);

   Bmp.Free;

   Canvas.Pixels[Width - 1, Height - 1] := clWhite;


  end;
end;

procedure DrawButton(Canvas: TCanvas; ARect: TRect; AFont: TFont; Enabled, Flat: Boolean; Images: TCustomImageList; ImageIndex: Integer; State: TButtonState; Caption: TCaption; Alignment: TAlignment; GlyphLayout: TGlyphLayout; Down: Boolean; Color: TSmoothColor);
Var
 IsGlyph: Boolean;
 Bmp: TBitmap;
 R: TRect;
 W, H: Integer;
 ColorRef: Integer;
 X, Y: Integer;
begin
 W := ARect.BottomRight.X - ARect.TopLeft.X;
 H := ARect.BottomRight.Y - ARect.TopLeft.Y;

 Bmp := TBitmap.Create;
 Bmp.Width := W;
 Bmp.Height := H;
 Bmp.PixelFormat := pf32bit;

 if not Enabled then ColorRef := 0 else
  case State of
   bsIdle: ColorRef := 1;
   bsHover: ColorRef := 2;
   bsPressed: ColorRef := 3;
   else ColorRef := 0;
  end;

 if not Flat then DrawGradient(Bmp, 2, Bmp.Width, ColorRef, Down, Color)
  else if Down then DrawGradient(Bmp, 2, Bmp.Width, ColorRef, Down, Color) else
   if State <> bsIdle then DrawGradient(Bmp, 2, Bmp.Width, ColorRef, Down, Color);

 if not Flat then DrawBorders(Bmp, ColorRef, Down, Color)
  else if Down then DrawBorders(Bmp, ColorRef, Down, Color) else
   if State <> bsIdle then DrawBorders(Bmp, ColorRef, Down, Color);

 Bmp.Canvas.Pixels[0, 0] := clWhite;
 Bmp.Canvas.Pixels[W - 1, 0] := clWhite;
 Bmp.Canvas.Pixels[0, H - 1] := clWhite;
 Bmp.Canvas.Pixels[W - 1, H - 1] := clWhite;
 Bmp.Transparent := True;

 if not Flat then Canvas.Draw(ARect.TopLeft.X, ARect.TopLeft.Y, Bmp)
  else if Down then Canvas.Draw(ARect.TopLeft.X, ARect.TopLeft.Y, Bmp)
   else if State <> bsIdle then Canvas.Draw(ARect.TopLeft.X, ARect.TopLeft.Y, Bmp);

 if (Assigned(Images)) and (Images.Count > ImageIndex) and (ImageIndex <> -1) then
  begin
   Bmp.Width := 0;
   Bmp.Height := 0;
   Images.GetBitmap(ImageIndex, Bmp);
   Bmp.PixelFormat := pf32bit;
   if not Enabled then Grayscale(Bmp);
   Bmp.TransparentColor := Bmp.Canvas.Pixels[0, Bmp.Height - 1];
   Bmp.Transparent := True;

   Y := (H div 2) - (Bmp.Height div 2);
   if Down then Inc(Y);
   if GlyphLayout = glLeft then X := 4 else X := W - 4 - Images.Width;
   if Down then Inc(X);

   Canvas.Draw(X, Y, Bmp);
   IsGlyph := True;
  end else IsGlyph := False;
 Bmp.Free;
 if Trim(Caption) <> '' then
  begin
   Canvas.Brush.Style := bsClear;
   Canvas.Font.Assign(AFont);
   if not Enabled then Canvas.Font.Color := clGrayText;
   if not IsGlyph then R := Rect(Point(ARect.TopLeft.X + 4, ARect.TopLeft.Y + 4), Point(ARect.BottomRight.X - 4, ARect.BottomRight.Y - 4)) else
    case GlyphLayout of
     glLeft: R := Rect(Point(ARect.TopLeft.X + 4 + Images.Width + 4, ARect.TopLeft.Y + 4), Point(ARect.BottomRight.X - 4, ARect.BottomRight.Y - 4));
     glRight: R := Rect(Point(ARect.TopLeft.X + 4, ARect.TopLeft.Y + 4), Point(ARect.BottomRight.X - 8 - Images.Width, ARect.BottomRight.Y - 4));
    end;

   case Alignment of
    taLeftJustify: DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_END_ELLIPSIS or DT_SINGLELINE or DT_VCENTER or DT_LEFT);
    taRightJustify: DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_END_ELLIPSIS or DT_SINGLELINE or DT_VCENTER or DT_RIGHT);
    taCenter: DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_END_ELLIPSIS or DT_SINGLELINE or DT_VCENTER or DT_CENTER);
   end;
   Canvas.Brush.Style := bsSolid;
  end;
end;

end.
