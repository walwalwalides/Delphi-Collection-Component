{ ============================================
  Software Name : 	TContactCurrency
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit uCurrencyContact;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Menus, Forms, Dialogs, StdCtrls;

const
  GWW_ID = (-12);

type
  TTypeCurrency = (USD,EUR,TND);

  TContactCurrency = class(TCustomMemo)
  private
    DispFormat: string;
    FieldValue: Extended;
    FDecimalPlaces: Word;
    FPosColor: TColor;
    FNegColor: TColor;
    FTypeCurrency: TTypeCurrency;
    procedure SetFormat(A: string);
    procedure SetFieldValue(A: Extended);

    procedure SetDecimalPlaces(A: Word);
    procedure SetPosColor(A: TColor);
    procedure SetNegColor(A: TColor);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure FormatText;
    procedure UnFormatText;
    procedure SetTypeCurrency(const Value: TTypeCurrency);
  protected
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;

  published
    property Alignment default taRightJustify;
    property AutoSize default True;
    property TypeCurrency: TTypeCurrency read FTypeCurrency write SetTypeCurrency default USD;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DecimalPlaces: Word read FDecimalPlaces write SetDecimalPlaces default 2;
    property DisplayFormat: string read DispFormat write SetFormat;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property NegColor: TColor read FNegColor write SetNegColor default clRed;
    property ParentColor;
    property ParentCtl3D;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property PosColor: TColor read FPosColor write SetPosColor default clBlack;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property Value: Extended read FieldValue write SetFieldValue;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;

    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

implementation


constructor TContactCurrency.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoSize := False;
  Alignment := taRightJustify;
  Width := 121;
  Height := 25;
  DispFormat := '$,0.00;($,0.00)';
  FieldValue := 0.0;
  FDecimalPlaces := 2;
  FPosColor := Font.Color;
  FNegColor := clRed;
  AutoSelect := False;
  WordWrap := False;
  FormatText;
end;

procedure TContactCurrency.CreateParams(var Params: TCreateParams);
var
  lStyle: longint;
begin
  inherited CreateParams(Params);
  case Alignment of
    taLeftJustify:
      lStyle := ES_LEFT;
    taRightJustify:
      lStyle := ES_RIGHT;
    taCenter:
      lStyle := ES_CENTER;
  end;
  Params.Style := Params.Style or lStyle;
end;

procedure TContactCurrency.SetFormat(A: String);
begin
  if DispFormat <> A then
  begin
    DispFormat := A;
    FormatText;
  end;
end;

procedure TContactCurrency.SetFieldValue(A: Extended);
begin
  if FieldValue <> A then
  begin
    FieldValue := A;
    FormatText;
  end;
end;

procedure TContactCurrency.SetDecimalPlaces(A: Word);
begin
  if DecimalPlaces <> A then

  begin
    DecimalPlaces := A;
    FormatText;
  end;
end;

procedure TContactCurrency.SetPosColor(A: TColor);
begin
  if FPosColor <> A then
  begin
    FPosColor := A;
    FormatText;
  end;
end;

procedure TContactCurrency.SetTypeCurrency(const Value: TTypeCurrency);
begin
  if (Value = USD) then
  begin
    DispFormat := '$,0.00;($,0.00)';
    FTypeCurrency:=USD;
  end;

  if (Value = EUR) then
  begin
    DispFormat := '€,0.00;(€,0.00)';
    FTypeCurrency:=EUR;
  end;

    if (Value = TND) then
  begin
    DispFormat := '0.00دينار,;(دينار,0.00)';
    FTypeCurrency:=TND;
  end;
    FormatText;

end;

procedure TContactCurrency.SetNegColor(A: TColor);
begin
  if FNegColor <> A then
  begin
    FNegColor := A;
    FormatText;
  end;
end;

procedure TContactCurrency.UnFormatText;
var
  TmpText: String;
  Tmp: Byte;

  IsNeg: Boolean;
begin
  IsNeg := (Pos('-', Text) > 0) or (Pos('(', Text) > 0);
  TmpText := '';
  For Tmp := 1 to Length(Text) do
    if Text[Tmp] in ['0' .. '9', FormatSettings.DecimalSeparator] then
      TmpText := TmpText + Text[Tmp];
  try
    If TmpText = '' Then
      TmpText := '0.00';
    FieldValue := StrToFloat(TmpText);
    if IsNeg then
      FieldValue := -FieldValue;
  except
    MessageBeep(mb_IconAsterisk);
  end;
end;

procedure TContactCurrency.FormatText;

begin
  Text := FormatFloat(DispFormat, FieldValue);
  if FieldValue < 0 then
    Font.Color := NegColor
  else
    Font.Color := PosColor;
end;


procedure TContactCurrency.CMEnter(var Message: TCMEnter);
begin
  SelectAll;
  inherited;
end;

procedure TContactCurrency.CMExit(var Message: TCMExit);
begin
  UnFormatText;
  FormatText;
  Inherited;
end;

procedure TContactCurrency.KeyPress(var Key: Char);
Var
  S: String;
  frmParent: TCustomForm;
  btnDefault: TButton;
  i: integer;

  wID: Word;
  LParam: LongRec;
begin
  if Not(Key in ['0' .. '9', '.', '-', #8, #13]) Then
    Key := #0;
  case Key of
    #13:
      begin
        frmParent := GetParentForm(Self);
        UnFormatText;
        btnDefault := nil;
        for i := 0 to frmParent.ControlCount - 1 do
          if frmParent.Controls[i] is TButton then
            if (frmParent.Controls[i] as TButton).Default then
              btnDefault := (frmParent.Controls[i] as TButton);
        if btnDefault <> nil then
        begin
          wID := GetWindowWord(btnDefault.Handle, GWW_ID);
          LParam.Lo := btnDefault.Handle;
          LParam.Hi := BN_CLICKED;
          SendMessage(frmParent.Handle, WM_COMMAND, wID, longint(LParam));
        end;
        Key := #0;
      end;
    '.':
      if (Pos('.', Text) > 0) then
        Key := #0;
    '-':
      if (Pos('-', Text) > 0) or (SelStart > 0) then
        Key := #0;
  else
    { Allow only one character  '-' }
    if (Pos('-', Text) > 0) and (SelStart = 0) and (SelLength = 0) then
      Key := #0;
  end;

  if Key <> Char(vk_Back) then
  begin
    S := Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1, Length(Text));
    if ((Pos(FormatSettings.DecimalSeparator, S) > 0) and (Length(S) - Pos(FormatSettings.DecimalSeparator, S) > FDecimalPlaces))
      or ((Key = '-') and (Pos('-', Text) <> 0))
      or (Pos('-', S) > 1)
    then
      Key := #0;

  end;

  if Key <> #0 then
    inherited KeyPress(Key);
end;



end.
