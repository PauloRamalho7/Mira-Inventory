object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Invent'#225'rio de PCs - MIRA'
  ClientHeight = 542
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Empresa: TLabel
    Left = 360
    Top = 77
    Width = 61
    Height = 19
    Caption = 'Empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Responsável: TLabel
    Left = 360
    Top = 158
    Width = 87
    Height = 19
    Caption = 'Respons'#225'vel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblSetor: TLabel
    Left = 360
    Top = 115
    Width = 90
    Height = 19
    Caption = 'Local (Setor)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 360
    Top = 196
    Width = 77
    Height = 19
    Caption = 'Patrim'#243'nio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblData: TLabel
    Left = 360
    Top = 24
    Width = 65
    Height = 25
    Caption = 'lblData'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 360
    Top = 235
    Width = 121
    Height = 19
    Caption = 'Patrim'#243'nio Monit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object trVw: TTreeView
    Left = 0
    Top = 0
    Width = 305
    Height = 542
    Align = alLeft
    Indent = 19
    TabOrder = 0
  end
  object edtEmpresa: TEdit
    Left = 502
    Top = 74
    Width = 147
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object rdgUnidade: TRadioGroup
    Left = 360
    Top = 279
    Width = 185
    Height = 125
    Caption = 'Unidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      'BH'
      'BETIM'
      'CONTAGEM')
    ParentFont = False
    TabOrder = 6
  end
  object edtResponsavel: TEdit
    Left = 502
    Top = 155
    Width = 147
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edtLocal: TEdit
    Left = 502
    Top = 112
    Width = 147
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtPatrimonio: TEdit
    Left = 502
    Top = 193
    Width = 147
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object btnGerar: TButton
    Left = 360
    Top = 461
    Width = 289
    Height = 41
    Caption = '&Gerar Invent'#225'rio'
    TabOrder = 7
    OnClick = btnGerarClick
  end
  object edtPatMon: TEdit
    Left = 502
    Top = 226
    Width = 147
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object XMLDocument: TXMLDocument
    Left = 672
    Top = 488
  end
end
