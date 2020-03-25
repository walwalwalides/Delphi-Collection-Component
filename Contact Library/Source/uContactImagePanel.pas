unit uContactImagePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ShellApi,
  extctrls;

type
  TModeSlide = (smUp, smDown);

  TContactImagePanel = class(TImage)
  private
    { Déclarations privées }
    FSelectedPanel: TPanel;
    FTimerUp: TTimer;
    FTimerDown: TTimer;
    FOnClick: TNotifyEvent;
    FDownInterval: integer;
    FUpInterval: integer;
    FSlideMode: TModeSlide;
    FSlideHeight: integer;
    procedure SetSelectedPanel(const Value: TPanel);
    procedure SetUpInterval(const Value: integer);
    procedure SetDownInterval(const Value: integer);
  protected
    { Déclarations protégées }
    procedure paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure DoOnTimerUp(Sender: TObject);
    procedure DoOnTimerDown(Sender: TObject);
  public
    { Déclarations publiques }
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
        procedure Assign(Source: TPersistent); override;
  published
    { Déclarations publiées }
    Property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property SelectedPanel: TPanel read FSelectedPanel write SetSelectedPanel;
    property IntervalUp: integer read FUpInterval write SetUpInterval;
    property IntervalDown: integer read FDownInterval write SetDownInterval;
    property SlideHeight: integer read FSlideHeight write FSlideHeight;
    property SlideMode: TModeSlide read FSlideMode write FSlideMode;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  RegisterComponents('Contact Library', [TContactImagePanel]);
//end;

procedure TContactImagePanel.Assign(Source: TPersistent);
begin
  inherited;
//

  if Source is Tpanel then
  begin
    FSelectedPanel := TPanel(Source);
  end;

end;

Constructor TContactImagePanel.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  self.Cursor := crHandPoint;
  self.Stretch := true;
  self.Proportional := true;
  FSlideMode := smUp;
  FSlideHeight := 300;

  // -------------------------------------------
  FTimerUp := TTimer.Create(self);
  FTimerDown := TTimer.Create(self);

  FTimerUp.Enabled := false;
  FTimerDown.Enabled := false;

  FTimerUp.Interval := 10;
  FTimerDown.Interval := 10;

  FDownInterval := FTimerDown.Interval;
  FUpInterval := FTimerUp.Interval;

  FTimerUp.OnTimer := DoOnTimerUp;
  FTimerDown.OnTimer := DoOnTimerDown;

  //
end;

destructor TContactImagePanel.Destroy;
begin
  // self.FSelectedPanel.Free;
  self.FTimerUp.Free;
  self.FTimerDown.Free;
  inherited;
end;

procedure TContactImagePanel.DoOnTimerUp(Sender: TObject);
var
  startheight: integer;
begin
  //

  if (FSelectedPanel.Height <= FSlideHeight) then
  begin
    startheight := FSelectedPanel.Height;
    FSelectedPanel.Height := FSelectedPanel.Height + 4;
  end
  else
  begin
    FTimerUp.Enabled := false;
  end;

end;

procedure TContactImagePanel.DoOnTimerDown(Sender: TObject);
begin
  //
  if (FSelectedPanel.Height > 0) then
  begin
    FSelectedPanel.Height := FSelectedPanel.Height - 6;
  end
  else
  begin
    FTimerDown.Enabled := false;
  end;

end;

procedure TContactImagePanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);

Begin
  inherited;
  if (FSlideMode = smUp) then
  Begin
    if (FSelectedPanel <> nil) then
    begin
      FSelectedPanel.Visible := true;
      FTimerUp.Enabled := true;
    end;
  End;

  if (FSlideMode = smDown) then
  Begin
    if (FSelectedPanel <> nil) then
    begin
      FSelectedPanel.Visible := true;
      FTimerDown.Enabled := true;
    end;
  End;

end;

procedure TContactImagePanel.paint;
begin
  inherited;
  //
end;

procedure TContactImagePanel.SetDownInterval(const Value: integer);
begin
  //
    FDownInterval := Value;
  FTimerDown.Interval:=FUpInterval;
end;

procedure TContactImagePanel.SetSelectedPanel(const Value: TPanel);
begin
  if (Value <> FSelectedPanel) then
  begin
    // if (Value = nil) then
    // Begin
    // FSelectedPanel.Height := 100;
    // FSelectedPanel.Align := alNone;

    // end
    // else
    Begin

      FSelectedPanel := Value;
      if (FSelectedPanel <> nil) then
      begin
        if not(csDesigning in ComponentState) then
        FSelectedPanel.Height := 0;
        FSelectedPanel.Align := alBottom;
        FSelectedPanel.Visible := false;

        if (FSelectedPanel.Enabled)
        { and (not(csDesigning in ComponentState)) and (not(csLoading in ComponentState)) }
        then
        begin

        end
        else
        begin
          if (FSelectedPanel <> nil) then
            FreeAndNil(FSelectedPanel);

        end;
        // if IsStateOn then
        // SetStateInternal(lsOn)
        // else
        // SetStateInternal(lsOff);
        // end
        // else
        // SetStateInternal(lsOff);
      end
      { if (not(csDesigning in ComponentState)) and
        (not(csLoading in ComponentState)) then }

    End;
  end

end;

procedure TContactImagePanel.SetUpInterval(const Value: integer);
begin
  FUpInterval := Value;
  FTimerUp.Interval:=FUpInterval;
end;

end.
