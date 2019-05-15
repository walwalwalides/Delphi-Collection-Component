unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContactArrayButton, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
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
var
  I: Integer;
  j: Integer;
begin
  for I := 0 to ContactArrayBtn1.Columns - 1 do
  begin
    for j := 0 to ContactArrayBtn1.Rows - 1 do
    begin
      with canvas do
      begin
        brush.Color := $C0C0C0;
        TextOut(18 + (45 * I), 20+(35*J), 'walid');

      end;
    end;
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.position := poMainFormCenter;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ContactArrayBtn1.Contacts[1] := 'Walid';
  ContactArrayBtn1.Contacts[2] := 'Daly';
  ContactArrayBtn1.Contacts[3] := 'Khaled';
end;

end.
