{ ============================================
  Software Name :     MailContactLabel
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit MailContactLabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ShellApi;

type
TAdresseMail = string;
TSujetMail = string;
  TMailContactLabel = class(TLabel)
  private
    { Déclarations privées }
    FAdresseMail: TAdresseMail;
    FSujetMail: TSujetMail;
    FOnMailClick: TNotifyEvent;
    FOnClick: TNotifyEvent;
    Procedure SetAdresseMail(AdresseMail: TAdresseMail);
    Procedure SetSujetMail(SujetMail: TSujetMail);
    Procedure MailClick(Sender: TObject);
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    Constructor Create(AOwner: TComponent); override;
  published
    { Déclarations publiées }
    Property AdresseMail: TAdresseMail read FAdresseMail write SetAdresseMail;
    Property SujetMail: TSujetMail read FSujetMail write SetSujetMail;
    Property OnClick: TNotifyEvent read FOnClick write FOnClick;
    Property OnMailClick: TNotifyEvent read FOnMailClick write FOnMailClick;
  end;


implementation

Constructor TMailContactLabel.Create(Aowner: TComponent);
begin
  InHerited Create(AOwner);
  Font.Color := clBlue;
  Font.Style := [fsUnderline];
  Cursor := CrHandPoint;
  AdresseMail := '';
  SujetMail := '';
  InHerited Caption := 'E-Mail';
  InHerited OnClick := MailClick;
end;

Procedure TMailContactLabel.SetAdresseMail(AdresseMail: TAdresseMail);
begin
  FAdresseMail := AdresseMail;
end;

Procedure TMailContactLabel.SetSujetMail(SujetMail: TSujetMail);
begin
  FSujetMail := SujetMail;
end;

Procedure TMailContactLabel.MailClick(Sender: TObject);
begin
 {using ShellExcute function}
  If Assigned(FOnClick) then FOnClick(Sender);
  ShellExecute(0, nil, pchar('mailto:'+AdresseMail+'?subject='+SujetMail), '','', sw_normal);
end;


end.
