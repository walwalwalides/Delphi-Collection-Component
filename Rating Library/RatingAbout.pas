{ ============================================
  Software Name : 	Rating Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit RatingAbout;

{$I Rating.inc}

interface

uses Windows, SysUtils, Classes, vcl.Graphics, vcl.Forms, vcl.Controls, Vcl.StdCtrls,
  ShellAPI,Vcl.Dialogs,Vcl.Buttons, Vcl.ExtCtrls, acPNG;

type
  // ComPort Library about box
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    OKButton: TButton;
    Label7: TLabel;
    NewsLbl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure NewsLblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

// show about box
procedure ShowAbout;

const
  RatingLibraryVersion = '1.00';

implementation

{$R *.DFM}

procedure ShowAbout;
begin
  with TAboutBox.Create(nil) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  Version.Caption := 'Version ' + RatingLibraryVersion;
end;

procedure TAboutBox.NewsLblClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS }
  if ShellExecute(0, 'open', 'https://github.com/walwalwalides', '', '',
    SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start web browser');
{$ENDIF MSWINDOWS }
{$IFDEF LINUX }
  try
    StartBrowser('https://github.com/walwalwalides');
  except
    on ECannotStartBrowser do
      ShowMessage('Unable to start web browser');
  end;
{$ENDIF LINUX }
  NewsLbl.Font.Color := clNavy;
end;

end.

