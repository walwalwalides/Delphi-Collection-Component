object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Demo5'
  ClientHeight = 377
  ClientWidth = 755
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
  object ContactCurrency1: TContactCurrency
    Left = 8
    Top = 280
    Width = 121
    Height = 25
    AutoSize = False
    DisplayFormat = '$,0.00;($,0.00)'
    PosColor = clWindowText
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 755
    Height = 66
    Align = alBottom
    TabOrder = 1
    object ContactSmoothBtnDinar: TContactSmoothBtn
      Left = 169
      Top = 25
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Default = False
      Cancel = False
      Caption = 'Dinar'
      Color = clContact
      ImageIndex = -1
      Alignment = taCenter
      GlyphLayout = glLeft
      Flat = False
      Down = False
      AllowDown = False
      State = bsIdle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      OnClick = ContactSmoothBtnDinarClick
      ParentFont = False
      TabOrder = 0
    end
    object ContactSmoothBtnDollar: TContactSmoothBtn
      Left = 7
      Top = 25
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Default = False
      Cancel = False
      Caption = 'Dollar'
      Color = clContact
      ImageIndex = -1
      Alignment = taCenter
      GlyphLayout = glLeft
      Flat = False
      Down = False
      AllowDown = False
      State = bsIdle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      OnClick = ContactSmoothBtnDollarClick
      ParentFont = False
      TabOrder = 1
    end
    object ContactSmoothBtnEuro: TContactSmoothBtn
      Left = 88
      Top = 25
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Default = False
      Cancel = False
      Caption = 'Euro'
      Color = clContact
      ImageIndex = -1
      Alignment = taCenter
      GlyphLayout = glLeft
      Flat = False
      Down = False
      AllowDown = False
      State = bsIdle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      OnClick = ContactSmoothBtnEuroClick
      ParentFont = False
      TabOrder = 2
    end
  end
  object SpinButton1: TSpinButton
    Left = 135
    Top = 280
    Width = 20
    Height = 25
    DownGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000000000000080800000808000008080000080
      8000008080000080800000808000000000000000000000000000008080000080
      8000008080000080800000808000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    FocusControl = ContactCurrency1
    TabOrder = 2
    UpGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000080
      8000008080000080800000808000008080000000000000000000000000000080
      8000008080000080800000808000008080000080800000808000000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    OnDownClick = SpinButton1DownClick
    OnUpClick = SpinButton1UpClick
  end
end
