unit uForm_Select;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxContainer, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxGroupBox, dxUIAClasses, dxScrollbarAnnotations;

type
  TForm_Select = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1wxid: TcxGridDBColumn;
    cxGrid1DBTableView1nickname: TcxGridDBColumn;
    cxGrid1DBTableView1remark: TcxGridDBColumn;
    cxGrid1DBTableView1customAccount: TcxGridDBColumn;
    cxGrid1DBTableView1kind: TcxGridDBColumn;
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wx_ID: string;

implementation

uses
  uDM;
{$R *.dfm}

procedure TForm_Select.cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  wx_ID := ACellViewInfo.GridRecord.Values[0];
  ModalResult := 1;
end;

end.

