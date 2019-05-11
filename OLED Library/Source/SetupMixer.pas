{ ============================================
  Software Name : 	383ToolKit
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit SetupMixer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Mixer, MixerCtl;

type
  // TComPort setup dialog
  TFrmSetupMixer = class(TForm)
    GrpBoxPram: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GrBoxControle: TGroupBox;
    ShapCercle: TShape;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Combo1: TComComboMixer;
  Combo2: TComComboMixer;
  Combo3: TComComboMixer;
  Combo4: TComComboMixer;
  Combo5: TComComboMixer;
  Combo6: TComComboMixer;

procedure EditComMixer(MixerCp383: TCustomComMixer);

implementation

{$R *.DFM}

// show setup dialog
procedure EditComMixer(MixerCp383: TCustomComMixer);
begin
  with TFrmSetupMixer.Create(nil) do
  begin
    Combo1 := TComComboMixer.Create(nil);
    Combo1.Parent := GrpBoxPram;
    Combo1.top := 17;
    Combo1.left := 80;
    Combo1.Width := 120;
    Combo2 := TComComboMixer.Create(nil);
    Combo2.Parent := GrpBoxPram;
    Combo2.top := 41;
    Combo2.left := 80;
    Combo2.Width := 120;
    Combo3 := TComComboMixer.Create(nil);
    Combo3.Parent := GrpBoxPram;
    Combo3.top := 65;
    Combo3.left := 80;
    Combo3.Width := 120;
    Combo4 := TComComboMixer.Create(nil);
    Combo4.Parent := GrpBoxPram;
    Combo4.top := 88;
    Combo4.left := 80;
    Combo4.Width := 120;
    Combo5 := TComComboMixer.Create(nil);
    Combo5.Parent := GrpBoxPram;
    Combo5.top := 112;
    Combo5.left := 80;
    Combo5.Width := 120;
    Combo6 := TComComboMixer.Create(nil);
    Combo6.Parent := GrpBoxPram;
    Combo6.top := 136;
    Combo6.left := 80;
    Combo6.Width := 120;
    Combo1.ComPort := MixerCp383;
    Combo2.ComPort := MixerCp383;
    Combo3.ComPort := MixerCp383;
    Combo4.ComPort := MixerCp383;
    Combo5.ComPort := MixerCp383;
    Combo6.ComPort := MixerCp383;
    Combo1.updatesettings;
    Combo2.updatesettings;
    Combo3.updatesettings;
    Combo4.updatesettings;
    Combo5.updatesettings;
    Combo6.updatesettings;
    if ShowModal = mrOK then
    begin
      MixerCp383.BeginUpdate;
      Combo1.ApplySettings;
      Combo2.ApplySettings;
      Combo3.ApplySettings;
      Combo4.ApplySettings;
      Combo5.ApplySettings;
      Combo6.ApplySettings;
      MixerCp383.EndUpdate;

    end;
    Combo1.Free;
    Combo2.Free;
    Combo3.Free;
    Combo4.Free;
    Combo5.Free;
    Combo6.Free;
    Free;
  end;
end;

end.
