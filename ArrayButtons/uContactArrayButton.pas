{ ============================================
  Software Name : 	ArrayButton
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uContactArrayButton;

interface

uses windows,extctrls,controls,classes,graphics,messages;

const ContactMaxBtn = 48;

type TBtnShape = (bsFlat,bs3D);
     TBtnStatus = (stHidden,stFlat,stDown,stHI);
     TBtnOpmode = (omMom,omPress,omToggle);
     TBtnColorIndex = (bcInactBG,bcActiveBG,bcFlat,bcHI,bcLO);
     TBtnChangeProc = procedure(sender : TObject; BtnNr : byte;
                      status : TBtnStatus; button : TmouseButton) of object;
     TBtnPaintProc = procedure(sender : TObject; BtnNr : byte;
                               status : TBtnStatus) of object;
     TColorTable = array[bcInactBG..bcLO] of LongInt;
     TPColorTable = ^TColorTable;

     TContactArrayBtn = class(TGraphicControl)
     private
      FonBtnchange : TBtnChangeProc;
      FonBtnPaint : TBtnPaintProc;
      FonEnter : TNotifyEvent;
      FonLeave : TNotifyEvent;
      FHiBtn : byte;            //mouse over this button
      Frows : byte;             //rows
      Fcolumns : byte;          //columns
      FbtnWidth : byte;         //button width
      FbtnHeight : byte;        //button height
      FBtnEdge : byte;          //button edge
      FBtnSpacing : byte;       //space between buttons
      FBorder : byte;           //border
      FBtnShape : TBtnShape;    //rounded flat, 3D
      FPcolorTable : TPColorTable;
      FBtnControl : array[0..ContactMaxBtn] of byte;
      FNextRelease : byte;
      procedure setRows(n : byte);
      procedure setColumns(n : byte);
      procedure setBtnWidth(n : byte);
      procedure setBtnHeight(n : byte);
      procedure setBtnshape(bs : TBtnShape);
      procedure setBorder(b : byte);
      procedure setSpacing(b : byte);
      procedure setBtnEdge(edge : byte);
      procedure repaintBtns;
      procedure fixdimensions;
      procedure BtnPaint(BtnNr : byte; bst : TBtnStatus);
      procedure CMmouseLeave(var message : Tmessage); message CM_MOUSELEAVE;
      procedure CMmouseEnter(var message : Tmessage); message CM_MOUSEENTER;
      procedure InitBtns;
      procedure SetBtnStatus(BtnNr : byte; status : TBtnStatus);
      function GetBtnGroup(BtnNr : byte) : byte;
      function GetBtnOpMode(BtnNr : byte) : TBtnOpMode;
     protected
      procedure paint; override;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                          X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
      procedure AssignColorTable(p : TPcolorTable);
      procedure TestReleaseBtn(downBtn : byte);
     public
      constructor Create(AOwner: TComponent); override;
      function GetBtnRect(btnNr : byte) : TRect;
      function GetBtnStatus(btnNr : byte) : TBtnStatus;
      procedure setBtnOpmode(BtnNr : byte; opMode: TBtnOpmode);
      procedure BtnHide(btnNr : byte);
      procedure BtnShow(btnNr : byte);
      procedure BtnDown(btnNr : byte);
      procedure BtnRelease(btnNr : byte);
      procedure setBtnGroup(btnNr,group : byte);
      property canvas;
      property PColorTable : TPColorTable read FPColorTable
               write AssignColorTable;
     published
      property Border : byte read FBorder write setBorder default 10;
      property BtnHeight : byte read FBtnHeight write setBtnHeight default 20;
      property BtnSpacing : byte read FBtnSpacing write setSpacing default 5;
      property BtnShape : TBtnShape read FBtnShape write setBtnShape default bs3D;
      property BtnWidth : byte read FBtnWidth write setbtnwidth default 30;
      property BtnEdge : byte read FBtnEdge write SetBtnEdge default 1;
      property Color;
      property Columns : byte read Fcolumns write setcolumns default 2;
      property Enabled;
      property Font;
      property onBtnChange : TBtnChangeProc read FonBtnChange write FonBtnChange;
      property onBtnPaint : TBtnPaintProc read FonBtnPaint write FonBtnPaint;
      property OnEnter : TNotifyEvent read FOnEnter write FOnEnter;
      property OnLeave : TNotifyEvent read FonLeave write FOnLeave;
      property Rows : byte read Frows write setRows default 2;
      property Visible;
     end;

procedure Register;

implementation

const defaultColors : TColorTable =
      ($c0c0c0,$f0f0f0,$808080,$ffffff,$202020);

procedure Register;
begin
 RegisterComponents('Contact Library',[TContactArrayBtn]);
end;

procedure TContactArrayBtn.SetBtnOpMode(BtnNr : byte; Opmode : TBtnOpMode);
var cb : byte;
begin
 cb := FBtnControl[BtnNr] and $cf;
 FBtnControl[BtnNr] := cb or (byte(OpMode) shl 4);
end;

function TContactArrayBtn.GetBtnOpMode(BtnNr : byte) : TbtnOpMode;
begin
 result := TBtnOpMode((FBtnControl[BtnNr] shr 4) and $3);
end;

procedure TContactArrayBtn.setBtnStatus(BtnNr : byte; status : TBtnStatus);
var bc : byte;
begin
 bc := FBtnControl[BtnNr] and $3f;
 FBtnControl[BtnNr] := bc or (byte(status) shl 6);
end;

function TContactArrayBtn.GetBtnGroup(BtnNr : byte) : byte;
begin
 result := FBtnControl[BtnNr] and $f;
end;

procedure TContactArrayBtn.setBtnGroup(btnNr,group : byte);
//add button to group
var bc : byte;
begin
 bc := FBtnControl[BtnNr] and $f0;
 FBtnControl[BtnNr] := bc or group;
end;

procedure TContactArrayBtn.initBtns;
//alle buttons group -0-, press
var i,top : byte;
    control : byte;
begin
 top := FRows*Fcolumns-1;
 control := (byte(stFlat) shl 6) or (byte(omPress) shl 4);
 for i := 0 to ContactMaxBtn do
  if i <= top then FBtnControl[i] := control
   else FBtnControl[i] := 0;
end;

function TContactArrayBtn.GetBtnStatus(btnNr : byte) : TBtnStatus;
begin
 result := TBtnStatus((FBtnControl[btnNr] shr 6) and $3);
end;

procedure TContactArrayBtn.BtnHide(btnNr : byte);
//hide button
begin
 if GetBtnStatus(btnNr) <> stHidden then
  begin
   SetBtnStatus(btnNr,stHidden);
   if FHiBtn = btnNr then FHiBtn := ContactMaxBtn;
   BtnPaint(btnNr,stHidden);
  end;
end;

procedure TContactArrayBtn.BtnShow(btnNr : byte);
//show a hidden button, set flat
begin
 if GetBtnStatus(btnNr) = stHidden then
  begin
   SetBtnStatus(btnNr,stFlat);
   BtnPaint(BtnNr,stFlat);
  end;
end;

procedure TContactArrayBtn.BtnRelease(btnNr : byte);
//set button from DOWN to Flat
begin
 if GetBtnStatus(btnNr) = stDown then
  begin
   SetBtnStatus(btnNr,stFlat);
   BtnPaint(btnNr,stFlat);
  end;
end;

procedure TContactArrayBtn.BtnDown(btnNr : byte);
begin
 if GetBtnStatus(btnNr) = stFlat then
  begin
   SetBtnStatus(btnNr,stDown);
   BtnPaint(btnNr,stDown);
   TestReleaseBtn(btnNr);//to release other buttons
  end;
end;

procedure TContactArrayBtn.TestReleaseBtn(downBtn : byte);
//downBtn was pressed down, test to release buttons of same group
var groupNr,i : byte;
begin
 groupNr := GetBtnGroup(downBtn);
 for i := 0 to Frows*Fcolumns-1 do
  if (i <> downBtn) and (GetBtnGroup(i) = groupNr)
                    and (GetBtnStatus(i)  = stDown) then
   begin
    SetBtnStatus(i,stFlat);
    btnPaint(i,stFlat);
   end;
end;

procedure TContactArrayBtn.BtnPaint(btnNr : byte; bst : TBtnStatus);
//if button hidden: erase
var r : Trect;
    radius : byte;
    k1,k2 : LongInt;
    i : byte;
begin
 r := GetBtnRect(btnNr);
 with canvas do
  begin
   pen.Width := 1;
   brush.style := bssolid;
    case bst of
     stHidden  : begin
                  brush.color := color;
                  brush.style := bsSolid;
                  fillrect(r);
                  exit;
                 end;
     stFlat    : begin
                  brush.color := PColorTable^[bcInactBG];
                  k1 := PColorTable^[bcFlat]; k2 := k1;
                 end;
     stHI      : begin
                  brush.color := PColorTable^[bcInactBG];
                  k1 := PColorTable^[bcHI]; k2 := PColorTable^[bcLO];
                 end;
     stDown    : begin
                  brush.color := PColorTable^[bcActiveBG];
                  k1 := PColorTable^[bcLO]; k2 := PColorTable^[bcHI];
                 end;
    end;//case
    if FBtnShape = bsFlat then    //vlak,ronde hoeken
     begin
      radius := FBtnHeight div 2;
      if radius > 40 then radius := 40;
      if radius < 10 then radius := 10;
      pen.Width := FbtnEdge;
      pen.color := k1;
      roundrect(r.left+1,r.top+1,r.right,r.bottom,radius,radius);
     end
    else
     begin
      fillrect(r);
      for i := 0 to FbtnEdge-1 do
       begin
        pen.color := k1;
        moveto(r.right-1-i,r.top+i);
        lineto(r.left+i,r.top+i);
        lineto(r.left+i,r.bottom-1-i);
        pen.color := k2;
        lineto(r.right-1-i,r.bottom-1-i);
        lineto(r.right-1-i,r.top+i);
       end;//for
     end;//else
  end;//with canvas
  if not (csDesigning in componentstate) and assigned(onBtnPaint) then
   onBtnPaint(self,btnNr,bst);
end;

procedure TContactArrayBtn.RepaintBtns;
//na initialiseren hele paintbox
var i : byte;
begin
 for i := 0 to FRows*Fcolumns-1 do BtnPaint(i,GetBtnStatus(i));
end;

procedure TContactArrayBtn.FixDimensions;
//adjust width,height na verandering van knop of spacing
//generates onPaint event
begin
 if FRows = 0 then FRows := 1;
 if FColumns = 0 then FColumns := 1;
 width := FColumns*(FBtnWidth + FBtnSpacing) - FBtnSpacing + 2*Fborder;
 height := FRows*(FBtnHeight + FBtnspacing) - FBtnSpacing + 2*Fborder;
end;

constructor TContactArrayBtn.Create(AOwner: TComponent);
begin
 inherited create(Aowner);
 canvas.font := font;
 FHiBtn := ContactMaxBtn;//=off
 FBtnShape := bs3D;
 FbtnEdge := 1;
 FPColorTable := @defaultColors;
 Frows := 4;
 Fcolumns := 4;
 InitBtns;
 FbtnWidth := 40;
 FbtnHeight := 30;
 FBtnSpacing := 5;
 FBorder := 10;
 fixDimensions;//set width , height
end;

procedure TContactArrayBtn.AssignColorTable(p : TPcolorTable);
begin
 FPcolorTable := p;
 invalidate;
end;

procedure TContactArrayBtn.MouseDown(Button: TMouseButton; Shift: TShiftState;
                    X, Y: Integer);
var status : TBtnStatus;
begin
 FNextRelease := ContactMaxBtn;
 if (FHiBtn = ContactMaxBtn) then exit; //no button selected
//----
 status := GetBtnstatus(FHIbtn);
 if status = stFlat then
  begin
   SetBtnStatus(FHIbtn,stDown);
   BtnPaint(FHIbtn,stDown);
   TestReleaseBtn(FHIbtn);
   if assigned(FonBtnChange) and (not (csDesigning in componentstate)) then
    onBtnChange(self,FHiBtn,stDown,button);
  end;
 case GetBtnOpMode(FHIbtn) of
  omMom    : FNextRelease := FHIbtn;
  omToggle : if status = stDown then FNextrelease := FHIbtn;
 end;//case
end;

procedure TContactArrayBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
begin
 if FNextRelease <> ContactMaxBtn then
  begin
   SetBtnStatus(FNextRelease,stFlat);
   BtnPaint(FNextRelease,stFlat);
   if (not (csDesigning in componentstate)) and assigned(FonBtnChange) then
      onBtnChange(self,FNextRelease,stFlat,button);
  end;
end;

procedure TContactArrayBtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var dx,maxX,maxY,dy : integer;
    button : byte;
    px,py : integer;
    status : TBtnStatus;
begin
 x := x - FBorder; y := y - FBorder;
 dx := FBtnSpacing + FBtnWidth;
 dy := FBtnSpacing + FBtnHeight;
 maxX := FColumns * dx; maxY := FRows * dy;
 px := x mod dx; py := y mod dy;
 if (x < maxX) and (y < maxY) and
    (px > FBtnEdge) and (px < dx-FBtnEdge-FBtnSpacing) and
    (py > FBtnEdge) and (py < dy-FBtnEdge-FBtnSpacing) then
  begin
   button := x div dx + FColumns*(y div dy);
  end
 else button := ContactMaxBtn;
 status := GetBtnStatus(button);
 if (status = stHidden) then button := ContactMaxBtn;
 if button = FHiBtn then exit;//if no change

//---process Btn change
 if button <> ContactMaxBtn then cursor := crhandpoint
  else cursor := crArrow;

 if (FHIbtn <> ContactMaxBtn) and (GetBtnStatus(FHIbtn) <> stDown) then
     BtnPaint(FHIbtn,stFlat);//remove HI edge
 if (button <> ContactMaxBtn) and (GetBtnStatus(button) <> stDown) then
     BtnPaint(button,stHI);//paint HI
 FHIbtn := button;    
end;

procedure TContactArrayBtn.Paint;
var i : byte;
    k1,k2 : LongInt;
begin
 FHiBtn := ContactMaxBtn;
  with canvas do
   begin
    brush.color := color;
    pen.Width := 1;
    pen.color := PcolorTable^[bcFlat];
    fillrect(rect(0,0,width,height));
    if FBorder > 0 then
     begin
      if FBtnShape = bs3D then
       begin
        k1 := PcolorTable^[bcHI]; k2 := PcolorTable^[bcFlat];
       end
      else begin
            k1 := Pcolortable^[bcFlat]; k2 := k1;
           end;
      pen.color := k1;
      moveto(width-1,0);
      lineto(0,0); lineto(0,height-1);
      pen.color := k2;
      lineto(width-1,height-1); lineto(width-1,0);
    end;//if border
   end;//with
 for i := 0 to FColumns*Frows-1 do
  if GetBtnStatus(i) <> stHidden then Btnpaint(i,GetBtnStatus(i));
end;

function TContactArrayBtn.GetBtnRect(btnNr : byte) : TRect;
var x,y : integer;
begin
 x := btnNr mod Fcolumns;
 y := btnNr div FColumns;
 with result do
  begin
   left := Fborder + (FBtnWidth + FBtnspacing)*x;
   right := left + FBtnWidth;
   top := Fborder + (FBtnHeight + FBtnspacing)*y;
   bottom := top + FbtnHeight;
  end;
end;

procedure TContactArrayBtn.setRows(n : byte);
begin
 if n = 0 then n := 1;
 if n > ContactMaxBtn then n := ContactMaxBtn;
 if n * Fcolumns > ContactMaxBtn then Fcolumns := 1;
 Frows := n;
 initBtns;
 FixDimensions;
end;

procedure TContactArrayBtn.setColumns(n : byte);
begin
 if n = 0 then n := 1;
 if n > ContactMaxBtn then n := ContactMaxBtn;
 if n * Frows > ContactMaxBtn then Frows := 1;
 Fcolumns := n;
 initBtns;
 FixDimensions;
end;

procedure TContactArrayBtn.setBtnWidth(n : byte);
begin
 if n < 10 then n := 10;
 FBtnWidth := n;
 FixDimensions;
end;

procedure TContactArrayBtn.setBtnHeight(n : byte);
begin
 if n < 10 then n := 10;
 FBtnHeight := n;
 FixDimensions;
end;

procedure TContactArrayBtn.setBtnShape(bs : TBtnShape);
begin
 FBtnShape := bs;
 invalidate;
end;

procedure TContactArrayBtn.setBtnEdge(edge : byte);
begin
 if edge = 0 then edge := 1
  else if edge > 2 then edge := 2;
 FBtnEdge := edge;
 repaintBtns;
end;

procedure TContactArrayBtn.setBorder(b : byte);
begin
 Fborder := b;
 FixDimensions;
end;

procedure TContactArrayBtn.setSpacing(b : byte);
begin
 FBtnSpacing := b;
 FixDimensions;
end;

procedure TContactArrayBtn.CMmouseLeave(var message : Tmessage);
begin
 if (FHiBtn <> ContactMaxBtn) then
  begin
   if GetBtnStatus(FHIbtn) <> stDown then BtnPaint(FHIbtn,stFlat);
   FHIbtn := ContactMaxBtn;
  end;
 if not (csDesigning in componentstate) and assigned(FOnLeave) then
    onLeave(self);
end;

procedure TContactArrayBtn.CMmouseEnter(var message : Tmessage);
begin
 if not (csDesigning in componentstate) and assigned(FOnLeave) then
    onEnter(self);
end;

end.
