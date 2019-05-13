unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.shHeart.Rating, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    Brush1: TBrushObject;
    lblLikeMe: TLabel;
    Button1: TButton;
    Popup1: TPopup;
    CalloutPanel1: TCalloutPanel;
    lblHeartRating: TLabel;
    Panel1: TPanel;
    RatingshHeart1: TRatingshHeart;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RatingshHeart1MouseEnter(Sender: TObject);
    procedure RatingshHeart1MouseLeave(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.Button1Click(Sender: TObject);
var
  mRect: TrectF;
  sAwnser:string;
begin
  with Canvas do
  begin

    BeginScene;
    Clear(TAlphaColors.White);
    Fill.Color := TAlphaColors.Red;
    Font.Size := 15;
    Font.Style:=[TFontStyle.fsBold];
    mRect.Create(22, 30, 250, 250);
    if (RatingshHeart1.Rating>=2.5) then
    sAwnser:=  'U love me to much !'
    else
    begin
     sAwnser:=  'U don''t love me to much !';
    end;

    FillText(mRect,sAwnser, false, 100, [], TTextAlign.taLeading, TTextAlign.taCenter);
    EndScene;

  end;
  Button1.Cursor:=crHourGlass;
  Sleep(500);
  Invalidate;
  Button1.Cursor:=crHandPoint;
end;

procedure TfrmMain.FormCreate(Sender: TObject);

begin
  frmMain.position := TFormPosition.MainFormCenter;
  Button1.Cursor:=crHandPoint;
  lblHeartRating.TextAlign:=TTextAlign.Center;
end;

procedure TfrmMain.RatingshHeart1MouseEnter(Sender: TObject);
begin
lblHeartRating.Text:=' Vote : '+ RatingshHeart1.Rating.ToString;
Popup1.IsOpen := True;
end;

procedure TfrmMain.RatingshHeart1MouseLeave(Sender: TObject);
begin
Popup1.IsOpen := False;

end;

end.
