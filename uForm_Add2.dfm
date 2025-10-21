object Form_Add2: TForm_Add2
  Left = 0
  Top = 0
  Caption = #28155#21152#23450#26102#28040#24687
  ClientHeight = 364
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 13
  object cxLabel3: TcxLabel
    Left = 16
    Top = 120
    Caption = #21457#36865#23545#35937#24494#20449'ID'#65306
    TabOrder = 0
  end
  object cxLabel5: TcxLabel
    Left = 16
    Top = 168
    Caption = #22238#20449#25110#36716#21457#31867#21035#65306
    TabOrder = 1
  end
  object cxLabel6: TcxLabel
    Left = 16
    Top = 224
    Caption = #22238#20449#25110#36716#21457#20869#23481#65306
    TabOrder = 2
  end
  object cxComboBox_Kind: TcxComboBox
    Left = 120
    Top = 168
    Properties.Items.Strings = (
      #25991#26412
      #22270#29255
      #25991#20214)
    Properties.ReadOnly = False
    Properties.OnChange = cxComboBox_KindPropertiesChange
    TabOrder = 3
    Text = #25991#26412
    Width = 65
  end
  object cxTextEdit_neirong: TcxTextEdit
    Left = 120
    Top = 224
    TabOrder = 4
    Width = 145
  end
  object cxButton_Add: TcxButton
    Left = 120
    Top = 320
    Width = 81
    Height = 25
    Caption = #28155#21152
    TabOrder = 5
    OnClick = cxButton_AddClick
  end
  object cxButtonEdit_faxinID: TcxButtonEdit
    Left = 120
    Top = 120
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit_faxinIDPropertiesButtonClick
    TabOrder = 6
    Width = 137
  end
  object cxLabel2: TcxLabel
    Left = 116
    Top = 264
    AutoSize = False
    Caption = #65288#24403#20026#26089#25253#31867#21035#26102#65292#22635#20889#22478#24066#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 7
    Height = 17
    Width = 173
  end
  object cxLabel4: TcxLabel
    Left = 116
    Top = 288
    AutoSize = False
    Caption = #65288#24403#20026#22270#29255#26684#24335#26102#65292#22635#20889#22270#29255#20840#36335#24452#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 8
    Height = 17
    Width = 205
  end
  object cxLabel7: TcxLabel
    Left = 116
    Top = 192
    AutoSize = False
    Caption = '('#26684#24335#20999#25442#33267#22270#29255#26102#65292#20986#29616#36873#25321#26694#65289
    Style.TextStyle = [fsItalic]
    TabOrder = 9
    Height = 17
    Width = 193
  end
  object cxTimeEdit1: TcxTimeEdit
    Left = 80
    Top = 8
    TabOrder = 10
    Width = 113
  end
  object cxLabel9: TcxLabel
    Left = 16
    Top = 8
    Caption = #23450#26102#26102#38388#65306
    TabOrder = 11
  end
  object cxCheckGroup_RepeatDay: TcxCheckGroup
    Left = 8
    Top = 40
    Caption = #37325#22797#26085#26399#65288#19981#21246#36873#21363#20026#19981#37325#22797#65289
    Properties.Columns = 4
    Properties.Items = <
      item
        Caption = #26143#26399#19968
      end
      item
        Caption = #26143#26399#20108
      end
      item
        Caption = #26143#26399#19977
      end
      item
        Caption = #26143#26399#22235
      end
      item
        Caption = #26143#26399#20116
      end
      item
        Caption = #26143#26399#20845
      end
      item
        Caption = #26143#26399#22825
      end>
    TabOrder = 12
    Height = 57
    Width = 393
  end
end
