unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.DApt, FireDAC.Stan.StorageBin;

type
  TDM = class(TDataModule)
    FDMemTable_AddrList: TFDMemTable;
    DataSource_AddrList: TDataSource;
    FDMemTable_AddrListwxid: TWideStringField;
    FDMemTable_AddrListnickname: TWideStringField;
    FDMemTable_AddrListremark: TWideStringField;
    FDMemTable_AddrListcustomname: TWideStringField;
    FDMemTable_AddrListkind: TStringField;
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQuery_Huifu: TFDQuery;
    DataSource_Huifu: TDataSource;
    DataSource_Time: TDataSource;
    FDQuery_Time: TFDQuery;
    FDQuery_Huifuid: TFDAutoIncField;
    FDQuery_Huifu����ID: TWideStringField;
    FDQuery_Huifu��������: TWideStringField;
    FDQuery_Huifu���Ŷ���: TWideStringField;
    FDQuery_Huifu��������: TWideStringField;
    FDQuery_Huifu��������: TWideStringField;
    FDQuery_Huifu������ʱ: TIntegerField;
    FDQuery_Timeid: TFDAutoIncField;
    FDQuery_Time�Ƿ�����: TBooleanField;
    FDQuery_Time����ID: TWideStringField;
    FDQuery_Time���: TWideStringField;
    FDQuery_Time����: TWideStringField;
    FDQuery_Time��ʱʱ��: TWideStringField;
    FDQuery_Time�Ƿ��ظ�: TBooleanField;
    FDQuery_Time��ע: TWideStringField;
    FDMemTable_Huifu: TFDMemTable;
    FDMemTable_Huifuid: TFDAutoIncField;
    FDMemTable_Huifu����ID: TWideStringField;
    FDMemTable_Huifu��������: TWideStringField;
    FDMemTable_Huifu���Ŷ���: TWideStringField;
    FDMemTable_Huifu��������: TWideStringField;
    FDMemTable_Huifu��������: TWideStringField;
    FDMemTable_Huifu������ʱ: TIntegerField;
    FDQuery_Group: TFDQuery;
    DataSource_Group: TDataSource;
    FDQuery_Groupid: TFDAutoIncField;
    FDQuery_Group����: TWideStringField;
    FDQuery_Group��ԱID: TWideStringField;
    FDQuery_ZU: TFDQuery;
    FDQuery_JICI: TFDQuery;
    FDQuery_JICI��ԱID: TWideStringField;
    FDQuery_JICI����: TLargeintField;
    FDQuery_JICInickname: TStringField;
    DataSource_JICI: TDataSource;
    procedure FDMemTable_AddrListCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure FDQuery_JICICalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses
  upublic, uForm_Main, vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  path: string;
begin
  // ��ʼ�����ݿ�
  path := ExtractFilePath(ParamStr(0)) + 'helper.sdb';

  // ���������ݿ����Ӳ���
  FDConnection1.Params.Clear;
  FDConnection1.Params.Values['DriverID'] := 'SQLite';
  FDConnection1.Params.Values['Database'] := path;

  // ��ӱ�Ҫ�����Ӳ���
  FDConnection1.Params.Values['LockingMode'] := 'Normal';
  FDConnection1.Params.Values['Synchronous'] := 'Normal';
  FDConnection1.Params.Values['SharedCache'] := 'False';
  FDConnection1.Params.Values['StringFormat'] := 'Unicode';

  try
    if not FileExists(path) then
    begin
      // ȷ��Ŀ¼����
      ForceDirectories(ExtractFilePath(path));

      FDConnection1.Connected := True;

      // ����SQL�﷨��SQLite��ʹ��TEXT������string
      FDConnection1.ExecSQL('CREATE TABLE Huifu(' + 'id integer primary key autoincrement, ' + '����ID TEXT(25), ' + '�������� TEXT(254), ' + '���Ŷ��� TEXT(25), ' + '�������� TEXT(25), ' + '�������� TEXT(254), ' + '������ʱ integer)');

      FDConnection1.ExecSQL('CREATE TABLE time(' + 'id integer primary key autoincrement, ' + '�Ƿ����� BOOLEAN, ' +  // SQLite�Ƽ�ʹ��INTEGER����BOOL
        '����ID TEXT(25), ' + '��� TEXT(25), ' + '���� TEXT(254), ' + '��ʱʱ�� TEXT(254), ' + '�Ƿ��ظ� BOOLEAN, ' +  // SQLite�Ƽ�ʹ��INTEGER����BOOL
        '��ע TEXT(25))');

      FDConnection1.ExecSQL('CREATE TABLE zu(' + 'id integer primary key autoincrement, ' + '���� TEXT(25), ' + '��ԱID TEXT(25))');

      FDConnection1.ExecSQL('CREATE TABLE jici(' + 'id integer primary key autoincrement, ' + 'huifuid integer, ' + '��ԱID TEXT(25))');
    end
    else
    begin
      FDConnection1.Connected := True;
    end;

    // ����FDQuery_Huifu��SQL
    FDQuery_Huifu.SQL.Text := 'SELECT * FROM Huifu';

    // �ȴ�FDQuery_Huifu��ȡ����
    FDQuery_Huifu.Open;

    System.TMonitor.Enter(Self);
    try
      // ȷ��FDMemTable_Huifu����ȷ�Ľṹ
      if not FDMemTable_Huifu.Active then
      begin
        // �ȿ�¡�ṹ
        FDMemTable_Huifu.CloneCursor(FDQuery_Huifu, False, False);
      end;

      // ���ڿ��԰�ȫ�ظ�������
      FDMemTable_Huifu.CopyDataSet(FDQuery_Huifu, [coRestart, coAppend]);
    finally
      System.TMonitor.Exit(Self);
    end;

  except
    on E: Exception do
    begin
      // ��ϸ�Ĵ�����Ϣ
      ShowMessage('���ݿ��ʼ��ʧ��: ' + E.Message + #13#10 + '���ݿ�·��: ' + path + #13#10 + '���飺' + #13#10 + '1. �ļ�Ȩ��' + #13#10 + '2. ���̿ռ�' + #13#10 + '3. �������������');
      // ����ѡ�������׳��쳣�������������
      raise;
    end;
  end;
end;

procedure TDM.FDMemTable_AddrListCalcFields(DataSet: TDataSet);
var
  tempid: string;
begin
  tempid := DataSet.FieldByName('wxid').AsString;
  if tempid.StartsWith('gh_') then
  begin
    DataSet.FieldByName('kind').AsString := '���ں�';
  end
  else if tempid.EndsWith('@openim') then
  begin
    DataSet.FieldByName('kind').AsString := '��ҵ��';
  end
  else if tempid.EndsWith('@chatroom') then
  begin
    DataSet.FieldByName('kind').AsString := 'Ⱥ��';
  end
  else
  begin
    DataSet.FieldByName('kind').AsString := '���˺�';
  end;

end;

procedure TDM.FDQuery_JICICalcFields(DataSet: TDataSet);
var
  temp: string;
begin
  temp := DataSet.FieldByName('��ԱID').AsString;
  if FaddrList.ContainsKey(temp) then
  begin
    DataSet.FieldByName('nickname').AsString := FaddrList[temp];
  end;

end;

end.

