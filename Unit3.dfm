object Form3: TForm3
  Left = 0
  Top = 0
  Caption = #22270#20687#30446#26631#23450#20301#36719#20214
  ClientHeight = 745
  ClientWidth = 1366
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 85
    Top = 154
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 24
    Top = 154
    Width = 48
    Height = 13
    Caption = #24403#21069#22352#26631
  end
  object Button1: TButton
    Left = 264
    Top = 8
    Width = 185
    Height = 25
    Caption = #19978#19968#20010#28857#37325#32472'  ('#24555#25463#38190'a)'
    TabOrder = 0
    OnClick = Button1Click
    OnKeyPress = FormKeyPress
  end
  object RadioButton1: TRadioButton
    Left = 24
    Top = 99
    Width = 153
    Height = 17
    Caption = #24038#38190#32472#21046#26032#28857','#21491#38190#35843#25972
    Checked = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 24
    Top = 117
    Width = 153
    Height = 17
    Caption = #21491#38190#32472#21046#26032#28857','#24038#38190#35843#25972
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 24
    Top = 39
    Width = 178
    Height = 21
    TabOrder = 3
  end
  object Button2: TButton
    Left = 24
    Top = 8
    Width = 101
    Height = 25
    Caption = #36873#25321#22270#29255#25991#20214#22841
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 480
    Top = 8
    Width = 201
    Height = 25
    Caption = #32472#21046#19979#19968#20010#23545#35937'  ('#24555#25463#38190#40736#26631#20013#38190')'
    TabOrder = 5
    OnClick = Button3Click
  end
  object FileListBox1: TFileListBox
    Left = 24
    Top = 272
    Width = 178
    Height = 409
    FileEdit = Edit2
    ItemHeight = 13
    Mask = '*'
    TabOrder = 6
    OnChange = FileListBox1Change
  end
  object Edit2: TEdit
    Left = 24
    Top = 237
    Width = 178
    Height = 21
    TabOrder = 7
    Text = '*'
  end
  object ScrollBox1: TScrollBox
    Left = 232
    Top = 66
    Width = 1129
    Height = 641
    TabOrder = 8
    object Image1: TImage
      Left = 86
      Top = 78
      Width = 256
      Height = 256
      AutoSize = True
      Center = True
      OnMouseDown = Image1MouseDown
    end
    object PaintBox1: TPaintBox
      Left = 566
      Top = 184
      Width = 90
      Height = 80
      OnMouseDown = Image1MouseDown
    end
  end
  object Button4: TButton
    Left = 127
    Top = 187
    Width = 75
    Height = 25
    Caption = #26816#39564#24050#32472#28857
    TabOrder = 9
    OnClick = Button4Click
  end
end
