unit uCalendarPicture;

interface

Uses
  Forms,
  Graphics,
  System.Classes,
  Vcl.Extctrls,
  Vcl.Imaging.pngimage,
  uCalendarBitmaps,
  uCalendarText;

type
  TVCLBitmap = Vcl.Graphics.TBitmap;

  TCalendarpicture = class(TPaintBox)
  Private
    FCalColor :TCalendarColor;
    FCalLanguage :TCalendarLanguage;
    Width, Height, TextWidth, TextHeight, CenterHorizontal, CenterVerical: Integer;
    Calendar: TCalendar;
    Procedure InitImgAndFont(TBM: TPicture; S: String; Position: String);
    Procedure FixedParams(TFP: TPicture);
    Procedure TextFormat(TBitmap: TPicture; TFontName: STring; TFontSize: Integer; Value: String);
    function GetCalColor: TCalendarColor;
    procedure SetCalColor(const Value: TCalendarColor);
    function GetCalLanguage: TCalendarLanguage;
    procedure SetCalLanguage(const Value: TCalendarLanguage);
  Public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
//    constructor ;
  published
    property CalColor: TCalendarColor read GetCalColor write SetCalColor;
    property CalLanguage: TCalendarLanguage read GetCalLanguage write SetCalLanguage default CalEnglish;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Contact Library', [TCalendarpicture]);
end;

constructor TCalendarpicture.Create(AOwner: TComponent);
begin
  inherited ;

//self.Width:=500;
// self.Height:=500;
end;

Procedure TCalendarpicture.FixedParams(TFP: TPicture);
Begin
  With TFP.Bitmap Do
  Begin
    Transparent := True;
  End;
  With TFP.Bitmap.Canvas Do
  Begin
    Brush.Style := bsClear;
    Pen.Style := psClear;
  End;
End;

Procedure TCalendarpicture.TextFormat(TBitmap: TPicture; TFontName: String; TFontSize: Integer; Value: String);
Begin

  TBitmap.Bitmap.Canvas.Font.Name := TFontName;
  TBitmap.Bitmap.Canvas.Font.Size := TFontSize;
  TextWidth := TBitmap.Bitmap.Canvas.TextWidth(Value);
  TextHeight := TBitmap.Bitmap.Canvas.TextHeight(Value);

End;

function TCalendarpicture.GetCalColor: TCalendarColor;
begin
  result :=FCalColor;
end;

function TCalendarpicture.GetCalLanguage: TCalendarLanguage;
begin
  result :=FCalLanguage;
end;

Procedure TCalendarpicture.InitImgAndFont(TBM: TPicture; S: String; Position: String);
Begin
  Width := TBM.Width;
  Height := TBM.Height;

  IF (Position = 'top') Then
  Begin
    TextFormat(TBM, 'Arial Unicode MS', 12, S);
    CenterHorizontal := (Width Div 2) - (TextWidth Div 2);
    CenterVerical := 16;
    TBM.Bitmap.Canvas.TextOut(CenterHorizontal, CenterVerical, S);
  End;

  IF (Position = 'center') Then
  Begin
    TextFormat(TBM, 'Terminal', 42, S);
    CenterHorizontal := (Width Div 2) - (TextWidth Div 2);
    CenterVerical := (Height Div 2) - (TextHeight Div 2);
    TBM.Bitmap.Canvas.TextOut(CenterHorizontal, CenterVerical, S);
  End;

  IF (Position = 'bottom') Then
  Begin
    TextFormat(TBM, 'Arial Unicode MS', 11, S);
    CenterHorizontal := (Width Div 2) - (TextWidth Div 2);
    CenterVerical := 105;
    TBM.Bitmap.Canvas.TextOut(CenterHorizontal, CenterVerical, S);
  End;

End;

procedure TCalendarpicture.Paint;
VAR
  bdefault: TVCLBitmap;
  Img: TPicture;
begin
  bdefault := NIL;
  case CalColor of
    CalBlue:
      bdefault := getBitmap(BmpCalendarBlue);
    CalCyan:
      bdefault := getBitmap(BmpCalendarCyan);
    CalGreen:
      bdefault := getBitmap(BmpCalendarGreen);
    CalMagenta:
      bdefault := getBitmap(BmpCalendarMagenta);
    CalRed:
      bdefault := getBitmap(BmpCalendarRed);
    CalYellow:
      bdefault := getBitmap(BmpCalendarYellow);

  end;
  if (bdefault <> NIL) then
  begin
    try
      Img := TPicture.Create;
      Calendar := TCalendar.Create(CalLanguage);
      Img.Assign(bdefault);
      FixedParams(Img);
      InitImgAndFont(Img, Calendar.GetDayString, 'top');
      InitImgAndFont(Img, Calendar.GetDay, 'center');
      InitImgAndFont(Img, Calendar.GetMonthYearString, 'bottom');
      Self.Canvas.Draw(20, 10, Img.Graphic);
    finally
      Img.Free;
      Calendar.Free;
    end;
  end;

end;



procedure TCalendarpicture.SetCalColor(const Value: TCalendarColor);
begin
  FCalColor := Value;
  Invalidate;
end;

procedure TCalendarpicture.SetCalLanguage(const Value: TCalendarLanguage);
begin
   FCalLanguage := Value;
  Invalidate;
end;

end.
