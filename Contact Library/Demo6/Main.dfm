object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Demo6'
  ClientHeight = 460
  ClientWidth = 789
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    789
    460)
  PixelsPerInch = 96
  TextHeight = 13
  object lbledtPath: TLabeledEdit
    Left = 8
    Top = 185
    Width = 611
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'Path'
    TabOrder = 0
    OnChange = lbledtPathChange
  end
  object btnExecute: TButton
    Left = 625
    Top = 183
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Execute'
    Enabled = False
    TabOrder = 1
    OnClick = btnExecuteClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 212
    Width = 773
    Height = 240
    Anchors = [akLeft, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnLoad: TButton
    Left = 706
    Top = 181
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Load'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 24
    Top = 40
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 48
  end
  object OpDlg: TOpenDialog
    Left = 56
    Top = 72
  end
  object ContactReader1: TContactReader
    Left = 32
    Top = 128
  end
end
