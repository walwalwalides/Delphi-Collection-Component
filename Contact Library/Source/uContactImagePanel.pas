unit uContactImagePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ShellApi,extctrls;

type
  TContactImagePanel = class(TImage)
  private
    { Déclarations privées }
    FSelectedPanel:TPanel;
    FTimerUp:TTimer;
    FTimerDown:TTimer;
    FOnClick: TNotifyEvent;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    Constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
  published
    { Déclarations publiées }
    Property OnClick: TNotifyEvent read FOnClick write FOnClick;
      property SelectedPanel: TPanel read FSelectedPanel;
  end;


implementation

Constructor TContactImagePanel.Create(Aowner: TComponent);
begin
  Inherited Create(AOwner);
   //
end;

destructor TContactImagePanel.Destroy;
begin
  Self.FSelectedPanel.Free;
  inherited;
end;

//var
//  startheight: Integer;
//begin
//  if (Panel1.Height <= 217) then
//  begin
//    YearProgressForm1.Enabled := False;
//    startheight := Panel1.Height;
//    Panel1.Height := Panel1.Height + 4;
//  end
//  else
//  begin
//    tmrUpPanel.Enabled := False;
//    YearProgressForm1.Enabled := True;
//  end;
//end;

//  if Panel1.Height > 0 then
//  begin
//    YearProgressForm1.Enabled := False;
//    Panel1.Height := Panel1.Height - 6;
//  end
//  else
//  begin
//    tmrDownPanel.Enabled := False;
//    YearProgressForm1.Enabled := True;
//  end;


end.
