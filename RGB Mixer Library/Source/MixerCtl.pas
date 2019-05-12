{ ============================================
  Software Name : 	Mixer Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit MixerCtl;
{$Warnings OFF}

interface

uses
  Classes, Controls, StdCtrls, ExtCtrls, Forms,
  Messages, Graphics, Windows, Mixer;

type
  // property types
  TComProperty = (cpNone, cpPort, cpBaudRate, cpDataBits, cpStopBits, cpParity, cpFlowControl);

  // assistant class for TComComboMixer, TComRadioGroup controls
  TComSelect = class
  private
    FPort: TMixer;
    FBaudRate: TBaudRate;
    FDataBits: TDataBits;
    FStopBits: TStopBits;
    FParity: TParityBits;
    FFlowControl: TFlowControl;
    FItems: TStrings;
    FComProperty: TComProperty;
    FComPort: TCustomComMixer;
    FAutoApply: Boolean;
  private
    procedure SetComProperty(const Value: TComProperty);
  public
    procedure SelectPort;
    procedure SelectBaudRate;
    procedure SelectParity;
    procedure SelectStopBits;
    procedure SelectDataBits;
    procedure SelectFlowControl;
    procedure Change(const Text: string);
    procedure UpdateSettings(var ItemIndex: Integer);
    procedure ApplySettings;
    property Items: TStrings read FItems write FItems;
    property ComProperty: TComProperty read FComProperty write SetComProperty;
    property ComPort: TCustomComMixer read FComPort write FComPort;
    property AutoApply: Boolean read FAutoApply write FAutoApply;
  end;

  // comboMixer control for selecting port properties
  TComComboMixer = class(TCustomComboBox)
  private
    FComSelect: TComSelect;
    function GetAutoApply: Boolean;
    function GetComPort: TCustomComMixer;
    function GetComProperty: TComProperty;
    function GetText: string;
    procedure SetAutoApply(const Value: Boolean);
    procedure SetComPort(const Value: TCustomComMixer);
    procedure SetComProperty(const Value: TComProperty);
    procedure SetText(const Value: string);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplySettings;
    procedure UpdateSettings;
  published
    property ComPort: TCustomComMixer read GetComPort write SetComPort;
    property ComProperty: TComProperty read GetComProperty write SetComProperty default cpNone;
    property AutoApply: Boolean read GetAutoApply write SetAutoApply default False;
    property Text: string read GetText write SetText;
    property Style;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ItemIndex;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
{$IFDEF DELPHI_4_OR_HIGHER}
    property Anchors;
    property BiDiMode;
    property CharCase;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
{$IFDEF DELPHI_4_OR_HIGHER}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
{$IFDEF DELPHI_5_OR_HIGHER}
    property OnContextPopup;
{$ENDIF}
  end;

  // radio group control for selecting port properties




implementation

{$R CPortImg.res}

uses
  SysUtils, Dialogs;

(* ****************************************
  * TComSelect class                      *
  **************************************** *)

// select baud rate property
procedure TComSelect.SelectBaudRate;
var
  I: TBaudRate;
begin
  Items.Clear;
  for I := Low(TBaudRate) to High(TBaudRate) do
    Items.Add(BaudRateToStr(I));
end;

// select port property
procedure TComSelect.SelectPort;
begin
  Items.Clear;
  EnumComPorts(Items);
end;

// select data bits property
procedure TComSelect.SelectDataBits;
var
  I: TDataBits;
begin
  Items.Clear;
  for I := Low(TDataBits) to High(TDataBits) do
    Items.Add(DataBitsToStr(I));
end;

// select parity property
procedure TComSelect.SelectParity;
var
  I: TParityBits;
begin
  Items.Clear;
  for I := Low(TParityBits) to High(TParityBits) do
    Items.Add(ParityToStr(I));
end;

// select stop bits property
procedure TComSelect.SelectStopBits;
var
  I: TStopBits;
begin
  Items.Clear;
  for I := Low(TStopBits) to High(TStopBits) do
    Items.Add(StopBitsToStr(I));
end;

// select flow control property
procedure TComSelect.SelectFlowControl;
var
  I: TFlowControl;
begin
  Items.Clear;
  for I := Low(TFlowControl) to High(TFlowControl) do
    Items.Add(FlowControlToStr(I));
end;

// set property port settings for selecting
procedure TComSelect.SetComProperty(const Value: TComProperty);
begin
  FComProperty := Value;
  case FComProperty of
    cpPort:
      SelectPort;
    cpBaudRate:
      SelectBaudRate;
    cpDataBits:
      SelectDataBits;
    cpStopBits:
      SelectStopBits;
    cpParity:
      SelectParity;
    cpFlowControl:
      SelectFlowControl;
  else
    Items.Clear;
  end;
end;

// set selected setting
procedure TComSelect.Change(const Text: string);
begin
  case FComProperty of
    cpPort:
      FPort := Text;
    cpBaudRate:
      FBaudRate := StrToBaudRate(Text);
    cpDataBits:
      FDataBits := StrToDataBits(Text);
    cpStopBits:
      FStopBits := StrToStopBits(Text);
    cpParity:
      FParity := StrToParity(Text);
    cpFlowControl:
      FFlowControl := StrToFlowControl(Text);
  end;
  if FAutoApply then
    ApplySettings;
end;

// apply settings to TCustomComMixer
procedure TComSelect.ApplySettings;
begin
  if FComPort <> nil then
  begin
    with FComPort do
    begin
      case FComProperty of
        cpPort:
          Port := FPort;
        cpBaudRate:
          BaudRate := FBaudRate;
        cpDataBits:
          DataBits := FDataBits;
        cpStopBits:
          StopBits := FStopBits;
        cpParity:
          Parity.Bits := FParity;
        cpFlowControl:
          FlowControl.FlowControl := FFlowControl;
      end;
    end;
  end;
end;

// update settings from TCustomComMixer
procedure TComSelect.UpdateSettings(var ItemIndex: Integer);
begin
  if FComPort <> nil then
    with FComPort do
      case FComProperty of
        cpPort:
          begin
            ItemIndex := Items.IndexOf(Port);
            if ItemIndex > -1 then
              FPort := Items[ItemIndex];
          end;
        cpBaudRate:
          begin
            ItemIndex := Items.IndexOf(BaudRateToStr(BaudRate));
            if ItemIndex > -1 then
              FBaudRate := StrToBaudRate(Items[ItemIndex]);
          end;
        cpDataBits:
          begin
            ItemIndex := Items.IndexOf(DataBitsToStr(DataBits));
            if ItemIndex > -1 then
              FDataBits := StrToDataBits(Items[ItemIndex]);
          end;
        cpStopBits:
          begin
            ItemIndex := Items.IndexOf(StopBitsToStr(StopBits));
            if ItemIndex > -1 then
              FStopBits := StrToStopBits(Items[ItemIndex]);
          end;
        cpParity:
          begin
            ItemIndex := Items.IndexOf(ParityToStr(Parity.Bits));
            if ItemIndex > -1 then
              FParity := StrToParity(Items[ItemIndex]);
          end;
        cpFlowControl:
          begin
            ItemIndex := Items.IndexOf(FlowControlToStr(FlowControl.FlowControl));
            if ItemIndex > -1 then
              FFlowControl := StrToFlowControl(Items[ItemIndex]);
          end;
      end;
end;

(* ****************************************
  * TComComboMixer control                  *
  **************************************** *)

// create control
constructor TComComboMixer.Create(AOwner: TComponent);
begin
  FComSelect := TComSelect.Create;
  inherited Create(AOwner);
  FComSelect.Items := Items;
  Style := csDropDownList;
end;

// destroy control
destructor TComComboMixer.Destroy;
begin
  inherited Destroy;
  FComSelect.Free;
end;

// apply settings to TCustomComMixer
procedure TComComboMixer.ApplySettings;
begin
  FComSelect.ApplySettings;
end;

// update settings from TCustomComMixer
procedure TComComboMixer.UpdateSettings;
var
  Index: Integer;
begin
  FComSelect.UpdateSettings(Index);
  ItemIndex := Index;
end;

// remove ComPort property if being destroyed
procedure TComComboMixer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FComSelect.ComPort) and (Operation = opRemove) then
  begin
    FComSelect.ComPort := nil;
    if Items.Count > 0 then
      ItemIndex := 0;
  end;
end;

// perform change when selection is changed
procedure TComComboMixer.Change;
begin
  FComSelect.Change(Text);
  inherited Change;
end;

// set ComPort property
procedure TComComboMixer.SetComPort(const Value: TCustomComMixer);
begin
  if FComSelect.ComPort <> Value then
  begin
    FComSelect.ComPort := Value;
    if FComSelect.ComPort <> nil then
    begin
      FComSelect.ComPort.FreeNotification(Self);
      // transfer settings from ComPort to this control
      UpdateSettings;
    end;
  end;
end;

function TComComboMixer.GetComPort: TCustomComMixer;
begin
  Result := FComSelect.ComPort;
end;

function TComComboMixer.GetAutoApply: Boolean;
begin
  Result := FComSelect.AutoApply;
end;

procedure TComComboMixer.SetAutoApply(const Value: Boolean);
begin
  FComSelect.AutoApply := Value;
end;

function TComComboMixer.GetText: string;
begin
  if ItemIndex = -1 then
    Result := ''
  else
    Result := Items[ItemIndex];
end;

procedure TComComboMixer.SetText(const Value: string);
begin
  if Items.IndexOf(Value) > -1 then
    ItemIndex := Items.IndexOf(Value);
end;

// change property for selecting
procedure TComComboMixer.SetComProperty(const Value: TComProperty);
var
  Index: Integer;
begin
  FComSelect.ComProperty := Value;
  if Items.Count > 0 then
    if FComSelect.ComPort <> nil then
    begin
      // transfer settings from ComPort to this control
      FComSelect.UpdateSettings(Index);
      ItemIndex := Index;
    end
    else
      ItemIndex := 0;
end;

function TComComboMixer.GetComProperty: TComProperty;
begin
  Result := FComSelect.ComProperty;
end;

end.


