unit uForm_AI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridLevel, cxGrid, Vcl.Grids, Vcl.DBGrids, dxBarBuiltInMenu, cxPC,
  Vcl.ComCtrls, cxContainer, cxListView, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxGroupBox, cxPropertiesStore, cxTextEdit, Vcl.ExtCtrls, QWorker, dxUIAClasses,
  dxScrollbarAnnotations, FireDAC.Comp.DataSet, System.Generics.Collections;

type
  TForm_AI = class(TForm)
    cxPageControl_Main: TcxPageControl;
    �ظ���ת��: TcxTabSheet;
    ��ʱ��Ϣ: TcxTabSheet;
    cxGroupBox_Top: TcxGroupBox;
    cxButton_Add: TcxButton;
    cxButton_Delete: TcxButton;
    cxButton_Edit: TcxButton;
    Timer_Time: TTimer;
    cxGroupBox_Top2: TcxGroupBox;
    cxButton_Add2: TcxButton;
    cxButton_Delete2: TcxButton;
    cxButton_Edit2: TcxButton;
    cxGrid_huifuDBTableView1: TcxGridDBTableView;
    cxGrid_huifuLevel1: TcxGridLevel;
    cxGrid_huifu: TcxGrid;
    cxGrid_TimeDBTableView1: TcxGridDBTableView;
    cxGrid_TimeLevel1: TcxGridLevel;
    cxGrid_Time: TcxGrid;
    PopupMenu_Time: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    cxGrid_huifuDBTableView1id: TcxGridDBColumn;
    cxGrid_huifuDBTableView1ID1: TcxGridDBColumn;
    cxGrid_huifuDBTableView1DBColumn: TcxGridDBColumn;
    cxGrid_huifuDBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid_huifuDBTableView1DBColumn2: TcxGridDBColumn;
    cxGrid_huifuDBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid_huifuDBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid_TimeDBTableView1id: TcxGridDBColumn;
    cxGrid_TimeDBTableView1DBColumn: TcxGridDBColumn;
    cxGrid_TimeDBTableView1ID1: TcxGridDBColumn;
    cxGrid_TimeDBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid_TimeDBTableView1DBColumn2: TcxGridDBColumn;
    cxGrid_TimeDBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid_TimeDBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid_TimeDBTableView1DBColumn5: TcxGridDBColumn;
    ��������: TcxTabSheet;
    cxGrid_GroupDBTableView1: TcxGridDBTableView;
    cxGrid_GroupLevel1: TcxGridLevel;
    cxGrid_Group: TcxGrid;
    cxGrid_GroupDBTableView1id: TcxGridDBColumn;
    cxGrid_GroupDBTableView1DBColumn: TcxGridDBColumn;
    cxGrid_GroupDBTableView1ID1: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxButton_Add3: TcxButton;
    cxButton_delete3: TcxButton;
    cxButton_jici: TcxButton;
    procedure cxButton_AddClick(Sender: TObject);
    procedure cxButton_EditClick(Sender: TObject);
    procedure cxButton_DeleteClick(Sender: TObject);
    procedure cxButton_Add2Click(Sender: TObject);
    procedure cxButton_Edit2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGrid_huifuDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure cxButton_Delete2Click(Sender: TObject);
    procedure cxGrid_TimeDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure Timer_TimeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButton_Add3Click(Sender: TObject);
    procedure cxButton_delete3Click(Sender: TObject);
    procedure cxButton_jiciClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_AI: TForm_AI;
  showxinID, faxinID, huifuneirong, KW, faxinKind, StrCron: string;
  repeat1: Boolean;
  delay: Integer;
  FGroupDic: TDictionary<string, TStringList>;

implementation

uses
  System.RegularExpressions, uForm_add, uForm_Add2, uWeChat, uDM, uForm_Main,
  uWXAPI, uForm_Add3, uForm_JICI;

{$R *.dfm}
procedure GroupDicCliear;
var
  temp: string;
begin
  for temp in FGroupDic.Keys do
  begin
    FGroupDic[temp].Free;
  end;
  FGroupDic.Clear;
end;

procedure TForm_AI.cxButton_Add2Click(Sender: TObject);
var
  form: TForm_add2;
const
  StrInsert = 'INSERT INTO Time(�Ƿ�����,����ID,���,����,��ʱʱ��,�Ƿ��ظ�,��ע) VALUES(:�Ƿ�����,:����ID,:���,:����,:�Ƿ��ظ�,:��ʱʱ��,:��ע)';
begin

  form := TForm_Add2.Create(nil);
  try
    if form.ShowModal = 1 then
    begin
      System.TMonitor.Enter(dm);
      try
        DM.FDConnection1.ExecSQL(StrInsert, [False, faxinID, faxinKind, huifuneirong, StrCron, repeat1, '']);
        DM.FDQuery_Time.Open('select * from time');
      finally
        System.TMonitor.Exit(dm);
      end;
    end;
  finally
    FreeAndNil(form);
  end;

end;

procedure TForm_AI.cxButton_Add3Click(Sender: TObject);
var
  form: TForm_add3;
  sl: TStringList;
  zuName, wxid: string;
const
  StrInsert = 'INSERT INTO zu(����, ��ԱID) VALUES(:����, :��ԱID)';
begin
  form := TForm_Add3.Create(nil);
  try
    if form.ShowModal = 1 then
    begin
      System.TMonitor.Enter(dm);
      try
        zuName := form.cxComboBox_zu.Text;
        wxid := form.cxButtonEdit_WXID.Text;
        dm.FDConnection1.ExecSQL(StrInsert, [zuName, wxid]);
        DM.FDQuery_group.Open('select * from zu');
        if not FGroupDic.ContainsKey(zuName) then
        begin
          sl := TStringList.Create;
          FGroupDic.Add(zuName, sl);
        end;
        if not FGroupDic[zuName].Contains(wxid) then
        begin
          FGroupDic[zuName].Add(wxid);
        end;

      finally
        System.TMonitor.Exit(dm);
      end;
    end;
  finally
    FreeAndNil(form);
  end;
end;

procedure TForm_AI.cxButton_AddClick(Sender: TObject);
var
  form: TForm_add;
  lastid: Largeint;
const
  StrInsert = 'INSERT INTO Huifu(����ID, ��������, ���Ŷ��� , �������� ,��������,������ʱ) VALUES(:����ID, :��������, :���Ŷ��� , :�������� ,:��������,:������ʱ)';
begin

  form := TForm_Add.Create(nil);
  try
    if form.ShowModal = 1 then
    begin
      System.TMonitor.Enter(dm);
      try
        dm.FDConnection1.ExecSQL(StrInsert, [showxinID, kw, faxinID, faxinKind, huifuneirong, delay]);
        lastid := dm.FDConnection1.ExecSQLScalar('SELECT last_insert_rowid()');
        DM.FDQuery_Huifu.Open('select * from huifu');
        DM.FDMemTable_Huifu.CopyDataSet(dm.FDQuery_Huifu, [coStructure, coRestart, coAppend]);
      finally
        System.TMonitor.Exit(dm);
      end;
    end;
  finally
    FreeAndNil(form);
  end;

end;

procedure TForm_AI.cxButton_Delete2Click(Sender: TObject);
var
  i: Integer;
  id: Integer;
  temph: Integer;
  astate: TQJobState;
const
  StrDel = 'DELETE FROM Time WHERE id=:id';
  StrUpdate = 'UPDATE Time SET ��ע=:��ע WHERE id=:id';
begin
  System.TMonitor.Enter(dm);
  try
    i := cxGrid_TimeDBTableView1.Controller.SelectedRows[0].RecordIndex;
    id := cxGrid_TimeDBTableView1.DataController.Values[i, 0];
    if cxGrid_TimeDBTableView1.DataController.Values[i, 7] <> '' then
    begin
      temph := StrToInt(cxGrid_TimeDBTableView1.DataController.Values[i, 7]);
      Workers.ClearSingleJob(temph, True);
      if not Workers.PeekJobState(temph, astate) then
      begin
        DM.FDConnection1.ExecSQL(StrUpdate, ['', id]);
        Form_Main.DspMsg('��ʱ����id:' + IntToStr(id) + ' ��ͣ��');
        DM.FDQuery_Time.Open('select * from Time');
      end;
    end;
    DM.FDConnection1.ExecSQL(StrDel, [id]);
    DM.FDQuery_Time.Open('select * from time');
  finally
    System.TMonitor.Exit(dm);
  end;
end;

procedure TForm_AI.cxButton_delete3Click(Sender: TObject);
var
  i: Integer;
  id: Integer;
  zuName, wxid: string;
begin
  System.TMonitor.Enter(dm);
  try
    i := cxGrid_GroupDBTableView1.Controller.SelectedRows[0].RecordIndex;
    id := cxGrid_GroupDBTableView1.DataController.Values[i, 0];
    zuName := cxGrid_GroupDBTableView1.DataController.Values[i, 1];
    wxid := cxGrid_GroupDBTableView1.DataController.Values[i, 2];
    DM.FDConnection1.ExecSQL('DELETE FROM zu WHERE id=:id', [id]);
    DM.FDQuery_group.Open('select * from zu');
    if FGroupDic.ContainsKey(zuName) then
    begin
      if FGroupDic[zuName].Contains(wxid) then
      begin
        FGroupDic[zuName].Delete(FGroupDic[zuName].IndexOf(wxid));
      end;
      if FGroupDic[zuName].Count = 0 then
      begin
        FGroupDic.Remove(zuName);
      end;
    end;
  finally
    System.TMonitor.Exit(dm);
  end;
end;

procedure TForm_AI.cxButton_DeleteClick(Sender: TObject);
var
  i: Integer;
  id: Integer;
begin
  System.TMonitor.Enter(dm);
  try
    i := cxGrid_huifuDBTableView1.Controller.SelectedRows[0].RecordIndex;
    id := cxGrid_huifuDBTableView1.DataController.Values[i, 0];
    DM.FDConnection1.ExecSQL('DELETE FROM Huifu WHERE id=:id', [id]);
    DM.FDQuery_Huifu.Open('select * from Huifu');
    DM.FDMemTable_Huifu.CopyDataSet(dm.FDQuery_Huifu, [coStructure, coRestart, coAppend]);
  finally
    System.TMonitor.Exit(dm);
  end;
end;

procedure TForm_AI.cxButton_Edit2Click(Sender: TObject);  //������ ���ñ���ͣ����
var
  form: TForm_add2;
  i, id: Integer;
  temps: string;
  match: TMatch;
const
  StrUpdate = 'UPDATE Time SET �Ƿ�����=:�Ƿ�����,����ID=:����ID,���=:���,����=:����,��ʱʱ��=:��ʱʱ��,�Ƿ��ظ�=:�Ƿ��ظ� WHERE id=:id';
begin
  i := cxGrid_TimeDBTableView1.DataController.FocusedRecordIndex;
  id := cxGrid_TimeDBTableView1.DataController.Values[i, 0];
  form := TForm_Add2.Create(nil);
  try
    form.Caption := '�޸Ķ�ʱ��Ϣ';
    form.cxButton_Add.Caption := '�޸�';
    form.cxButtonEdit_faxinID.Text := cxGrid_TimeDBTableView1.DataController.Values[i, 2];
    form.cxComboBox_Kind.Text := cxGrid_TimeDBTableView1.DataController.Values[i, 3];
    form.cxTextEdit_neirong.Text := cxGrid_TimeDBTableView1.DataController.Values[i, 4];
    //����corn���ʽ
    match := TRegEx.Match(cxGrid_TimeDBTableView1.DataController.Values[i, 5], '.*? .*? .*? \* \* (.*)');
    temps := match.Groups[1].Value;
    if TRegEx.IsMatch(temps, '1') then
      form.cxCheckGroup_RepeatDay.States[0] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[0] := cbsUnchecked
    end;
    if TRegEx.IsMatch(temps, '2') then
      form.cxCheckGroup_RepeatDay.States[1] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[1] := cbsUnchecked
    end;
    if TRegEx.IsMatch(temps, '3') then
      form.cxCheckGroup_RepeatDay.States[2] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[2] := cbsUnchecked
    end;
    if TRegEx.IsMatch(temps, '4') then
      form.cxCheckGroup_RepeatDay.States[3] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[3] := cbsUnchecked
    end;
    if TRegEx.IsMatch(temps, '5') then
      form.cxCheckGroup_RepeatDay.States[4] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[4] := cbsUnchecked
    end;
    if TRegEx.IsMatch(temps, '6') then
      form.cxCheckGroup_RepeatDay.States[5] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[5] := cbsUnchecked
    end;
    if TRegEx.IsMatch(temps, '7') then
      form.cxCheckGroup_RepeatDay.States[6] := cbsChecked
    else
    begin
      form.cxCheckGroup_RepeatDay.States[6] := cbsUnchecked
    end;
    if form.ShowModal = 1 then
    begin
          //������ ���ñ���ͣ����
      System.TMonitor.Enter(dm);
      try
        DM.FDConnection1.ExecSQL(StrUpdate, [False, faxinID, faxinKind, huifuneirong, StrCron, repeat1, id]);
        DM.FDQuery_Time.Open('select * from time');
      finally
        System.TMonitor.Exit(dm);
      end;
    end;
  finally
    FreeAndNil(form);
  end;
end;

procedure TForm_AI.cxButton_EditClick(Sender: TObject);
var
  form: TForm_add;
var
  i: Integer;
  id: string;
const
  StrUpdate = 'UPDATE Huifu SET ����ID=:����ID,��������=:��������,���Ŷ���=:���Ŷ���,��������=:��������,��������=:��������,������ʱ=:������ʱ  WHERE id=:id';
begin
  i := cxGrid_huifuDBTableView1.Controller.SelectedRows[0].RecordIndex;
  id := cxGrid_huifuDBTableView1.DataController.Values[i, 0];
  form := TForm_Add.Create(nil);
  try
    form.Caption := '�޸����ܻظ�';
    form.cxButton_Add.Caption := '�޸�';
    form.cxButtonEdit_showxinID.Text := cxGrid_huifuDBTableView1.DataController.Values[i, 1];
    form.cxTextEdit_KW.Text := cxGrid_huifuDBTableView1.DataController.Values[i, 2];
    form.cxButtonEdit_faxinID.Text := cxGrid_huifuDBTableView1.DataController.Values[i, 3];
    form.cxComboBox_Kind.Text := cxGrid_huifuDBTableView1.DataController.Values[i, 4];
    form.cxTextEdit_neirong.Text := cxGrid_huifuDBTableView1.DataController.Values[i, 5];
    form.cxSpinEdit_Delay.Value := cxGrid_huifuDBTableView1.DataController.Values[i, 6];
    if form.ShowModal = 1 then
    begin
      System.TMonitor.Enter(dm);
      try
        DM.FDConnection1.ExecSQL(StrUpdate, [form.cxButtonEdit_showxinID.Text, form.cxTextEdit_KW.Text, form.cxButtonEdit_faxinID.Text, form.cxComboBox_Kind.Text, form.cxTextEdit_neirong.Text, form.cxSpinEdit_Delay.Value, id]);
        DM.FDQuery_Huifu.Open('select * from Huifu');
        DM.FDMemTable_Huifu.CopyDataSet(dm.FDQuery_Huifu, [coStructure, coRestart, coAppend]);
      finally
        System.TMonitor.Exit(dm);
      end;
    end;
  finally
    FreeAndNil(form);
  end;
end;

procedure TForm_AI.cxButton_jiciClick(Sender: TObject);
const
  csql = 'SELECT ��ԱID, COUNT(*) as ���� FROM jici WHERE huifuid = :HuifuID GROUP BY ��ԱID';
var
  i: Integer;
  id: Integer;
begin
  System.TMonitor.Enter(dm);
  try
    i := cxGrid_huifuDBTableView1.Controller.SelectedRows[0].RecordIndex;
    id := cxGrid_huifuDBTableView1.DataController.Values[i, 0];
    DM.FDQuery_JICI.Close;
    DM.FDQuery_JICI.SQL.Text := csql;
    dm.FDQuery_JICI.ParamByName('HuifuID').AsInteger := id;
    dm.FDQuery_JICI.Open;
  finally
    System.TMonitor.Exit(dm);
  end;
  Form_JICI.Show;
end;

procedure TForm_AI.cxGrid_huifuDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  cxButton_Edit.Click;
end;

procedure TForm_AI.cxGrid_TimeDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  cxButton_Edit2.Click;
end;

procedure TForm_AI.FormCreate(Sender: TObject);
begin
  System.TMonitor.Enter(dm);
  try
    DM.FDConnection1.ExecSQL('update Time Set �Ƿ�����=:�Ƿ�����', [False]);
  finally
    System.TMonitor.Exit(dm);
  end;
end;

procedure TForm_AI.FormShow(Sender: TObject);
var
  zuName, wxid: string;
  sl: TStringList;
begin
  System.TMonitor.Enter(dm);
  try
    DM.FDQuery_Huifu.Open('select * from huifu');
    DM.FDQuery_Time.Open('select * from time');
    DM.FDQuery_Group.Open('select * from zu');
    DM.FDQuery_Group.First;
    while not DM.FDQuery_Group.Eof do
    begin
      zuName := DM.FDQuery_Group.FieldByName('����').AsString;
      wxid := DM.FDQuery_Group.FieldByName('��ԱID').AsString;
      if not FGroupDic.ContainsKey(zuName) then
      begin
        sl := TStringList.Create;
        FGroupDic.Add(zuName, sl);
      end;
      if not FGroupDic[zuName].Contains(wxid) then
      begin
        FGroupDic[zuName].Add(wxid);
      end;
      DM.FDQuery_Group.Next;
    end;

  finally
    System.TMonitor.Exit(dm);
  end;

end;

procedure TForm_AI.N1Click(Sender: TObject);
var
  id: Integer;
  i: Integer;
const
  StrUpdate = 'UPDATE Time SET �Ƿ�����=:�Ƿ����� WHERE id=:id';
begin
  System.TMonitor.Enter(dm);
  try
    i := cxGrid_TimeDBTableView1.DataController.FocusedRecordIndex;
    id := cxGrid_TimeDBTableView1.DataController.Values[i, 0];
    DM.FDConnection1.ExecSQL(StrUpdate, [True, id]);
    DM.FDQuery_Time.Open('select * from time');
  finally
    System.TMonitor.Exit(dm);
  end;

end;

procedure TForm_AI.N2Click(Sender: TObject);
var
  id: Integer;
  i: Integer;
const
  StrUpdate = 'UPDATE Time SET �Ƿ�����=:�Ƿ����� WHERE id=:id';
begin
  System.TMonitor.Enter(dm);
  try
    i := cxGrid_TimeDBTableView1.DataController.FocusedRecordIndex;
    id := cxGrid_TimeDBTableView1.DataController.Values[i, 0];
    DM.FDConnection1.ExecSQL(StrUpdate, [False, id]);
    DM.FDQuery_Time.Open('select * from time');
  //����Ƿ���������ʱ�߳� �������Ļ��������ʱ�߳�
  finally
    System.TMonitor.Exit(dm);
  end;

end;

procedure TForm_AI.Timer_TimeTimer(Sender: TObject);
var
  tempi, temph, I, id: Integer;
  errmsg, temps: string;
  astate: TQJobState;
  wxapi: TWXAPI;
const
  StrUpdate = 'UPDATE Time SET ��ע=:��ע WHERE id=:id';
begin
//�������ͣ���̡߳�
  System.TMonitor.Enter(dm);
  try
    for I := 0 to cxGrid_TimeDBTableView1.DataController.RecordCount - 1 do
    begin
      id := cxGrid_TimeDBTableView1.DataController.Values[I, 0];
      if cxGrid_TimeDBTableView1.DataController.Values[I, 1] then
      begin
      //��ʱ����
        if cxGrid_TimeDBTableView1.DataController.Values[I, 7] = '' then
        begin
          temph := Workers.Plan(
            procedure(ajob: pqjob)
            var
              tempid, tempwxid, tempkind, temps: string;
              tempr: Boolean;
              k: Integer;
            const
              StrUpdate = 'UPDATE Time SET �Ƿ�����=:�Ƿ����� WHERE id=:id';
            begin
            //��ʱ//������
              tempid := ajob.ExtData.Params[0];
              tempwxid := ajob.ExtData.Params[1];
              tempkind := ajob.ExtData.Params[2];
              temps := ajob.ExtData.Params[3];
              tempr := ajob.ExtData.Params[4];

              if tempkind = '�ı�' then
              begin
                wxapi := TWXAPI.Create;
                try
                  if wxapi.sendTextMsg(tempwxid, temps, errmsg) then
                  begin
                    if FaddrList.ContainsKey(tempwxid) then
                    begin
                      tempwxid := FaddrList[tempwxid];
                    end;
                    Form_Main.DspMsg('���ųɹ���' + tempwxid + '  ' + temps);
                  end
                  else
                  begin
                    Form_Main.DspMsg('����ʧ�ܣ�' + errmsg);
                  end;
                finally
                  wxapi.Free;
                end;
              end
              else if tempkind = 'ͼƬ' then
              begin
                wxapi := TWXAPI.Create;
                try
                  if wxapi.sendImagesMsg(tempwxid, temps, errmsg) then
                  begin
                    if FaddrList.ContainsKey(tempwxid) then
                    begin
                      tempwxid := FaddrList[tempwxid];
                    end;
                    Form_Main.DspMsg('��ͼ�ɹ���' + tempwxid + '  ' + temps);
                  end
                  else
                  begin
                    Form_Main.DspMsg('��ͼʧ�ܣ�' + errmsg);
                  end;
                finally
                  wxapi.Free;
                end;
              end
              else if tempkind = '�ļ�' then
              begin
                wxapi := TWXAPI.Create;
                try
                  if wxapi.sendFileMsg(tempwxid, temps, errmsg) then
                  begin
                    if FaddrList.ContainsKey(tempwxid) then
                    begin
                      tempwxid := FaddrList[tempwxid];
                    end;
                    Form_Main.DspMsg('���ļ��ɹ���' + tempwxid + '  ' + temps);
                  end
                  else
                  begin
                    Form_Main.DspMsg('���ļ�ʧ�ܣ�' + errmsg);
                  end;
                finally
                  wxapi.Free;
                end;
              end;
              if not tempr then
              begin
                DM.FDConnection1.ExecSQL(StrUpdate, [False, id]);
                DM.FDQuery_Time.Open('select * from time');
              end;

            end, cxGrid_TimeDBTableView1.DataController.Values[I, 5], TQJobExtData.Create([id, cxGrid_TimeDBTableView1.DataController.Values[I, 2], cxGrid_TimeDBTableView1.DataController.Values[I, 3], cxGrid_TimeDBTableView1.DataController.Values[I, 4], cxGrid_TimeDBTableView1.DataController.Values[I, 6]]), true, jdfFreeAsObject);
          if temph > 0 then
          begin
            DM.FDConnection1.ExecSQL(StrUpdate, [IntToStr(temph), id]);
            Form_Main.DspMsg('��ʱ����id:' + IntToStr(id) + ' ������');
            DM.FDQuery_Time.Open('select * from Time');
          end;
        end;
      end
      else
      begin
       //��ʱͣ��
        if cxGrid_TimeDBTableView1.DataController.Values[I, 7] <> '' then
        begin
          temph := StrToInt(cxGrid_TimeDBTableView1.DataController.Values[I, 7]);
          Workers.ClearSingleJob(temph, True);
          if not Workers.PeekJobState(temph, astate) then
          begin
            DM.FDConnection1.ExecSQL(StrUpdate, ['', id]);
            Form_Main.DspMsg('��ʱ����id:' + IntToStr(id) + ' ��ͣ��');
            DM.FDQuery_Time.Open('select * from Time');
          end;
        end;
      end;
    end;
  finally
    System.TMonitor.Exit(dm);
  end;
end;

initialization
  FGroupDic := TDictionary<string, TStringList>.Create;


finalization
  GroupDicCliear;
  FGroupDic.Free;

end.

