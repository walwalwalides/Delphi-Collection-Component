unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContactSmoothButton, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    ContactbtnGreen: TContactSmoothButton;
    pnlRight: TPanel;
    pnlLeft: TPanel;
    ilGlyph: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure ContactbtnGreenMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ContactbtnGreenMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.ContactbtnGreenMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlLeft.Color := clGreen;
  pnlRight.Color := clGreen;
  ContactbtnGreen.ImageIndex:=1;


end;

procedure TfrmMain.ContactbtnGreenMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlLeft.Color := clRed;
  pnlRight.Color := clRed;
  ContactbtnGreen.ImageIndex:=0;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.position := poMainFormCenter;
  pnlLeft.Color := clRed;
  pnlRight.Color := clRed;
  ContactbtnGreen.Font.Style:=[fsBold];
  ContactbtnGreen.Font.Color:=clWindowText;
  ContactbtnGreen.Caption:='Green';
end;

end.
