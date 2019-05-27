{ ============================================
  Software Name : 	Demo4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
//-------------------------------------------------------------
//Exemple how to use ContactSmoothBtn
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContactSmoothButton, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, uCurrencyContact, Vcl.Samples.Spin;

type
  TfrmMain = class(TForm)
    ContactCurrency1: TContactCurrency;
    ContactSmoothBtnEuro: TContactSmoothBtn;
    ContactSmoothBtnDollar: TContactSmoothBtn;
    ContactSmoothBtnDinar: TContactSmoothBtn;
    Panel1: TPanel;
    SpinButton1: TSpinButton;
    procedure FormCreate(Sender: TObject);
    procedure ContactSmoothBtnDollarClick(Sender: TObject);
    procedure ContactSmoothBtnEuroClick(Sender: TObject);
    procedure ContactSmoothBtnDinarClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}



procedure TfrmMain.ContactSmoothBtnDinarClick(Sender: TObject);
begin
   ContactCurrency1.TypeCurrency:=TND;
end;

procedure TfrmMain.ContactSmoothBtnDollarClick(Sender: TObject);
begin
  ContactCurrency1.TypeCurrency:=USD;
end;

procedure TfrmMain.ContactSmoothBtnEuroClick(Sender: TObject);
begin
 ContactCurrency1.TypeCurrency:=EUR;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.position := poMainFormCenter;

end;

procedure TfrmMain.SpinButton1DownClick(Sender: TObject);
begin
 ContactCurrency1.Value:=ContactCurrency1.Value+1;
end;

procedure TfrmMain.SpinButton1UpClick(Sender: TObject);
begin
 ContactCurrency1.Value:=ContactCurrency1.Value+1;
end;

end.
