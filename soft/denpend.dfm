object FrmDenPen: TFrmDenPen
  Left = 405
  Top = 255
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio Estat'#237'stico de Den'#250'ncias'
  ClientHeight = 169
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 5
    Width = 461
    Height = 156
    Caption = 
      'Relat'#243'rio gerencial compartativo entrte den'#250'ncias recebidas e at' +
      'endidas'
    TabOrder = 0
    object Button1: TButton
      Left = 26
      Top = 105
      Width = 150
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 286
      Top = 112
      Width = 150
      Height = 25
      Caption = 'Fecha'
      TabOrder = 2
      OnClick = Button3Click
    end
    object RGselec: TRadioGroup
      Left = 18
      Top = 32
      Width = 431
      Height = 49
      Caption = 'Par'#226'metro'
      Color = clBtnFace
      Columns = 2
      Enabled = False
      Items.Strings = (
        'Op'#231#227'o 1'
        'Op'#231#227'o 2')
      ParentColor = False
      TabOrder = 0
    end
  end
end
