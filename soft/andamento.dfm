object frmanda: Tfrmanda
  Left = 223
  Top = 190
  Width = 465
  Height = 251
  Caption = 'Registra Andamento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 441
    Height = 205
    Caption = 'Andamentos'
    TabOrder = 0
    object Label8: TLabel
      Left = 8
      Top = 24
      Width = 23
      Height = 13
      Caption = 'Data'
      FocusControl = DBEdatamov
    end
    object Label9: TLabel
      Left = 96
      Top = 24
      Width = 23
      Height = 13
      Caption = 'Hora'
      FocusControl = DBEhora
    end
    object Label10: TLabel
      Left = 176
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Local'
    end
    object DBEdatamov: TDBEdit
      Left = 8
      Top = 40
      Width = 65
      Height = 21
      DataField = 'DATA'
      MaxLength = 10
      TabOrder = 0
    end
    object DBEhora: TDBEdit
      Left = 96
      Top = 40
      Width = 57
      Height = 21
      DataField = 'HORA'
      MaxLength = 5
      TabOrder = 1
    end
    object DBGanda: TDBGrid
      Left = 8
      Top = 72
      Width = 425
      Height = 113
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Local'
          Width = 258
          Visible = True
        end>
    end
    object DBClocal: TDBComboBox
      Left = 176
      Top = 39
      Width = 257
      Height = 21
      DataField = 'Local'
      ItemHeight = 13
      Items.Strings = (
        '01-Protocolo'
        '02-Arquivo'
        '03-Setor de Benef'#237'cios'
        '04-Diretoria de Previd'#234'ncia'
        '05-Diretoria Adm. e Finan.'
        '06-Tesouraria'
        '07-Assessoria Jur'#237'dica'
        '08-Presid'#234'ncia'
        '09-Recursos Materiais'
        '10-PMA-DP '
        '11-PMA-PGM'
        '12-Consult'#226'nia')
      TabOrder = 3
    end
  end
end
