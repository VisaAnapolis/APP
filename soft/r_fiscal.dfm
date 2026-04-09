object frmfiscal: Tfrmfiscal
  Left = 567
  Top = 383
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de OS de Requerimento por fiscal'
  ClientHeight = 202
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 5
    Width = 461
    Height = 188
    Caption = 'Gera Relat'#243'rio de Ordens de Requerimento '
    TabOrder = 0
    object BtOK: TButton
      Left = 10
      Top = 142
      Width = 150
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = BtOKClick
    end
    object Button3: TButton
      Left = 294
      Top = 141
      Width = 150
      Height = 25
      Caption = 'Fecha'
      TabOrder = 2
      OnClick = Button3Click
    end
    object GroupBox4: TGroupBox
      Left = 10
      Top = 29
      Width = 434
      Height = 100
      Caption = 'Selecione o Fiscal e o Status da OS'
      TabOrder = 0
      object CbFiscal: TComboBox
        Left = 8
        Top = 20
        Width = 417
        Height = 21
        CharCase = ecUpperCase
        Enabled = False
        ItemHeight = 13
        TabOrder = 0
        OnChange = CbFiscalChange
        Items.Strings = (
          'ACADIA DE SOUZA VIEIRA SILVA'
          'ADRIANA CRHISTINA DE REZENDE CARNEIRO'
          'ADRIANE PEREIRA GUIMAR'#195'ES'
          'ALINE CASTRO DAMASIO'
          'ANA PAULA RODRIGUES CORR'#202'A GUIMAR'#195'ES'
          'ANGELA RIBEIRO NEVES'
          'ARIANNE FERREIRA VIEIRA'
          'C'#201'SIO MALAQUIAS'
          'CL'#193'UDIO NASCIMENTO SILVA'
          'CL'#211'VIS RAFAEL BORGES FERREIRA'
          'DANIEL SOARES BARBOSA'
          'DANIELA DE ALMEIDA CASTRO'
          'EDSON ARANTES FARIA FILHO'
          'EDUARDO LUCAS MAGALH'#195'ES CASTRO'
          'FAB'#205'OLA PEDROSA PEIXOTO MARQUES'
          'GERENTE DE VIGIL'#194'NCIA SANIT'#193'RIA'
          'GERALDO EDSON ROSA'
          'GLEICIANE MARIA JOS'#201' DA SILVA'
          'G'#218'BIO DIAS PEREIRA'
          'JO'#195'O BATISTA LUCAS DA SILVA REIS'
          'JOSE LUIZ RIBEIRO'
          'JULIANA FERREIRA VITURINO'
          'JULIANA K'#202'NIA MARTINS DA SILVA'
          'JULIO C'#201'SAR TELES SPINDOLA'
          'KAMILLA CHRYSTINE ROLIM D. SANTOS GARC'#202'S'
          'LIDIANE SIM'#213'ES'
          'LIVIA BRITO'
          'LUCIANA CONSOLA'#199#195'O DOS SANTOS'
          'LUCIANA SANTANA DA ROCHA'
          'LUCIENE DE SOUZA BARBOSA GOMES SILVA'
          'MARCIO HENRIQUE GOMES RODOVALHO'
          'MARIA EDWIGES PINHEIRO DE SOUZA CHAVES'
          'MARINA PERILLO NAVARRETE LAVERS'
          'PATR'#205'CIA CORDEIRO DE MORAES E SOUZA'
          'PEDRO HENRIQUE AIRES RIBEIRO'
          'RODRIGO ALESSANDRO T'#212'GO SANTOS'
          'R'#218'BIA MARA DE FREITAS'
          'SILVIA MARQUES NAVES DA MOTA SOUZA'
          'SIMONE DUARTE GROSSI'
          'TATHIANE PESSOA DE SOUZA'
          'THIAGO GOMES GOBO'
          'VANESSA SANTANA'
          'VIVIANE MANOEL DA SILVA BORGES'
          'VIVIANE MIYADA'
          'WANESSA DE BRITO JORGE')
      end
      object CBStatus: TComboBox
        Left = 8
        Top = 60
        Width = 417
        Height = 21
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 1
        OnChange = CbFiscalChange
        Items.Strings = (
          'ATENDIDAS'
          'PENDENTES')
      end
    end
  end
end
