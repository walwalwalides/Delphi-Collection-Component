object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Demo3'
  ClientHeight = 299
  ClientWidth = 635
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ContactArrayBtn1: TContactArrayBtn
    Left = 8
    Top = 8
    Width = 195
    Height = 155
    BtnHeight = 30
    BtnWidth = 40
    Color = clAppWorkSpace
    Columns = 4
    Rows = 4
  end
  object Button1: TButton
    Left = 8
    Top = 266
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
end
