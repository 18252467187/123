object Form_Select: TForm_Select
  Left = 0
  Top = 0
  Caption = #21452#20987#36873#25321
  ClientHeight = 515
  ClientWidth = 828
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 828
    Height = 515
    Align = alClient
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCellDblClick = cxGrid1DBTableView1CellDblClick
      DataController.DataSource = DM.DataSource_AddrList
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1wxid: TcxGridDBColumn
        Caption = #24494#20449'ID'
        DataBinding.FieldName = 'wxid'
        Width = 139
      end
      object cxGrid1DBTableView1nickname: TcxGridDBColumn
        Caption = #24494#20449#26165#31216
        DataBinding.FieldName = 'nickname'
        Width = 164
      end
      object cxGrid1DBTableView1remark: TcxGridDBColumn
        Caption = #22791#27880
        DataBinding.FieldName = 'remark'
        Width = 159
      end
      object cxGrid1DBTableView1customAccount: TcxGridDBColumn
        Caption = #24494#20449#21495
        DataBinding.FieldName = 'customAccount'
        Width = 140
      end
      object cxGrid1DBTableView1kind: TcxGridDBColumn
        Caption = #36134#21495#31867#21035
        DataBinding.FieldName = 'kind'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
end
