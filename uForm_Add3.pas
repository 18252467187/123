unit uForm_Add3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  dxUIAClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxLabel, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, dxCoreGraphics, cxButtonEdit;

type
  TForm_Add3 = class(TForm)
    组名: TcxLabel;
    微信ID: TcxLabel;
    cxButton_OK: TcxButton;
    cxComboBox_zu: TcxComboBox;
    cxButtonEdit_WXID: TcxButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure cxButton_OKClick(Sender: TObject);
    procedure cxButtonEdit_WXIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Add3: TForm_Add3;

implementation

uses
  uDM, uForm_Select;
{$R *.dfm}

procedure TForm_Add3.cxButtonEdit_WXIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  form: TForm_Select;
begin
  form := TForm_Select.Create(nil);
  try
    if form.ShowModal = 1 then
    begin
      cxButtonEdit_WXID.Text := wx_ID;
    end;
  finally
    form.Free;
  end;
end;

procedure TForm_Add3.cxButton_OKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TForm_Add3.FormCreate(Sender: TObject);
begin
  DM.FDQuery_ZU.Open('SELECT DISTINCT 组名 FROM zu ORDER BY 组名');
  DM.FDQuery_ZU.First;
  while not DM.FDQuery_ZU.Eof do
  begin
    cxComboBox_zu.Properties.Items.Add(DM.FDQuery_ZU.FieldByName('组名').AsString);
    DM.FDQuery_ZU.Next;
  end;

end;

initialization

finalization

end.

