unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, UOLEDEmptyPanel, UOLEDControls, URMCControls, URMCCheckBox, UOLEDPanel, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    OLEDPanel1: TOLEDPanel;
    OLEDPotentiometer1: TOLEDPotentiometer;
    OLEDPanel2: TOLEDPanel;
    OLEDPotentiometer2: TOLEDPotentiometer;
    lblValue1: TLabel;
    lblValue2: TLabel;

    procedure OLEDPotentiometer1Changed(Sender: TObject; index, value: Integer);
    procedure FormCreate(Sender: TObject);
    procedure OLEDPotentiometer2Changed(Sender: TObject; index, value: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Test: TOLEDPotentiometer;
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  OLEDPanel1.font.Size := 21;
  OLEDPotentiometer1.Margins.Top := 15;
  OLEDPotentiometer1.Margins.Left := 15;
  OLEDPotentiometer1.Margins.Right := 15;
  OLEDPotentiometer1.Margins.Bottom := 15;
  OLEDPotentiometer2.Margins.Top := 15;
  OLEDPotentiometer2.Margins.Left := 15;
  OLEDPotentiometer2.Margins.Right := 15;
  OLEDPotentiometer2.Margins.Bottom := 15;
end;

procedure TfrmMain.OLEDPotentiometer1Changed(Sender: TObject; index, value: Integer);
begin
  //
  OLEDPanel1.Caption := value.ToString;
end;

procedure TfrmMain.OLEDPotentiometer2Changed(Sender: TObject; index, value: Integer);
begin
  OLEDPanel2.Caption := value.ToString;
end;

end.
