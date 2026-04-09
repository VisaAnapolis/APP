object frmconso: Tfrmconso
  Left = 418
  Top = 247
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Gera Relat'#243'rio Consolidado Peri'#243'dico'
  ClientHeight = 165
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 457
    Height = 145
    Caption = 'Dados para gera'#231#227'o'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 240
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object DTPini: TDateTimePicker
      Left = 16
      Top = 40
      Width = 180
      Height = 21
      CalAlignment = dtaLeft
      Date = 40716.3749362847
      Time = 40716.3749362847
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object DTFim: TDateTimePicker
      Left = 240
      Top = 40
      Width = 180
      Height = 21
      CalAlignment = dtaLeft
      Date = 40716.3749362847
      Time = 40716.3749362847
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 16
      Top = 88
      Width = 180
      Height = 25
      Caption = 'OK'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 240
      Top = 88
      Width = 180
      Height = 25
      Caption = 'Cancela'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
end
