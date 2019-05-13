unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, UOLEDPanel, UOLEDControls, Vcl.StdCtrls, MailContactLabel;

type
  TfrmMain = class(TForm)
    MailContactLabel1: TMailContactLabel;
    lblContact: TLabel;
    procedure FormCreate(Sender: TObject);

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
   frmMain.Position:=poMainFormCenter;
   MailContactLabel1.AdresseMail:='walwalwalides@gmail.com';
   MailContactLabel1.SujetMail:='Question';
end;

end.
