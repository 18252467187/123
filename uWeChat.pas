unit uWeChat;

interface

uses
  Winapi.TlHelp32, System.SysUtils, Winapi.Windows;

type
  TDspMsg = procedure(AMsg: string) of object;

type
  TWeChat = class(TObject)
  private
            { private declarations }
    FDspMsg: TDspMsg;
    procedure SetDspMsg(const Value: TDspMsg);
    procedure DoDspMsg(AMsg: string);
  protected
          { protected declarations }
  public
          { public declarations }
    property DspMsg: TDspMsg read FDspMsg write SetDspMsg;
    function StartWeChat(var pid: Integer): Boolean;
    function InjectWX(pid: Integer): Boolean;
    procedure CloseAll;
  end;

implementation

uses
  uInject, uWXAPI;
{ TWeChat }

procedure TWeChat.DoDspMsg(AMsg: string);
begin
  if Assigned(FDspMsg) then
  begin
    FDspMsg(AMsg);
  end;
end;

function TWeChat.InjectWX(pid: Integer): Boolean;
var
  errmsg: string;
  wxapi: TWXAPI;
begin
  result := false;
  if InjectDll(ExtractFilePath(ParamStr(0)) + 'wxhelper1019.dll', pid, errmsg) then
  begin
    Result := True;
    DoDspMsg('注入成功  ' + errmsg);
    wxapi := TWXAPI.Create;
    try
      if wxapi.hookSyncMsg(errmsg) then
      begin
        DoDspMsg('信息正常交互');
      end
      else
      begin
        DoDspMsg('信息交互失败：' + errmsg);
      end;
    finally
      wxapi.Free;
    end;
  end
  else
  begin
    DspMsg('注入失败' + errmsg);
  end;
end;

procedure TWeChat.SetDspMsg(const Value: TDspMsg);
begin
  FDspMsg := Value;
end;

function TWeChat.StartWeChat(var pid: Integer): Boolean;
var
  wxfilePath: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  errmsg: string;
begin
  Result := False;
  wxfilePath := ExtractFilePath(ParamStr(0)) + 'wechat\WeChat.exe';
  FillChar(ProcessInfo, sizeof(TProcessInformation), 0);
  FillChar(StartupInfo, Sizeof(TStartupInfo), 0);
  StartupInfo.cb := Sizeof(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_SHOW;
                   //直接创建进程 不暂停
  if CreateProcess(PChar(wxfilePath), nil, nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
  begin
    dodspmsg('打开微信成功');
    pid := ProcessInfo.dwProcessId;
    result := true;
//    ResumeThread(ProcessInfo.hThread);
  end;
end;

procedure EndProcess(AFileName: string);
const
  PROCESS_TERMINATE = $0001;
var
  ExeFileName: string;
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  ExeFileName := AFileName;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
      TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0);
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
end;

procedure TWeChat.CloseAll;
begin
  EndProcess('WeChat.exe');
end;

end.

