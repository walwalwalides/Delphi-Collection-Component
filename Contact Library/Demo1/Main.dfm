object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Demo1'
  ClientHeight = 345
  ClientWidth = 624
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MailContactLabel1: TMailContactLabel
    Left = 210
    Top = 33
    Width = 28
    Height = 16
    Cursor = crHandPoint
    Caption = 'E-Mail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblContact: TLabel
    Left = 8
    Top = 33
    Width = 188
    Height = 13
    Caption = 'U Can Contact Me On This Email   :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
end
