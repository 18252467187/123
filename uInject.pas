unit uInject;

interface

uses
  Winapi.Windows, qstring, System.SysUtils;

function InjectDll2(dllpath: string; dwProcessId: Integer; var errmsg: string): Boolean;

function InjectDll(dllpath: string; dwProcessId: Integer; var errmsg: string): Boolean;


implementation

function RunCommand(const Cmd: string): string;
var
  SecurityAttr: TSecurityAttributes;
  StdOutRead, StdOutWrite: THandle;
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  Buffer: array[0..1023] of AnsiChar;
  BytesRead: DWORD;
  Output: AnsiString;
begin
  Result := '';
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.bInheritHandle := True;
  SecurityAttr.lpSecurityDescriptor := nil;

  // �����ܵ�
  if not CreatePipe(StdOutRead, StdOutWrite, @SecurityAttr, 0) then
    RaiseLastOSError;

  try
    FillChar(StartInfo, SizeOf(StartInfo), 0);
    StartInfo.cb := SizeOf(StartInfo);
    StartInfo.hStdOutput := StdOutWrite;
    StartInfo.hStdError := StdOutWrite;
    StartInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_HIDE;

    // ��������
    if not CreateProcess(nil, PChar('cmd.exe /C ' + Cmd), nil, nil, True, 0, nil, nil, StartInfo, ProcInfo) then
      RaiseLastOSError;

    CloseHandle(StdOutWrite); // д������ӽ���ʹ��

    // ��ȡ���
    repeat
      if not ReadFile(StdOutRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) then
        Break;
      if BytesRead > 0 then
      begin
        Buffer[BytesRead] := #0;
        Output := Output + AnsiString(Buffer);
      end;
    until BytesRead = 0;

    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);

    Result := string(Output);
  finally
    CloseHandle(StdOutRead);
  end;
end;

function RunExeCaptureOutput(const AExeName, AParams, AWorkingDir: string; TimeoutMs: DWORD = INFINITE): string;
var
  sa: TSecurityAttributes;
  hRead, hWrite: THandle;
  si: TStartupInfo;
  pi: TProcessInformation;
  buf: array[0..2047] of AnsiChar;
  bytesRead: DWORD;
  output: AnsiString;
  cmdLine: string;
begin
  Result := '';
  // ��ȫ���ԣ�����̳о��
  sa.nLength := SizeOf(sa);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := True;

  // �����ܵ����ڲ������
  if not CreatePipe(hRead, hWrite, @sa, 0) then
    RaiseLastOSError;
  try
    // ȷ����ȡ�˲����ӽ��̼̳�
    SetHandleInformation(hRead, HANDLE_FLAG_INHERIT, 0);

    FillChar(si, SizeOf(si), 0);
    si.cb := SizeOf(si);
    si.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    si.hStdOutput := hWrite;
    si.hStdError := hWrite;
    si.hStdInput := GetStdHandle(STD_INPUT_HANDLE); // ����Ҫ���룬ʹ�ø����̵�
    si.wShowWindow := SW_HIDE;

    // ��� AExeName ����·����������ţ�ֱ�ӹ�������������
    // CreateProcess Ҫ�� modifiable PChar�������� cmdLine ����
    if AParams <> '' then
      cmdLine := '"' + AExeName + '" ' + AParams
    else
      cmdLine := '"' + AExeName + '"';

    // �������̣���ͨ�� cmd.exe��ֱ������ exe��
    if not CreateProcess(nil, PChar(cmdLine), nil, nil, True, CREATE_NO_WINDOW, nil, PChar(AWorkingDir), // ���ù���Ŀ¼Ϊ����Ŀ¼
      si, pi) then
    begin
      RaiseLastOSError;
    end;

    // д�˽����ӽ���ʹ�ã������̹ر�д�ˣ����������� CloseHandle�������ӽ��̿��ܻ�д��
    CloseHandle(hWrite);
    hWrite := 0;

    // ��ȡ�ӽ������
    output := '';
    repeat
      if not ReadFile(hRead, buf, SizeOf(buf) - 1, bytesRead, nil) then
      begin
        if GetLastError = ERROR_BROKEN_PIPE then
          Break; // �ӽ����ѽ����ҹܵ��ر�
        Break;
      end;
      if bytesRead > 0 then
      begin
        buf[bytesRead] := #0;
        output := output + AnsiString(buf);
      end;
    until bytesRead = 0;

    // �ȴ������˳����ɼӳ�ʱ��
    WaitForSingleObject(pi.hProcess, TimeoutMs);

    // �رս��̾��
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    // �����������ϵͳ����ת����
    Result := string(output);
  finally
    if hWrite <> 0 then
      CloseHandle(hWrite);
    if hRead <> 0 then
      CloseHandle(hRead);
  end;
end;

function InjectDll(dllpath: string; dwProcessId: Integer; var errmsg: string): Boolean;
var
  exePath, workDir, params, outText: string;
begin
  Result := False;
  workDir := ExtractFilePath(ParamStr(0)); // ��������Ŀ¼
  exePath := IncludeTrailingPathDelimiter(workDir) + 'ConsoleApplication.exe';
  params := '-i WeChat.exe -p ' + dllpath ;
  try
    outText := RunExeCaptureOutput(exePath, params, workDir, 30 * 1000); // 30�볬ʱ
    if outText.StartsWith('dll inject successdll') then
    begin
      Result := True;
      errmsg := (outText);
    end
    else
    begin
      errmsg := (outText);
    end;
  except
    on E: Exception do
      errmsg := ('ִ��ʧ�ܣ�' + E.Message);
  end;
end;

function InjectDll2(dllpath: string; dwProcessId: Integer; var errmsg: string): Boolean;
var
  LoadLibraryA: Pointer;
  Kernel: HMODULE;
  Process: THandle;
  DllPathAddr: Pointer;
  DllName: AnsiString;
  Written: NativeUInt;
  RemoteThread: THandle;
  ThreadId: Cardinal;
begin
  Result := false;
  DllName := dllpath;
  Kernel := GetModuleHandle('Kernel32.dll');
  LoadLibraryA := GetProcAddress(Kernel, 'LoadLibraryA');
  Process := OpenProcess(PROCESS_ALL_ACCESS, FALSE, dwProcessId);
  if Process = INVALID_HANDLE_VALUE then
    errmsg := ('Unable to open target process')
  else
  begin
    try
      DllPathAddr := VirtualAllocEx(Process, nil, Length(DllName) + 1, MEM_COMMIT, PAGE_READWRITE);
      if DllPathAddr = nil then
        errmsg := ('Failed to allocate memory in the target process')
      else
      begin
        WriteProcessMemory(Process, DllPathAddr, Pointer(DllName), Length(DllName) + 1, Written);
        RemoteThread := CreateRemoteThread(Process, nil, 0, LoadLibraryA, DllPathAddr, 0, ThreadId);
        if (RemoteThread = 0) or (RemoteThread = INVALID_HANDLE_VALUE) then
          errmsg := ('Failed to load dll into target process')
        else
        begin
          WaitForSingleObject(RemoteThread, INFINITE);
          CloseHandle(RemoteThread);
          Result := True;
        end;
      end;
    finally
      CloseHandle(Process);
    end;
  end;
end;

end.

