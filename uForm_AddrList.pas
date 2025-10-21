unit uForm_AddrList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  dxUIAClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, uDM;

type
  TForm_Addrlist = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1wxid: TcxGridDBColumn;
    cxGrid1DBTableView1nickname: TcxGridDBColumn;
    cxGrid1DBTableView1remark: TcxGridDBColumn;
    cxGrid1DBTableView1customAccount: TcxGridDBColumn;
    cxGrid1DBTableView1kind: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Addrlist: TForm_Addrlist;

implementation

{$R *.dfm}

end.

