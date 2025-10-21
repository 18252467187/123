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

  // 创建管道
  if not CreatePipe(StdOutRead, StdOutWrite, @SecurityAttr, 0) then
    RaiseLastOSError;

  try
    FillChar(StartInfo, SizeOf(StartInfo), 0);
    StartInfo.cb := SizeOf(StartInfo);
    StartInfo.hStdOutput := StdOutWrite;
    StartInfo.hStdError := StdOutWrite;
    StartInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_HIDE;

    // 创建进程
    if not CreateProcess(nil, PChar('cmd.exe /C ' + Cmd), nil, nil, True, 0, nil, nil, StartInfo, ProcInfo) then
      RaiseLastOSError;

    CloseHandle(StdOutWrite); // 写句柄由子进程使用

    // 读取输出
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
  // 安全属性，允许继承句柄
  sa.nLength := SizeOf(sa);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := True;

  // 创建管道用于捕获输出
  if not CreatePipe(hRead, hWrite, @sa, 0) then
    RaiseLastOSError;
  try
    // 确保读取端不被子进程继承
    SetHandleInformation(hRead, HANDLE_FLAG_INHERIT, 0);

    FillChar(si, SizeOf(si), 0);
    si.cb := SizeOf(si);
    si.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    si.hStdOutput := hWrite;
    si.hStdError := hWrite;
    si.hStdInput := GetStdHandle(STD_INPUT_HANDLE); // 不需要输入，使用父进程的
    si.wShowWindow := SW_HIDE;

    // 如果 AExeName 包含路径或需加引号，直接构造完整命令行
    // CreateProcess 要求 modifiable PChar，所以用 cmdLine 变量
    if AParams <> '' then
      cmdLine := '"' + AExeName + '" ' + AParams
    else
      cmdLine := '"' + AExeName + '"';

    // 创建进程（不通过 cmd.exe，直接运行 exe）
    if not CreateProcess(nil, PChar(cmdLine), nil, nil, True, CREATE_NO_WINDOW, nil, PChar(AWorkingDir), // 设置工作目录为程序目录
      si, pi) then
    begin
      RaiseLastOSError;
    end;

    // 写端交给子进程使用，父进程关闭写端（但不能立即 CloseHandle，否则子进程可能还写）
    CloseHandle(hWrite);
    hWrite := 0;

    // 读取子进程输出
    output := '';
    repeat
      if not ReadFile(hRead, buf, SizeOf(buf) - 1, bytesRead, nil) then
      begin
        if GetLastError = ERROR_BROKEN_PIPE then
          Break; // 子进程已结束且管道关闭
        Break;
      end;
      if bytesRead > 0 then
      begin
        buf[bytesRead] := #0;
        output := output + AnsiString(buf);
      end;
    until bytesRead = 0;

    // 等待进程退出（可加超时）
    WaitForSingleObject(pi.hProcess, TimeoutMs);

    // 关闭进程句柄
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    // 返回输出（按系统编码转换）
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
  workDir := ExtractFilePath(ParamStr(0)); // 程序所在目录
  exePath := IncludeTrailingPathDelimiter(workDir) + 'ConsoleApplication.exe';
  params := '-i WeChat.exe -p ' + dllpath ;
  try
    outText := RunExeCaptureOutput(exePath, params, workDir, 30 * 1000); // 30秒超时
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
      errmsg := ('执行失败：' + E.Message);
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

