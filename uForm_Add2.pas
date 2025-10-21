unit uForm_Add2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.Menus, cxSpinEdit, cxTimeEdit,
  cxButtonEdit, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLabel, cxCheckBox, cxGroupBox, cxCheckGroup, dxUIAClasses, dxCoreGraphics;

type
  TForm_Add2 = class(TForm)
    cxLabel3: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxComboBox_Kind: TcxComboBox;
    cxTextEdit_neirong: TcxTextEdit;
    cxButton_Add: TcxButton;
    cxButtonEdit_faxinID: TcxButtonEdit;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel7: TcxLabel;
    cxTimeEdit1: TcxTimeEdit;
    cxLabel9: TcxLabel;
    cxCheckGroup_RepeatDay: TcxCheckGroup;
    procedure cxButtonEdit_faxinIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxButton_AddClick(Sender: TObject);
    procedure cxComboBox_KindPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uForm_Select, uForm_AI, DateUtils;
{$R *.dfm}

procedure TForm_Add2.cxButtonEdit_faxinIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
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

procedure TForm_Add2.cxButton_AddClick(Sender: TObject);
var
  I: Integer;
var
  StrWeek: string;
begin

  faxinID := cxButtonEdit_faxinID.Text;
  faxinKind := cxComboBox_Kind.Text;
  huifuneirong := cxTextEdit_neirong.Text;
  ModalResult := 1;
  repeat1 := False;
  StrWeek := '';
  for I := 0 to cxCheckGroup_RepeatDay.Properties.Items.Count - 1 do
  begin
    if cxCheckGroup_RepeatDay.States[I] = cbsChecked then
    begin
      repeat1 := True;
      StrWeek := StrWeek + IntToStr(I + 1) + ',';
    end;
  end;

  if repeat1 then
  begin
    //删除最后的，号
    Delete(StrWeek, Length(StrWeek), 1);
  end
  else
  begin
    StrWeek := '*';
  end;

  StrCron := IntToStr(SecondOf(cxTimeEdit1.Time)) + ' ' + IntToStr(MinuteOf(cxTimeEdit1.Time)) + ' ' + IntToStr(HourOf(cxTimeEdit1.Time)) + ' * * ' + StrWeek;

end;

procedure TForm_Add2.cxComboBox_KindPropertiesChange(Sender: TObject);
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

procedure TForm_Add2.FormShow(Sender: TObject);
begin
  cxTimeEdit1.Time := Now;
end;

end.

