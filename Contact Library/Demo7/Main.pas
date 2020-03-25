unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, uContactImagePanel,
  dxGDIPlusClasses, Vcl.WinXCtrls, Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    pnlSlide: TPanel;
    ToggleSwitch1: TToggleSwitch;
    lblfirstname: TLabel;
    lblLastName: TLabel;
    lblEmail: TLabel;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtEmail: TEdit;
    GrpContact: TGroupBox;
    pnlUp: TPanel;
    ImageList1: TImageList;
    ContipSlide: TContactImagePanel;
    procedure ContactImagePanel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.ContactImagePanel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//showmessage('Hallo');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  self.Position:=poMainFormCenter;
  ToggleSwitch1.StateCaptions.CaptionOff:='Up';
  ToggleSwitch1.StateCaptions.CaptionOn:='Down';

  end;

procedure TfrmMain.ToggleSwitch1Click(Sender: TObject);
begin


if (ToggleSwitch1.State=tssOff) then
   ContipSlide.SlideMode:=smUp
   else
   ContipSlide.SlideMode:=smDown;
end;

end.
