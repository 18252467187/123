object Form_JICI: TForm_JICI
  Left = 0
  Top = 0
  Caption = #35745#27425#26126#32454
  ClientHeight = 445
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 444
    Height = 445
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 416
    ExplicitTop = 320
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = DM.DataSource_JICI
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1ID: TcxGridDBColumn
        DataBinding.FieldName = #32452#21592'ID'
        Width = 110
      end
      object cxGrid1DBTableView1nickname: TcxGridDBColumn
        Caption = #36890#35759#24405#21517#31216
        DataBinding.FieldName = 'nickname'
        Width = 143
      end
      object cxGrid1DBTableView1DBColumn: TcxGridDBColumn
        DataBinding.FieldName = #27425#25968
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
end
