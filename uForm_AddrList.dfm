object Form_Addrlist: TForm_Addrlist
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = #36890#35759#24405
  ClientHeight = 785
  ClientWidth = 1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 1082
    Height = 785
    Align = alClient
    TabOrder = 0
    LevelTabs.Style = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = DM.DataSource_AddrList
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1wxid: TcxGridDBColumn
        Caption = #24494#20449'ID'
        DataBinding.FieldName = 'wxid'
        Width = 161
      end
      object cxGrid1DBTableView1nickname: TcxGridDBColumn
        Caption = #26165#31216
        DataBinding.FieldName = 'nickname'
        Width = 145
      end
      object cxGrid1DBTableView1remark: TcxGridDBColumn
        Caption = #22791#27880
        DataBinding.FieldName = 'remark'
        Width = 154
      end
      object cxGrid1DBTableView1customAccount: TcxGridDBColumn
        Caption = #24494#20449#21495
        DataBinding.FieldName = 'customAccount'
        Width = 190
      end
      object cxGrid1DBTableView1kind: TcxGridDBColumn
        Caption = #31867#21035
        DataBinding.FieldName = 'kind'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      Caption = #32852#31995#20154
      GridView = cxGrid1DBTableView1
    end
  end
end
