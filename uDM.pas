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
    FDQuery_Huifu收信ID: TWideStringField;
    FDQuery_Huifu收信内容: TWideStringField;
    FDQuery_Huifu发信对象: TWideStringField;
    FDQuery_Huifu发信类型: TWideStringField;
    FDQuery_Huifu发信内容: TWideStringField;
    FDQuery_Huifu发信延时: TIntegerField;
    FDQuery_Timeid: TFDAutoIncField;
    FDQuery_Time是否启用: TBooleanField;
    FDQuery_Time对象ID: TWideStringField;
    FDQuery_Time类别: TWideStringField;
    FDQuery_Time内容: TWideStringField;
    FDQuery_Time定时时间: TWideStringField;
    FDQuery_Time是否重复: TBooleanField;
    FDQuery_Time备注: TWideStringField;
    FDMemTable_Huifu: TFDMemTable;
    FDMemTable_Huifuid: TFDAutoIncField;
    FDMemTable_Huifu收信ID: TWideStringField;
    FDMemTable_Huifu收信内容: TWideStringField;
    FDMemTable_Huifu发信对象: TWideStringField;
    FDMemTable_Huifu发信类型: TWideStringField;
    FDMemTable_Huifu发信内容: TWideStringField;
    FDMemTable_Huifu发信延时: TIntegerField;
    FDQuery_Group: TFDQuery;
    DataSource_Group: TDataSource;
    FDQuery_Groupid: TFDAutoIncField;
    FDQuery_Group组名: TWideStringField;
    FDQuery_Group组员ID: TWideStringField;
    FDQuery_ZU: TFDQuery;
    FDQuery_JICI: TFDQuery;
    FDQuery_JICI组员ID: TWideStringField;
    FDQuery_JICI次数: TLargeintField;
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
  // 初始化数据库
  path := ExtractFilePath(ParamStr(0)) + 'helper.sdb';

  // 先设置数据库连接参数
  FDConnection1.Params.Clear;
  FDConnection1.Params.Values['DriverID'] := 'SQLite';
  FDConnection1.Params.Values['Database'] := path;

  // 添加必要的连接参数
  FDConnection1.Params.Values['LockingMode'] := 'Normal';
  FDConnection1.Params.Values['Synchronous'] := 'Normal';
  FDConnection1.Params.Values['SharedCache'] := 'False';
  FDConnection1.Params.Values['StringFormat'] := 'Unicode';

  try
    if not FileExists(path) then
    begin
      // 确保目录存在
      ForceDirectories(ExtractFilePath(path));

      FDConnection1.Connected := True;

      // 修正SQL语法：SQLite中使用TEXT而不是string
      FDConnection1.ExecSQL('CREATE TABLE Huifu(' + 'id integer primary key autoincrement, ' + '收信ID TEXT(25), ' + '收信内容 TEXT(254), ' + '发信对象 TEXT(25), ' + '发信类型 TEXT(25), ' + '发信内容 TEXT(254), ' + '发信延时 integer)');

      FDConnection1.ExecSQL('CREATE TABLE time(' + 'id integer primary key autoincrement, ' + '是否启用 BOOLEAN, ' +  // SQLite推荐使用INTEGER代替BOOL
        '对象ID TEXT(25), ' + '类别 TEXT(25), ' + '内容 TEXT(254), ' + '定时时间 TEXT(254), ' + '是否重复 BOOLEAN, ' +  // SQLite推荐使用INTEGER代替BOOL
        '备注 TEXT(25))');

      FDConnection1.ExecSQL('CREATE TABLE zu(' + 'id integer primary key autoincrement, ' + '组名 TEXT(25), ' + '组员ID TEXT(25))');

      FDConnection1.ExecSQL('CREATE TABLE jici(' + 'id integer primary key autoincrement, ' + 'huifuid integer, ' + '组员ID TEXT(25))');
    end
    else
    begin
      FDConnection1.Connected := True;
    end;

    // 设置FDQuery_Huifu的SQL
    FDQuery_Huifu.SQL.Text := 'SELECT * FROM Huifu';

    // 先打开FDQuery_Huifu获取数据
    FDQuery_Huifu.Open;

    System.TMonitor.Enter(Self);
    try
      // 确保FDMemTable_Huifu有正确的结构
      if not FDMemTable_Huifu.Active then
      begin
        // 先克隆结构
        FDMemTable_Huifu.CloneCursor(FDQuery_Huifu, False, False);
      end;

      // 现在可以安全地复制数据
      FDMemTable_Huifu.CopyDataSet(FDQuery_Huifu, [coRestart, coAppend]);
    finally
      System.TMonitor.Exit(Self);
    end;

  except
    on E: Exception do
    begin
      // 详细的错误信息
      ShowMessage('数据库初始化失败: ' + E.Message + #13#10 + '数据库路径: ' + path + #13#10 + '请检查：' + #13#10 + '1. 文件权限' + #13#10 + '2. 磁盘空间' + #13#10 + '3. 防病毒软件拦截');
      // 可以选择重新抛出异常或进行其他处理
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
    DataSet.FieldByName('kind').AsString := '公众号';
  end
  else if tempid.EndsWith('@openim') then
  begin
    DataSet.FieldByName('kind').AsString := '企业号';
  end
  else if tempid.EndsWith('@chatroom') then
  begin
    DataSet.FieldByName('kind').AsString := '群聊';
  end
  else
  begin
    DataSet.FieldByName('kind').AsString := '个人号';
  end;

end;

procedure TDM.FDQuery_JICICalcFields(DataSet: TDataSet);
var
  temp: string;
begin
  temp := DataSet.FieldByName('组员ID').AsString;
  if FaddrList.ContainsKey(temp) then
  begin
    DataSet.FieldByName('nickname').AsString := FaddrList[temp];
  end;

end;

end.

