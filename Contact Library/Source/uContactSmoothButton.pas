{ ============================================
  Software Name : 	TContactSmoothButton
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit uContactSmoothButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Dialogs, ImgList, Forms, StdCtrls, ExtCtrls, uContactSmoothEngine;

type
  TCustomSmoothButton = class(TCustomControl)
  private
    { Déclarations privées }
    FDefWndProc: TWndMethod;
    FUpdating: Boolean;
    FCancel: Boolean;
    FDefault: Boolean;
    FCaption: TCaption;
    FColor: TSmoothColor;
    FState: TButtonState;
    FImages: TCustomImageList;
    FImageIndex: Integer;
    FAlignment: TAlignment;
    FGlyphLayout: TGlyphLayout;
    FFlat: Boolean;
    FDown: Boolean;
    FAllowDown: Boolean;
    FEnterPress: Boolean;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    procedure SetCancel(Value: Boolean);
    procedure SetDefault(Value: Boolean);
    procedure SetCaption(Value: TCaption);
    procedure SetColor(Value: TSmoothColor);
    procedure SetImages(Value: TCustomImageList);
    procedure SetImageIndex(Value: Integer);
    procedure SetAlignment(Value: TAlignment);
    procedure SetGlyphLayout(Value: TGlyphLayout);
    procedure SetFlat(Value: Boolean);
    procedure SetDown(Index: Integer; Value: Boolean);
    procedure SetState(Value: TButtonState);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure LeftDown;
    procedure LeftUp;
  protected
    { Déclarations protégées }
    function MouseInControl: Boolean;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure DerivedWndProc(var Message: TMessage);
    property Cancel: Boolean read FCancel write SetCancel;
    property Default: Boolean read FDefault write SetDefault;
    property Caption: TCaption read FCaption write SetCaption;
    property Color: TSmoothColor read FColor write SetColor;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property GlyphLayout: TGlyphLayout read FGlyphLayout write SetGlyphLayout;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property Flat: Boolean read FFlat write SetFlat;
    property Down: Boolean index 1 read FDown write SetDown;
    property AllowDown: Boolean index 2 read FAllowDown write SetDown;
    property State: TButtonState read FState write SetState;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    procedure BeginUpdate;
    procedure EndUpdate;
  published
    { Déclarations publiées }
  end;

  TContactSmoothButton = class(TCustomSmoothButton)
  published
    property Default;
    property Cancel;
    property Caption;
    property Color;
    property Images;
    property ImageIndex;
    property Alignment;
    property GlyphLayout;
    property OnMouseEnter;
    property OnMouseLeave;
    property Flat;
    property Down;
    property AllowDown;
    property State;
    property Font;
    property PopupMenu;
    property OnClick;
    property OnDblClick;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseDown;
    property ShowHint;
    property ParentShowHint;
    property ParentFont;
    property ParentColor;
    property Visible;
    property Enabled;
    property TabOrder;
    property TabStop;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Contact Library', [TContactSmoothButton]);
end;

function LeftButtonPressed: Boolean;
begin
  Result := (HiWord(GetAsyncKeyState(VK_LBUTTON)) <> 0);
end;

function TCustomSmoothButton.MouseInControl: Boolean;
Var
  P: TPoint;
  R: TRect;
begin
  GetCursorPos(P);
  R.TopLeft := ClientToScreen(Point(0, 0));
  R.BottomRight.X := R.TopLeft.X + Width;
  R.BottomRight.Y := R.TopLeft.Y + Height;
  Result := PtInRect(R, P);
end;

procedure TCustomSmoothButton.CMMouseEnter(var Message: TMessage);
begin
  if LeftButtonPressed then
    FState := bsPressed
  else
    FState := bsHover;
  if LeftButtonPressed then
    FDown := not FDown;
  Invalidate;
  MouseEnter;
end;

procedure TCustomSmoothButton.CMMouseLeave(var Message: TMessage);
begin
  FState := bsIdle;
  if HiWord(GetAsyncKeyState(VK_LBUTTON)) <> 0 then
    FDown := False;
  Invalidate;
  MouseLeave;
end;

procedure TCustomSmoothButton.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomSmoothButton.MouseLeave;
begin
  if Assigned(FOnMouseLeave) then
  begin
    FOnMouseLeave(Self);
  end;

end;

procedure TCustomSmoothButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not(csDesigning in ComponentState) and CanFocus then
    SetFocus;
  if Button = mbLeft then
    LeftDown;
  inherited;
end;

procedure TCustomSmoothButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    LeftUp;
  inherited;
end;

procedure TCustomSmoothButton.LeftDown;
begin
  if FAllowDown then
    FDown := not FDown
  else
    FDown := True;
  if FDown then
    FState := bsPressed
  else
    FState := bsHover;
  Invalidate;
end;

procedure TCustomSmoothButton.LeftUp;
begin
  if MouseInControl then
    FState := bsHover
  else
    FState := bsIdle;
  if not FAllowDown then
    FDown := False;
  Invalidate;
end;

procedure TCustomSmoothButton.DblClick;
begin
  LeftDown;
  inherited;
end;

procedure TCustomSmoothButton.WndProc(var Message: TMessage);
begin
  { Draw immediately when the control if the property changed }
  if Message.Msg = CM_ENABLEDCHANGED then
    Invalidate;

  if Message.Msg = WM_SIZE then
    with TWMSize(Message) do
      if Height < 5 then
        Self.Height := 5;
  if Message.Msg = WM_KILLFOCUS then
  begin
    if not MouseInControl then
      FState := bsIdle;
    Invalidate;
  end;
  if Message.Msg = WM_KEYDOWN then
    if (TWMKeyDown(Message).CharCode = 13) and (not FEnterPress) then
    begin
      FEnterPress := True;
      LeftDown;
    end;
  if Message.Msg = WM_KEYUP then
    if (TWMKeyUp(Message).CharCode = 13) and (FEnterPress) then
    begin
      FEnterPress := False;
      LeftUp;
      if Assigned(OnClick) then
        OnClick(Self);
    end;

  inherited WndProc(Message);
end;

procedure TCustomSmoothButton.DerivedWndProc(var Message: TMessage);
begin
  if (FCancel) and (Assigned(OnClick)) then
    if Message.Msg = WM_KEYUP then
      with TWMKeyUp(Message) do
        if CharCode = 27 then
          OnClick(Self);

  FDefWndProc(Message);
end;

constructor TCustomSmoothButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DoubleBuffered := True;
  FState := bsIdle;
  FColor := clContact; // Define Your Own Color Using Array Template ...
  FImageIndex := -1;
  FAlignment := taCenter;
  FGlyphLayout := glLeft;
  Width := 75;
  Height := 25;
  Cursor := crHandPoint;
end;

procedure TCustomSmoothButton.SetCancel(Value: Boolean);
begin
  if Value <> FCancel then
  begin
    FCancel := Value;
    if Owner is TCustomForm then
      if FCancel then
      begin
        FDefWndProc := TCustomForm(Owner).WindowProc;
        TCustomForm(Owner).WindowProc := DerivedWndProc;
      end
      else
      begin
        TCustomForm(Owner).WindowProc := FDefWndProc;
        FDefWndProc := nil;
      end;
  end;
end;

procedure TCustomSmoothButton.SetDefault(Value: Boolean);
begin
  if Value <> FDefault then
  begin
    if Enabled and Visible then
      FDefault := Value;
    if (FDefault) and (Owner is TCustomForm) then
      TCustomForm(Owner).ActiveControl := Self;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetCaption(Value: TCaption);
begin
  if Value <> FCaption then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetColor(Value: TSmoothColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetImages(Value: TCustomImageList);
begin
  if Value <> FImages then
  begin
    FImages := Value;
    if Assigned(FImages) then
    begin
      if FImages.Height + 8 > Height then
        Height := FImages.Height + 8;
      if FImages.Width + 8 > Width then
        Width := FImages.Width + 8;
    end;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetImageIndex(Value: Integer);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetAlignment(Value: TAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetGlyphLayout(Value: TGlyphLayout);
begin
  if Value <> FGlyphLayout then
  begin
    FGlyphLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.SetDown(Index: Integer; Value: Boolean);
begin
  case Index of
    1:
      if Value <> FDown then
      begin
        FDown := Value;
        Invalidate;
      end;
    2:
      if Value <> FAllowDown then
      begin
        FAllowDown := Value;
        Invalidate;
      end;
  end;
end;

procedure TCustomSmoothButton.SetState(Value: TButtonState);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

procedure TCustomSmoothButton.Paint;
begin

  if (Focused and not Flat) then
    if FState = bsIdle then
      FState := bsHover;
  if not FUpdating then
    DrawButton(Canvas, ClientRect, Font, Enabled, FFlat, FImages, FImageIndex, FState, FCaption, FAlignment, FGlyphLayout, FDown, FColor);
end;

procedure TCustomSmoothButton.BeginUpdate;
begin
  FUpdating := True;
end;

procedure TCustomSmoothButton.EndUpdate;
begin
  FUpdating := False;
end;

end.
