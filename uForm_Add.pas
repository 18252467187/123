unit uForm_Add;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxButtonEdit, cxSpinEdit, dxUIAClasses,
  dxCoreGraphics;

type
  TForm_Add = class(TForm)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxComboBox_Kind: TcxComboBox;
    cxTextEdit_neirong: TcxTextEdit;
    cxTextEdit_KW: TcxTextEdit;
    cxButton_Add: TcxButton;
    cxLabel7: TcxLabel;
    cxButtonEdit_showxinID: TcxButtonEdit;
    cxButtonEdit_faxinID: TcxButtonEdit;
    cxLabel8: TcxLabel;
    cxSpinEdit_Delay: TcxSpinEdit;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    procedure cxButton_AddClick(Sender: TObject);
    procedure cxButtonEdit_showxinIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxButtonEdit_faxinIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxComboBox_KindPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  uForm_AI, udm, uForm_Select;

procedure TForm_Add.cxButtonEdit_faxinIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  form: TForm_Select;
begin
  form := TForm_Select.Create(nil);
  try
    if form.ShowModal = 1 then
    begin
      cxButtonEdit_faxinID.Text := wx_ID;
    end;
  finally
    form.Free;
  end;

end;

procedure TForm_Add.cxButtonEdit_showxinIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  form: TForm_Select;
begin
  form := TForm_Select.Create(nil);
  try
    if form.ShowModal = 1 then
    begin
      cxButtonEdit_showxinID.Text := wx_ID;
    end;
  finally
    form.Free;
  end;
end;

procedure TForm_Add.cxButton_AddClick(Sender: TObject);
begin
  showxinID := cxButtonEdit_showxinID.Text;
  faxinID := cxButtonEdit_faxinID.Text;
  huifuneirong := cxTextEdit_neirong.Text;
  faxinKind := cxComboBox_Kind.Text;
  kw := cxTextEdit_KW.Text;
  delay := cxSpinEdit_Delay.Value;
  ModalResult := 1;
end;

procedure TForm_Add.cxComboBox_KindPropertiesChange(Sender: TObject);
var
  opendlg: TOpenDialog;
begin
  if cxComboBox_Kind.Text = '图片' then
  begin
    opendlg := TOpenDialog.Create(nil);
    try
      opendlg.Title := '选择所需发送图片';
      opendlg.Filter := '图片文件(*.png;*.jpg;*.jpeg;*.bmp;*.gif)|*.png;*.jpg;*.jpeg;*.bmp;*.gif|全部文件(*.*)|*.*';
      if opendlg.Execute then
      begin
        cxTextEdit_neirong.Text := opendlg.FileName;
      end
      else
      begin
        cxComboBox_Kind.Text := '文本';
      end;
    finally
      FreeAndNil(opendlg);
    end;
  end;
end;

end.

