unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContactArrayButton, Vcl.StdCtrls, MailContactLabel;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    ContactArrayBtn1: TContactArrayBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
//
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.position := poMainFormCenter;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
//
end;

end.
