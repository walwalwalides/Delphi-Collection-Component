{ ============================================
  Software Name : 	Rating Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit FMX.shHeart.Rating;

interface

uses
{$IFDEF UseNativeDraw} FMX.Graphics.Native, {$ENDIF}System.SysUtils, System.Classes, System.Types, System.UITypes, System.Math, System.Math.Vectors,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Objects,FMX.StdCtrls;

type
//  TLabelRating=class(FMX.StdCtrls.TLabel)
//  end;
  TOnRatingChange = procedure(Sender: TObject; AValue: Double) of object;

  TRatingshHeartColors = class(TPersistent)
  private
    FBackground: TBrush;
    FStroke: TStrokeBrush;
    FStarColor: TBrush;
    FOnChanged: TNotifyEvent;
    procedure SetBackground(const Value: TBrush);
    procedure SetStroke(const Value: TStrokeBrush);
    procedure SetStarColor(const Value: TBrush);
    procedure SetOnChanged(const Value: TNotifyEvent);
    { private declarations }
  protected
    { protected declarations }
    procedure DoChanged(Sender: TObject);
  public
    { public declarations }
    constructor Create; virtual;
    destructor Destroy; override;
  published
    { published declarations }
    property Background: TBrush read FBackground write SetBackground;
    property Stroke: TStrokeBrush read FStroke write SetStroke;
    property StarColor: TBrush read FStarColor write SetStarColor;
    property OnChanged: TNotifyEvent read FOnChanged write SetOnChanged;
  end;





  TRatingshHeart = class(TControl)
  private
       FLabelRating:TLabel;
    FStarCount: Integer;
    FStarDistance: Double;
    FStarScale: Double;
    FMouseCapturing: Boolean;
    FSteps: Double;
    FOnRatingChange: TOnRatingChange;
    FColors: TRatingshHeartColors;
    FRating: Double;
    FStarsPathData: TPathData;
    procedure SetStarCount(const Value: Integer);
    procedure SetStarDistance(const Value: Double);
    procedure SetStarScale(const Value: Double);
    procedure SetSteps(const Value: Double);
    procedure SetOnRatingChange(const Value: TOnRatingChange);
    procedure SetColors(const Value: TRatingshHeartColors);
    procedure SeTRatingshHeart(const Value: Double);
    { Private declarations }
  protected
    { Protected declarations }
    procedure ColorsChanged(Sender: TObject);
    procedure CreateStars;
    procedure Paint; override;
    function CalcWidth: Double;
    function CalcHeight: Double;
    procedure CalcRatingFromMouse(X: Single);
    procedure DoStarChanged;
    procedure DoRatingChanged;
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  public

    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Locked;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property TabOrder;
    property TabStop;
    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    // property OnResized;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property StarCount: Integer read FStarCount write SetStarCount stored True nodefault;
    property StarDistance: Double read FStarDistance write SetStarDistance stored True nodefault;
    property StarScale: Double read FStarScale write SetStarScale stored True nodefault;
    property Steps: Double read FSteps write SetSteps stored True nodefault;
    property Rating: Double read FRating write SeTRatingshHeart stored True nodefault;
    property OnRatingChange: TOnRatingChange read FOnRatingChange write SetOnRatingChange;
    property Colors: TRatingshHeartColors read FColors write SetColors;
  end;

const

  StarData = 'M252.524002075195,467.861999511719 C175.762298583984,361.330017089844' +
    ' -2.20199584960938,316.382995605469 0.464996337890625,153.546997070313 C1.44880735874176,93.4398956298828' +
    ' 51.1929969787598,28.6059951782227 133.918991088867,33.0599975585938 C193.037384033203,36.2437286376953' +
    ' 222.919799804688,59.9739990234375 252.524993896484,113.663993835449 C282.130096435547,59.9739952087402 ' +
    '312.012603759766,36.2436904907227 371.130981445313,33.0599975585938 C453.856872558594,28.6051864624023 ' +
    '503.600982666016,93.4394989013672 504.5849609375,153.546997070313 C507.251251220703,316.382995605469 ' +
    '329.286956787109,361.330017089844 252.524963378906,467.861999511719 Z M255.892868041992,450.052001953125 ' +
    'C272.247772216797,393.091003417969 339.173461914063,345.390014648438 387.950866699219,292.242980957031 ' +
    'C428.239562988281,248.345672607422 472.841278076172,190.139984130859 472.853668212891,98.5399780273438 ' +
    'C484.95166015625,117.730278015137 491.540374755859,139.618179321289 491.895080566406,160.915878295898 ' +
    'C498.296936035156,241.687683105469 430.021087646484,302.423889160156 360.869079589844,356.766876220703 ' +
    'C326.847076416016,383.503570556641 301.744384765625,397.510986328125 270.863891601563,431.232574462891 ' +
    'C264.385437011719,438.306854248047 259.165283203125,444.226379394531 255.892486572266,450.051574707031 Z ';

implementation

uses
  FMX.Dialogs;

{ TRatingshHeart }

function TRatingshHeart.CalcHeight: Double;
begin
  Result := (32 * FStarScale);
end;

procedure TRatingshHeart.CalcRatingFromMouse(X: Single);

var
  StarWidth: Double;
  StarTrunc: Integer;
  DistanceCount: Double;
  TempRating: Double;
  PosX: Single;
  mRect: TRectF;
begin
  StarWidth := (32 * FStarScale);
  PosX := X;
  if FColors.Stroke.Kind <> TBrushKind.None then
    PosX := PosX - (Self.Colors.Stroke.Thickness / 2 * FStarScale);

  StarTrunc := Trunc(PosX * 1 / (StarWidth + FStarDistance * FStarScale));

  DistanceCount := PosX - StarTrunc * StarWidth - StarTrunc * FStarDistance * FStarScale;

  if Trunc(StarTrunc + (DistanceCount / StarWidth)) - StarTrunc > 0 then
    TempRating := Trunc(StarTrunc + (DistanceCount / StarWidth))
  else
    TempRating := StarTrunc + (DistanceCount / StarWidth);

  Rating := TempRating;

  Repaint;

end;

function TRatingshHeart.CalcWidth: Double;
begin
  Result := (32 * FStarScale * StarCount) + (StarDistance * FStarScale * (StarCount - 1));
end;

procedure TRatingshHeart.ColorsChanged(Sender: TObject);
begin
  DoStarChanged;
  Repaint;
end;

constructor TRatingshHeart.Create(AOwner: TComponent);
var
  mRect: TRectF;
begin
  inherited;
  AutoCapture := True;
  Cursor := crHandPoint;
  FMouseCapturing := False;
  FStarScale := 1;
  FStarDistance := 5;
  FStarCount := 5;
  FRating := 5;
  FSteps := 0.01;
  FColors := TRatingshHeartColors.Create;

//---------------------------------------------------------//
  FLabelRating:=TLabel.Create(Owner);
//  FLabelRating.Align:=TAlignLayout.Client;
  FLabelRating.Parent:=Self;
  FLabelRating.Width:=30;
  FLabelRating.Position.X:=5;
  FLabelRating.Position.Y:=0;
  FLabelRating.Font.Size:=15;
  FLabelRating.Font.Style:=[TFontStyle.fsBold];
  FLabelRating.Text:=FRating.ToString;
  FLabelRating.Visible:=False;

//---------------------------------------------------------//
  FColors.OnChanged := ColorsChanged;
  FStarsPathData := TPathData.Create;
  DoStarChanged;
  CreateStars;


end;

procedure TRatingshHeart.CreateStars;

var
  StarPathData: TPathData;
  I: Integer;
  CurrDistance: Double;
begin
  CurrDistance := (32 * FStarScale) + (StarDistance * FStarScale);

  StarPathData := TPathData.Create;
  StarPathData.Data := StarData;
  StarPathData.FitToRect(TRectF.Create(0, 0, 32 * FStarScale, 32 * FStarScale));

  FStarsPathData.Clear;
  try
    for I := 0 to StarCount - 1 do
    begin
      FStarsPathData.Data := FStarsPathData.Data + StarPathData.Data;
      StarPathData.Translate(CurrDistance, 0);
    end;
  finally
    StarPathData.Free;
  end;
end;

destructor TRatingshHeart.Destroy;
begin
  FColors.Free;
  FStarsPathData.Free;
  inherited;
end;

procedure TRatingshHeart.DoRatingChanged;
begin
  if Assigned(FOnRatingChange) then
    FOnRatingChange(Self, FRating);
end;

procedure TRatingshHeart.DoStarChanged;

var
  TempWidth, TempHeight: Single;
begin
  TempWidth := CalcWidth;
  TempHeight := CalcHeight;
  if FColors.Stroke.Kind <> TBrushKind.None then
  begin
    TempWidth := TempWidth + FColors.Stroke.Thickness * FStarScale;
    TempHeight := TempHeight + FColors.Stroke.Thickness * FStarScale;
  end;
  Self.Width := TempWidth;
  Self.Height := TempHeight;
end;


procedure TRatingshHeart.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  mRect: TRectF;
begin
  inherited;
  FMouseCapturing := True;
   FLabelRating.Visible:=True;
end;


procedure TRatingshHeart.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if not FMouseCapturing then
    exit;

  CalcRatingFromMouse(X);

end;

procedure TRatingshHeart.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);

var
  StarWidth: Double;
  StarTrunc: Integer;
  DistanceCount: Double;
  TempRating: Double;
begin
  inherited;
  FMouseCapturing := False;
  CalcRatingFromMouse(X);
  FLabelRating.Visible:=False;
end;

procedure TRatingshHeart.Paint;

var
  I: Integer;
  TempPathData: TPathData;
  TotalFill: Double;
  Save: TCanvasSaveState;
begin
  inherited;

  if (csDesigning in ComponentState) and not Locked then
    DrawDesignBorder;
  try

    if FRating > 0 then
      TotalFill := (32 * FStarScale) * (FRating) + (Ceil(FRating) - 1) * (FStarDistance * FStarScale)
    else
      TotalFill := 0;

    if FColors.Stroke.Kind <> TBrushKind.None then
      TotalFill := TotalFill + FColors.Stroke.Thickness / 2 * FStarScale;

    TempPathData := TPathData.Create;
    try
      TempPathData.Data := FStarsPathData.Data;
{$IFDEF UseNativeDraw}Canvas.NativeDraw(TRectF.Create(0, 0, Self.Width, Self.Height),
        procedure
        begin {$ENDIF}
          if FColors.Stroke.Kind <> TBrushKind.None then

            TempPathData.Translate(FColors.Stroke.Thickness / 2 * FStarScale, FColors.Stroke.Thickness / 2 * FStarScale);

          Canvas.BeginScene;
          Canvas.Fill.Assign(FColors.Background);
          Canvas.Stroke.Assign(FColors.Stroke);
          Canvas.Stroke.Thickness := FColors.Stroke.Thickness * FStarScale;
          if not GlobalUseGPUCanvas then
            Canvas.DrawPath(TempPathData, Opacity);
          Canvas.FillPath(TempPathData, Opacity);
          Canvas.EndScene;

          Save := Canvas.SaveState;
          Canvas.IntersectClipRect(TRectF.Create(0, 0, TotalFill, Height));
          Canvas.Fill.Assign(FColors.StarColor);
          Canvas.FillPath(TempPathData, Opacity);
          Canvas.RestoreState(Save);
{$IFDEF UseNativeDraw} end); {$ENDIF}
    finally
      TempPathData.Free
    end;

  finally

  end;

end;

procedure TRatingshHeart.Resize;
begin
  inherited;
  DoStarChanged;
end;

procedure TRatingshHeart.SetColors(const Value: TRatingshHeartColors);
begin
  FColors := Value;
end;

procedure TRatingshHeart.SetOnRatingChange(const Value: TOnRatingChange);
begin
  FOnRatingChange := Value;
end;

procedure TRatingshHeart.SeTRatingshHeart(const Value: Double);

var
  NewValue: Double;
  OldValue: Double;
  imgstory: Timage;
  mRect: TRectF;

begin
  OldValue := FRating;

  if ((Frac(Value) - (Trunc(Frac(Value) / FSteps) * FSteps)) > FSteps / 3) then
    NewValue := Trunc(Value) + Trunc(Frac(Value) / FSteps) * FSteps + FSteps
  else
    NewValue := Trunc(Value) + Trunc(Frac(Value) / FSteps) * FSteps;

  NewValue := RoundTo(NewValue, -2);

  if NewValue <= 0 then
    FRating := 0
  else if NewValue > FStarCount then
    FRating := FStarCount
  else
    FRating := NewValue;

   FLabelRating.Text:=FRating.ToString;
    {
    with Canvas do
  begin

    BeginScene;;
    Fill.Color := TAlphaColors.Red;
    Font.Size := 15;
    mRect.Create(self.Left,self.top+15, 200, 270);
    FillText(mRect, FRating.ToString, false, 100, [], TTextAlign.taLeading, TTextAlign.taCenter);
    EndScene;

  end;
 }


  Repaint;

  if NewValue <> OldValue then
    DoRatingChanged;
end;

procedure TRatingshHeart.SetStarCount(const Value: Integer);
begin
  FStarCount := Value;
  CreateStars;
  SeTRatingshHeart(FRating);
  DoStarChanged;
end;

procedure TRatingshHeart.SetStarDistance(const Value: Double);
begin
  FStarDistance := Value;
  CreateStars;
  DoStarChanged;
end;

procedure TRatingshHeart.SetStarScale(const Value: Double);
begin
  FStarScale := Value;
  CreateStars;
  DoStarChanged;
end;

procedure TRatingshHeart.SetSteps(const Value: Double);
begin
  if Value > 1 then
    FSteps := 1
  else if Value <= 0 then
    FSteps := 0.01
  else
    FSteps := Value;
end;

{ TRatingshHeartColors }

constructor TRatingshHeartColors.Create;
begin
  FBackground := TBrush.Create(TBrushKind.Solid, $FFEEEEEE);
  FStarColor := TBrush.Create(TBrushKind.Solid, TAlphaColorRec.Red);
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, $FF858585);

  FStroke.OnChanged := DoChanged;
  FStarColor.OnChanged := DoChanged;
  FBackground.OnChanged := DoChanged;

end;

destructor TRatingshHeartColors.Destroy;
begin
  FBackground.Free;
  FStarColor.Free;
  FStroke.Free;
  inherited;
end;

procedure TRatingshHeartColors.DoChanged(Sender: TObject);
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TRatingshHeartColors.SetBackground(const Value: TBrush);
begin
  FBackground := Value;
end;

procedure TRatingshHeartColors.SetOnChanged(const Value: TNotifyEvent);
begin
  FOnChanged := Value;
end;

procedure TRatingshHeartColors.SetStarColor(const Value: TBrush);
begin
  FStarColor := Value;
end;

procedure TRatingshHeartColors.SetStroke(const Value: TStrokeBrush);
begin
  FStroke := Value;
end;

{ TLabelRating }


end.
