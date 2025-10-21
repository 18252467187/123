object Form_Add: TForm_Add
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #28155#21152#26234#33021#22238#22797
  ClientHeight = 386
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object cxLabel1: TcxLabel
    Left = 24
    Top = 32
    Caption = #28040#24687#23545#35937#24494#20449'ID'#65306
    TabOrder = 0
  end
  object cxLabel2: TcxLabel
    Left = 24
    Top = 80
    Caption = #28040#24687#20851#38190#35789#65288#25903#25345#27491#21017#65289#65306
    TabOrder = 1
  end
  object cxLabel3: TcxLabel
    Left = 32
    Top = 136
    Caption = #21457#36865#23545#35937#24494#20449'ID'#65306
    TabOrder = 2
  end
  object cxLabel4: TcxLabel
    Left = 24
    Top = 168
    AutoSize = False
    Caption = #65288#19982#28040#24687#23545#35937'ID'#19968#33268#65292#21017#20026#22238#22797#65292#19981#19968#33268#21017#20026#36716#21457#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 3
    Height = 17
    Width = 279
  end
  object cxLabel5: TcxLabel
    Left = 32
    Top = 216
    Caption = #22238#20449#25110#36716#21457#31867#21035#65306
    TabOrder = 4
  end
  object cxLabel6: TcxLabel
    Left = 32
    Top = 264
    Caption = #22238#20449#25110#36716#21457#20869#23481#65306
    TabOrder = 5
  end
  object cxComboBox_Kind: TcxComboBox
    Left = 176
    Top = 216
    Properties.Items.Strings = (
      #25991#26412
      #22270#29255
      #25991#20214
      #35745#27425)
    Properties.ReadOnly = False
    Properties.OnChange = cxComboBox_KindPropertiesChange
    TabOrder = 6
    Text = #25991#26412
    Width = 65
  end
  object cxTextEdit_neirong: TcxTextEdit
    Left = 176
    Top = 264
    TabOrder = 7
    Width = 209
  end
  object cxTextEdit_KW: TcxTextEdit
    Left = 176
    Top = 80
    TabOrder = 8
    Width = 209
  end
  object cxButton_Add: TcxButton
    Left = 296
    Top = 344
    Width = 81
    Height = 25
    Caption = #28155#21152
    TabOrder = 9
    OnClick = cxButton_AddClick
  end
  object cxLabel7: TcxLabel
    Left = 176
    Top = 240
    AutoSize = False
    Caption = '('#26684#24335#20999#25442#33267#22270#29255#26102#65292#20986#29616#36873#25321#26694#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 10
    Height = 17
    Width = 193
  end
  object cxButtonEdit_showxinID: TcxButtonEdit
    Left = 176
    Top = 32
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit_showxinIDPropertiesButtonClick
    TabOrder = 11
    Width = 209
  end
  object cxButtonEdit_faxinID: TcxButtonEdit
    Left = 176
    Top = 136
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit_faxinIDPropertiesButtonClick
    TabOrder = 12
    Width = 209
  end
  object cxLabel8: TcxLabel
    Left = 88
    Top = 344
    Caption = #24310#26102#65306
    TabOrder = 13
  end
  object cxSpinEdit_Delay: TcxSpinEdit
    Left = 176
    Top = 344
    TabOrder = 14
    Width = 49
  end
  object cxLabel9: TcxLabel
    Left = 248
    Top = 336
    Caption = #31186
    TabOrder = 15
  end
  object cxLabel10: TcxLabel
    Left = 172
    Top = 288
    AutoSize = False
    Caption = #65288#24403#20026#26089#25253#31867#21035#26102#65292#22635#20889#22478#24066#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 16
    Height = 17
    Width = 173
  end
  object cxLabel11: TcxLabel
    Left = 164
    Top = 304
    AutoSize = False
    Caption = #65288#24403#20026#22270#29255#26684#24335#26102#65292#22635#20889#22270#29255#20840#36335#24452#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 17
    Height = 17
    Width = 205
  end
end
