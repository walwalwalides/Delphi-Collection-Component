{ ============================================
  Software Name : 	OLED Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit UOLEDBaseControlPanel;

interface

uses
  System.SysUtils, System.Classes, Windows, Messages, Vcl.Controls, Vcl.Forms,Vcl.Graphics,Types,UOLEDPanel,UOLEDControls, UOLEDKNOB,UOLEDConstants, Generics.Collections ;

type
  TonClicked  = procedure (Sender:TObject;index,value:integer) of object;
  TOnChanged = procedure (Sender:TObject;index,value:integer) of object;

  TOLEDBaseControlPanelCustom = class (TWinControlOLED)
  private
     defaultDimensionW,defaultDimensionH:integer;
     HeaderGeneratesMouseEvent:boolean;
     FonClicked: TonClicked;
     FonChanged: TonChanged;
     FOLEDElements    : TList<TOLEDPotentiometer>;
     FCaption:string;
     FScalable:boolean;
     FonKnobEdit:TonKnobEdit;
     FcachedElement:TOLEDPotentiometer;
     procedure OnClickCallback(Sender: TObject);
     procedure AddElement(el: TOLEDPotentiometer);
     procedure OnChangedCallback(Sender: TObject; index, value: integer);
protected
     FBasePanel:TWinControl;
     DebugName:string;
     FKnobEditor:TKnobEditor;
     function GetKnobEditor:TKnobEditor;override;
     function GetElement(index: integer): TOLEDPotentiometer;
     procedure GetDefaultDimensions(var w, h: integer);
     function CreatePitchKnob(index:integer;position:TRect): TOLEDPotentiometer ;
     function CreateKnob(index:integer;position:TRect): TOLEDPotentiometer ;
     function Create7SegElement(index: integer;      position: TRect): TOLEDPotentiometer;
     function CreateRolandSlider(index: integer; position: TRect): TOLEDPotentiometer;
// REMOVED 27-10-2017     function CreateRolandInfo(index: integer; position: TRect): TOLEDPotentiometer;
     function CreateRolandKnob(index: integer;   position: TRect): TOLEDPotentiometer;
     function CreateTwinkle(index: integer; position: TRect): TOLEDPotentiometer;
     function CreateLed(index:integer;position:TRect):  TOLEDPotentiometer;
     function CreateText(index:integer;position:TRect): TOLEDPotentiometer;
     function CreateHeader(index:integer;position:TRect):TOLEDPotentiometer;
     function CreateButton(index:integer;position:Trect):TOLEDPotentiometer;
     function CreateButtonEx(index:integer;position:Trect;parent: TWinControl):TOLEDPotentiometer;
     procedure SetCaption(value:string);
     procedure SetonKnobEdit(value:TonKnobEdit);
     property onKnobEdit:TonKnobEdit read FonKnobEdit write SetonKnobEdit;
     property Caption: string read FCaption write SetCaption;
  public
     procedure Changed(Sender:TOLEDPotentiometer);
     procedure setTextLabel(index:integer;s:string);
     procedure SetDefaultDimensions(w,h:integer);
     procedure setHeaderLabel(index:integer;s:string);
     procedure setLedColors(index: integer; cloff,clon: TColor);
     procedure setValue(index,value:integer);virtual;
     procedure setMinMax(index,amin,amax:integer);
     procedure setShape(index:integer;value:TOLEDKnobShape);
     procedure setVisible(index:integer;visible:boolean);
     procedure setDefaultOnChangeHandler;

     procedure setLed(index:integer;value:boolean);
     function getLed(index:integer):boolean;
     function getValue(index:integer):integer;

     procedure setTextColor(index: integer; value: TColor);
     procedure setSliderColor(index: integer; value: TColor);

     procedure setButton(index:integer;value:boolean);
     procedure setButtonText(index:integer;value:string);

     constructor Create(AOwner: TComponent); override;
     Destructor Destroy; Override;
     procedure SetBounds(left,top,width,height:integer);override;
     procedure KnobEditEnd;

     procedure Load(aBasePanel:TWinControl); virtual;
     function Control2Bitmap: TBitmap;
     property OnClicked: TonClicked read FonClicked write FonClicked;
     property OnChanged: TonChanged read FonChanged write FonChanged;
     property BasePanel:TWinControl read FBasePanel;
     property Scalable: boolean read FScalable write FScalable default true;

    end;
  TOLEDBaseControlPanel = class (TOLEDBaseControlPanelCustom)
  public
  published
     property OnChanged;
     property onKnobEdit;
     property Align;
     property Caption;
     property Visible;
     property OnClicked;
  end;

implementation

{ TOLEDBaseControlPanel }

procedure TOLEDBaseControlPanelCustom.setShape(index:integer;value:TOLEDKnobShape);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el<>NIL then
    el.Shape:=value;
end;

procedure TOLEDBaseControlPanelCustom.setValue(index, value: integer);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el<>NIL then
   el.Value:=value;
end;

procedure TOLEDBaseControlPanelCustom.setVisible(index: integer;  visible: boolean);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el<>NIL then
   el.Visible:=visible;
end;

procedure TOLEDBaseControlPanelCustom.setDefaultOnChangeHandler;
VAR el:TOLEDPotentiometer;
     i:integer;
begin
  for i:=0 to 127 do
  begin
    el:=GetElement(i);
    if (el<>NIL) and (not assigned(el.OnChanged)) then
    el.OnChanged:=OnChangedCallback;
  end;
end;

procedure TOLEDBaseControlPanelCustom.setHeaderLabel(index: integer; s: string);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el<>NIL then
   el.Caption:=s;
end;

procedure TOLEDBaseControlPanelCustom.setButton(index: integer; value: boolean);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    el.value:=ord(value);
end;

procedure TOLEDBaseControlPanelCustom.setButtonText(index: integer; value: string);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    el.Caption:=value;
end;

procedure TOLEDBaseControlPanelCustom.SetDefaultDimensions(w, h: integer);
begin
  defaultDimensionW:=w;
  defaultDimensionH:=h;
  Width:=w;
  Height:=h;
end;

procedure TOLEDBaseControlPanelCustom.setTextColor(index: integer; value: TColor);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    el.Font.Color:=value;
end;

procedure TOLEDBaseControlPanelCustom.setLed(index: integer; value: boolean);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    el.Value:=ord(value);
end;

procedure TOLEDBaseControlPanelCustom.setLedColors(index: integer; cloff,  clon: TColor);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then with el do
  begin
    ButtonColorOff:=cloff;
    ButtonColorOn:=clon;
  end;
end;

procedure TOLEDBaseControlPanelCustom.setSliderColor(index: integer; value: TColor);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    el.SliderColor:=value;
end;

procedure TOLEDBaseControlPanelCustom.setTextLabel(index: integer; s: string);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    el.SetCaption(s);
end;

procedure TOLEDBaseControlPanelCustom.setMinMax(index, amin, amax: integer);
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then with el do
  begin
    minvalue:=amin;
    maxvalue:=amax;
  end;
end;

procedure TOLEDBaseControlPanelCustom.SetonKnobEdit(value: TonKnobEdit);
begin
  FOnKnobEdit:=value;
end;

function TOLEDBaseControlPanelCustom.CreateButton(index: integer;  position: Trect):TOLEDPotentiometer;
begin
  result:=CreateButtonEx(index,position,BasePanel);
end;

function TOLEDBaseControlPanelCustom.CreateButtonEx(index: integer;  position: Trect; parent: TWinControl): TOLEDPotentiometer;
begin
  result:=TOLEDPotentiometer.Create(parent);
  result.Parent:=parent;
  result.Position:=position;
  result.visible:=true;
  result.Index:=index;
  result.OnClick:=OnClickCallback;
  result.OnChanged:=OnChangedCallback;
  result.ButtonColorOff:=clBlack;
  result.ButtonColorOn:=clRed;
  result.Shape:=trLedButton;
  AddElement(result);
end;

function TOLEDBaseControlPanelCustom.CreateHeader(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=trText;
end;

function TOLEDBaseControlPanelCustom.CreateKnob(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=trKnob;
end;

function TOLEDBaseControlPanelCustom.CreatePitchKnob(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=trPitchKnob;
end;


function TOLEDBaseControlPanelCustom.Create7SegElement(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.TextWithSeg7:=true;
  result.shape := tkNone;
end;

function TOLEDBaseControlPanelCustom.CreateRolandSlider(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=tkSlider;
end;

(*
function TOLEDBaseControlPanelCustom.CreateRolandInfo(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=tkText;
  result.TextWithSeg7:=true;
end; *)

function TOLEDBaseControlPanelCustom.CreateRolandKnob(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=tkValue;
end;

function TOLEDBaseControlPanelCustom.CreateLed(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=trLed;
end;

function TOLEDBaseControlPanelCustom.CreateTwinkle(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=trTwinkle;
end;


function TOLEDBaseControlPanelCustom.CreateText(index: integer; position: TRect):TOLEDPotentiometer;
begin
  result:=CreateButton(index,position);
  result.Shape:=trText;
end;

function TOLEDBaseControlPanelCustom.GetElement(index: integer): TOLEDPotentiometer;
  function _GetKnobElement(win:TWinControl):TOLEDPotentiometer;
  VAR i:integer;
  begin
    result:=NIL;
    for i:=0 to win.ControlCount-1 do
    if win.Controls[i] is TOLEDPotentiometer then
    begin
      if (win.Controls[i] as TOLEDPotentiometer).Index = index then
        begin result:=win.Controls[i] as TOLEDPotentiometer; exit; end;
    end
    else if win.Controls[i] is TWinControl then
      begin result:=_GetKnobElement(TWinControl(win.Controls[i])); if result<>NIL then exit; end;
  end;
VAR i:integer;
begin
  if FcachedElement<>NIL then if FcachedElement.index = index then begin result:=FcachedElement; exit; end;
  for i:=0 to FOLEDElements.Count-1 do
    if (FOLEDElements[i].index = index)
      then  begin FcachedElement:=FOLEDElements[i]; result:=FcachedElement; exit;end;
  FcachedElement:=_GetKnobElement(BasePanel);
  result:=FcachedElement;
end;

function TOLEDBaseControlPanelCustom.GetKnobEditor: TKnobEditor;
begin
  if assigned(FOnKnobEdit) then
    result:=FKnobEditor
  else if (parent is TOLEDBaseControlPanelCustom) then
     result:=TOLEDBaseControlPanelCustom(parent).GetKnobEditor
  else
    result:=NIL;
end;

function TOLEDBaseControlPanelCustom.getLed(index: integer): boolean;
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    result:=el.Value<>0;
end;

function TOLEDBaseControlPanelCustom.getValue(index:integer): integer;
VAR el:TOLEDPotentiometer;
begin
  el:=GetElement(index);
  if el <> NIL then
    result:=el.Value
  else
    result:=0;
end;

procedure TOLEDBaseControlPanelCustom.GetDefaultDimensions(var w, h: integer);
begin
  w:=defaultDimensionW;
  h:=defaultDimensionH;
end;

procedure TOLEDBaseControlPanelCustom.OnClickCallback(Sender:TObject);
begin
  if assigned(FOnClicked) then with TOLEDPotentiometer(Sender) do
    OnClicked(Sender,Index,Value);
end;


procedure TOLEDBaseControlPanelCustom.OnChangedCallback(Sender:TObject;index,value:integer);
begin
  if assigned(FOnChanged) then
    FOnChanged(Sender,index,value);
end;

procedure TOLEDBaseControlPanelCustom.KnobEditEnd;
begin
  FKnobEditor.EditKeyEnd;
end;

procedure TOLEDBaseControlPanelCustom.Load(aBasePanel:TWinControl);
VAR i:integer;
    el:TOLEDPotentiometer;
begin
  FBasePanel:=aBasePanel;
  for i:=0 to BasePanel.ControlCount-1 do
   if BasePanel.Controls[i] is TOLEDPotentiometer then
   begin
     el:=TOLEDPotentiometer(BasePanel.Controls[i]);
     if el.position.width>0 then continue;
     el.position:=Rect(el.left,el.top,el.width+el.left,el.top+el.height);
     AddElement(el);
   end;
end;

procedure TOLEDBaseControlPanelCustom.SetBounds(left, top, width, height: integer);
VAR i,w,h:integer;
begin
  inherited;
  if not Scalable then begin w:=width;h:=height; end
  else
  begin
    GetDefaultDimensions(w,h);
    if (w<0.3) or (h<0.3) then exit;
  end;
  for i:=0 to FOLEDElements.Count-1 do
    FOLEDElements[i].SetScale(width/w, height / h);
end;

procedure TOLEDBaseControlPanelCustom.AddElement(el: TOLEDPotentiometer);
VAR i:integer;
begin
  if el.Index>0 then
  begin
    for i:=0 to FOLEDElements.Count-1 do
     if (FOLEDElements[i].index = el.index) then
        OutputDebugString(PChar('Add Element: Duplicate Entry..'+DebugName+' '+inttostr(el.Index)));
  end;
  FOLEDElements.Add(el);
end;

procedure TOLEDBaseControlPanelCustom.Changed(Sender: TOLEDPotentiometer);
begin
  OnChangedCallback(Sender,Sender.Index,Sender.Value);
end;

function TOLEDBaseControlPanelCustom.Control2Bitmap: TBitmap;
begin
  Result := TBitmap.Create;
  with Result do begin
    Height := BasePanel.Height;
    Width  := BasePanel.Width;
    Canvas.Handle := CreateDC(nil, nil, nil, nil);
    Canvas.Lock;
    BasePanel.PaintTo(Canvas.Handle, 0, 0);
    Canvas.Unlock;
    DeleteDC(Canvas.Handle);
  end;
end;

constructor TOLEDBaseControlPanelCustom.Create(AOwner: TComponent);
begin
  FOLEDElements:=TList<TOLEDPotentiometer>.Create;
  FScalable:=true;
  inherited Create(Aowner);
  DoubleBuffered:=true;
  FKnobEditor:=TKnobEditor.Create(self);
  Width:=100;
  Height:=100;
end;

destructor TOLEDBaseControlPanelCustom.Destroy;
begin
  FOLEDElements.Free;
  FKnobEditor.Free;
  inherited;
end;


procedure TOLEDBaseControlPanelCustom.SetCaption(value: string);
begin
  FCaption:=value;
  if (BasePanel is  TOLEDPanel)
    then TOLEDPanel(BasePanel).Caption:=value;
end;

initialization
end.





