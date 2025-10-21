unit uForm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  dxUIAClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, Vcl.StdCtrls, cxTextEdit, cxMemo, QWorker,
  dxBarBuiltInMenu, cxPC, dxBar, dxBarExtItems, cxClasses, IdBaseComponent,
  IdComponent, IdCustomTCPServer, IdTCPServer, IdContext, IdIOHandler,
  IdException, IdTCPConnection, IdTCPClient, IdGlobal, IdExceptionCore, IdStack,
  dxGDIPlusClasses, System.Generics.Collections, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.ExtCtrls;

type
  TForm_Main = class(TForm)
    ��Ϣ: TcxGroupBox;
    cxMemo_Msg: TcxMemo;
    dxBarManager_Main: TdxBarManager;
    dxBarManager_MainBar1: TdxBar;
    dxBarStatic_Img: TdxBarStatic;
    dxBarLargeButton_CloseAll: TdxBarLargeButton;
    dxBarButton_State: TdxBarButton;
    dxBarLargeButton_Help: TdxBarLargeButton;
    cxPageControl_Main: TcxPageControl;
    ��Ϣ��¼: TcxTabSheet;
    ͨѶ¼: TcxTabSheet;
    IdTCPServer1: TIdTCPServer;
    ��Ϣ����: TcxTabSheet;
    dxBarLargeButton_refresh: TdxBarLargeButton;
    Timer1: TTimer;
    procedure dxBarButton_StateClick(Sender: TObject);
    procedure dxBarLargeButton_CloseAllClick(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure FormCreate(Sender: TObject);
    procedure dxBarLargeButton_refreshClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxBarLargeButton_HelpClick(Sender: TObject);
  private
    { Private declarations }
    procedure dealMsg(amsg: string);
    procedure RefreshAddr;
    procedure RuleMsg(wxid, touser, msg: string);
  public
    { Public declarations }
    procedure DspMsg(amsg: string);
  end;

var
  Form_Main: TForm_Main;
  FaddrList: TDictionary<string, string>;

implementation

uses
  uWeChat, qstring, qjson, uWXAPI, uForm_AddrList, uDM, qlog, uForm_AI,
  System.RegularExpressions;

var
  firstMsg: Boolean;

{$R *.dfm}
  { TForm_Main }
var
  MsgQueue: TThreadList<string>;

procedure TForm_Main.dealMsg(amsg: string);
var
  msgtype: Integer;
  json: TQJson;
  chatroomName, nickName, touser, wxid, content: string;
begin
  PostLog(llDebug, amsg);
  json := TQJson.Create;
  try
    json.Parse(amsg);
    msgtype := json.IntByName('type', 0);
    case msgtype of
      1: // �ı���Ϣ
        begin
          content := json.ValueByName('content', '');
          wxid := json.ValueByName('fromUser', '');
          if (content = '') or (wxid = '') then
          begin
            DspMsg(amsg);
            DspMsg('content Ϊ��');
            Exit;
          end;
          if FaddrList.ContainsKey(wxid) then
          begin
            nickName := FaddrList[wxid];
          end
          else
          begin
            nickName := wxid;
          end;
          touser := json.ValueByName('toUser', '');
          if touser.EndsWith('@chatroom') then
          begin
            if FaddrList.ContainsKey(touser) then
            begin
              chatroomName := FaddrList[touser];
            end
            else
            begin
              chatroomName := touser;
            end;
            DspMsg(Format('��%s��Ⱥ��Ϣ��%s ˵: %s', [chatroomName, nickName, content]));
          end
          else
          begin
            DspMsg(Format('%s˵: %s', [wxid, content]));
          end;
          RuleMsg(wxid, touser, content);
        end;
      3: // ͼƬ��Ϣ
        begin
          wxid := json.ValueByName('fromUser', '');
          if (wxid = '') then
          begin
            DspMsg('wxidΪ��');
            Exit;
          end;
          if FaddrList.ContainsKey(wxid) then
          begin
            wxid := FaddrList[wxid];
          end;
          touser := json.ValueByName('toUser', '');
          if touser.EndsWith('@chatroom') then
          begin
            if FaddrList.ContainsKey(touser) then
            begin
              touser := FaddrList[touser];
            end;
            DspMsg(Format('��%s��Ⱥ��Ϣ��%s ����һ��ͼƬ', [touser, wxid]));
          end
          else
          begin
            DspMsg(Format('%s����һ��ͼƬ', [wxid]));
          end;
        end;
      43: // ��Ƶ
        begin
          wxid := json.ValueByName('fromUser', '');
          if (wxid = '') then
          begin
            DspMsg('wxidΪ��');
            Exit;
          end;
          if FaddrList.ContainsKey(wxid) then
          begin
            wxid := FaddrList[wxid];
          end;
          touser := json.ValueByName('toUser', '');
          if touser.EndsWith('@chatroom') then
          begin
            if FaddrList.ContainsKey(touser) then
            begin
              touser := FaddrList[touser];
            end;
            DspMsg(Format('��%s��Ⱥ��Ϣ��%s ����һ����Ƶ', [touser, wxid]));
          end
          else
          begin
            DspMsg(Format('%s����һ����Ƶ', [wxid]));
          end;
        end;
      47: // ����
        begin
          wxid := json.ValueByName('fromUser', '');
          if (wxid = '') then
          begin
            DspMsg('wxidΪ��');
            Exit;
          end;
          if FaddrList.ContainsKey(wxid) then
          begin
            wxid := FaddrList[wxid];
          end;
          touser := json.ValueByName('toUser', '');
          if touser.EndsWith('@chatroom') then
          begin
            if FaddrList.ContainsKey(touser) then
            begin
              touser := FaddrList[touser];
            end;
            DspMsg(Format('��%s��Ⱥ��Ϣ��%s ����һ������', [touser, wxid]));
          end
          else
          begin
            DspMsg(Format('%s����һ������', [wxid]));
          end;
        end;
      49: // ���ںſ�Ƭ��Ϣ
        begin
          wxid := json.ValueByName('fromUser', '');
          if (wxid = '') then
          begin
            DspMsg('wxidΪ��');
            Exit;
          end;
          if FaddrList.ContainsKey(wxid) then
          begin
            wxid := FaddrList[wxid];
          end;
          DspMsg(Format('%s����һ����Ƭ��Ϣ', [wxid]));
        end;
      51: // ��֪����ʲô��Ϣ
        begin

        end;
      10002: // ������ ��һ����Ϣ      ������Ϣ     {"content":"<sysmsg type=\"revokemsg\"><revokemsg><session>wxid_wlbowjkrl4vz12</session><msgid>1703763915</msgid><newmsgid>4186012734293356952</newmsgid><replacemsg><![CDATA[�㳷����һ����Ϣ]]></replacemsg></revokemsg></sysmsg>","createTime":1760677888,"displayFullContent":"","fromUser":"cmxnew","msgId":1975777452,"msgSequence":774110631,"pid":7144,"signature":"<msgsource>\n\t<tmp_node>\n\t\t<publisher-id></publisher-id>\n\t</tmp_node>\n</msgsource>\n","toUser":"wxid_wlbowjkrl4vz12","type":10002}
        begin

        end;
    else
      begin
        DspMsg(amsg);
      end;
    end;
  finally
    json.free;
  end;

end;

procedure TForm_Main.DspMsg(amsg: string);
begin
  MsgQueue.Add(amsg);
end;

procedure TForm_Main.dxBarButton_StateClick(Sender: TObject);
var
  wechat: TWeChat;
  pid: Integer;
begin
  if dxBarButton_State.Caption = '���΢��' then
  begin
    wechat := TWeChat.Create;
    try
      wechat.DspMsg := Self.DspMsg;
      if wechat.StartWeChat(pid) then
      begin
        Sleep(1000);
        wechat.InjectWX(pid);
      end;
    finally
      wechat.free;
    end;
  end;
end;

procedure TForm_Main.dxBarLargeButton_CloseAllClick(Sender: TObject);
var
  wechat: TWeChat;
begin
  firstMsg := True;
  wechat := TWeChat.Create;
  try
    wechat.DspMsg := Self.DspMsg;
    wechat.CloseAll;
  finally
    wechat.free;
  end;

end;

procedure TForm_Main.dxBarLargeButton_HelpClick(Sender: TObject);
begin
  ShowMessage('powered by yl������')
end;

procedure TForm_Main.dxBarLargeButton_refreshClick(Sender: TObject);
begin
  RefreshAddr;
end;

procedure TForm_Main.FormCreate(Sender: TObject);
begin
  SetDllDirectory(PWideChar(ExtractFilePath(ParamStr(0)) + 'dll'));
  SetDefaultLogFile();
  Form_Addrlist := TForm_Addrlist.Create(ͨѶ¼);
  Form_Addrlist.Parent := ͨѶ¼;
  Form_Addrlist.Show;
  Form_AI := TForm_AI.Create(��Ϣ����);
  Form_AI.Parent := ��Ϣ����;
  Form_AI.Show;
  MsgQueue := TThreadList<string>.Create;
  // ��ʱ��������������
end;

procedure TForm_Main.FormDestroy(Sender: TObject);
begin
  MsgQueue.Free;
end;

procedure TForm_Main.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TForm_Main.IdTCPServer1Execute(AContext: TIdContext);
var
  LIOHandler: TIdIOHandler;
  nickName, userinfo, LText, errmsg: string;
  json, userinfojson: TQJson;
  wxapi: TWXAPI;
  ms: TMemoryStream;
  image: TdxSmartImage;
begin
  LIOHandler := AContext.Connection.IOHandler;
  LIOHandler.MaxLineLength := 0; // 0 ��ʾ������
  try
    // ��ȡһ���У��ͻ��˷��� JSON + \n��
    LText := LIOHandler.ReadLn(IndyTextEncoding_UTF8);
    if LText <> '' then
    begin
      json := TQJson.Create;
      try
        if json.TryParse(LText) then
        begin
{$REGION '�״ε�¼����Ϣ��ȡ'}
          System.TMonitor.Enter(Self);
          try
            if firstMsg then
            begin
              wxapi := TWXAPI.Create;
              try
                wxapi.DspMsg := Self.DspMsg;
                if not wxapi.checkLogin(errmsg) then
                begin
                  DspMsg(errmsg);
                  Exit;
                end;
                // �ѵ�¼
                ms := TMemoryStream.Create;
                try
                  if wxapi.userinfo(userinfo, nickName, errmsg, ms) then
                  begin
                    dxBarButton_State.Caption := nickName;
                    ms.Position := 0;
                    image := TdxSmartImage.CreateFromStream(ms);
                    try
                      image.Resize(42, 42);
                      dxBarStatic_Img.Glyph.Assign(image);
                      firstMsg := False;

                      DspMsg('�˺ŵ�½�ɹ�');
                      RefreshAddr;

                    finally
                      FreeAndNil(image);
                    end;
                  end;
                finally
                  ms.free;
                end;
              finally
                wxapi.free;
              end;
            end;
          finally
            System.TMonitor.Exit(Self);
          end;
{$ENDREGION}
          dealMsg(LText);
        end
        else
        begin
          DspMsg(Format('�յ����� %s:%d ����Ϣ: %s', [AContext.Binding.PeerIP, AContext.Binding.PeerPort, LText]));
        end;
      finally
        json.free;
      end;
      // �ظ��ͻ��ˣ��ͻ��˻� recv һ�Σ�
      LIOHandler.WriteLn('OK', IndyTextEncoding_UTF8);
    end;
  except
    on E: EIdConnClosedGracefully do
      DspMsg('�ͻ��������Ͽ�: ' + AContext.Binding.PeerIP);
    on E: EIdReadTimeout do
      DspMsg('��ȡ��ʱ: ' + E.Message);
    on E: EIdSocketError do
      DspMsg('Socket ����: ' + E.Message);
    on E: Exception do
    begin
      DspMsg('δ֪����: ' + E.Message);
      AContext.Connection.Disconnect;
    end;
  end;
end;

procedure TForm_Main.RefreshAddr;
var
  wxapi: TWXAPI;
  errmsg, addrstr: string;
  wxid, nickName, remark, customAccount: string;
begin
  // �߳�����
  wxapi := TWXAPI.Create;
  try
    if wxapi.getContactList(addrstr, errmsg) then
    begin
      UniqueString(addrstr);
      RunInMainThread(
        procedure
        var
          item, json: TQJson;
        begin
          json := TQJson.Create;
          try
            json.Parse(addrstr);
            dm.FDMemTable_AddrList.Close;
            dm.FDMemTable_AddrList.open;
            dm.FDMemTable_AddrList.DisableControls;
            try
              FaddrList.Clear;
              for item in json do
              begin
                wxid := item.ValueByPath('wxid', '');
                nickName := item.ValueByPath('nickname', '');
                remark := item.ValueByPath('remark', '');
                customAccount := item.ValueByPath('customAccount', '');
                dm.FDMemTable_AddrList.AppendRecord([wxid, nickName, remark, customAccount]);
                if not FaddrList.ContainsKey(wxid) then
                begin
                  if Trim(remark) <> '' then
                  begin
                    FaddrList.Add(wxid, remark);
                  end
                  else
                  begin
                    FaddrList.Add(wxid, nickName);
                  end;
                end;
              end;
            finally
              dm.FDMemTable_AddrList.EnableControls;
            end;
          finally
            json.free;
          end;
          DspMsg('ͨѶ¼�������');
        end);
    end
    else
    begin
      DspMsg('ͨѶ¼����ʧ��' + errmsg);
    end;
  finally
    wxapi.free;
  end;

end;
// ������    //Ⱥ��  //����

procedure TForm_Main.RuleMsg(wxid, touser, msg: string);
var
  toid, senderid, sendStr, sendType: string;
  temptoid: string;
  i: Integer;
  fromFlagid: string;
  hitflag: Boolean;
  id: Int64;
const
  StrInsert = 'INSERT INTO jici(huifuid, ��ԱID) VALUES(:huifuid,:��ԱID)';
begin
  System.TMonitor.Enter(dm);
  try
    dm.FDMemTable_Huifu.First;
    while not dm.FDMemTable_Huifu.Eof do
    begin
      // ҵ�����
      // �Ƿ� ƥ��   ������          ��   ����Ⱥ
      hitflag := false;
      if touser.EndsWith('@chatroom') then // ��ҵ΢��Ⱥ�� ���δ֪
      begin
        senderid := touser;
      end
      else
      begin
        senderid := wxid;
      end;
      //������pipei
      fromFlagid := dm.FDMemTable_Huifu.FieldByName('����ID').AsString;
      if FGroupDic.ContainsKey(fromFlagid) then
      begin
        if FGroupDic[fromFlagid].Contains(senderid) then
          hitflag := True;
      end
      else
      begin
        if TRegEx.IsMatch(senderid, fromFlagid) then
        begin
          hitflag := True;
        end;
      end;
      if hitflag then
      begin
        // �Ƿ�    ƥ��      ��Ƿ���
        if TRegEx.IsMatch(msg, dm.FDMemTable_Huifu.FieldByName('��������').AsString) then
        begin
          id := dm.FDMemTable_Huifu.FieldByName('id').AsLargeInt;
          sendStr := dm.FDMemTable_Huifu.FieldByName('��������').AsString;
          sendType := dm.FDMemTable_Huifu.FieldByName('��������').AsString;
          if sendType = '�ƴ�' then
          begin
            System.TMonitor.Enter(dm);
            try
              DM.FDConnection1.ExecSQL(StrInsert, [id, senderid]);
            finally
              System.TMonitor.Exit(dm);
            end;
            Exit;
          end;
          if dm.FDMemTable_Huifu.FieldByName('���Ŷ���').AsString = '.*' then
          begin
            toid := senderid;
          end
          else
          begin
            toid := dm.FDMemTable_Huifu.FieldByName('���Ŷ���').AsString;
          end;

          if FGroupDic.ContainsKey(toid) then
          begin
            for i := 0 to FGroupDic[toid].Count - 1 do
            begin
              temptoid := FGroupDic[toid][i];

              if sendType = '�ı�' then
              begin
                Workers.Delay(
                  procedure(ajob: pQJob)
                  var
                    t1, t2, errmsg: string;
                    wxapi: TWXAPI;
                  begin
                    t1 := ajob.ExtData.Params[0];
                    t2 := ajob.ExtData.Params[1];
                    wxapi := TWXAPI.Create;
                    try
                      if not wxapi.sendTextMsg(t1, t2, errmsg) then
                      begin
                        DspMsg('��' + t1 + '����ʧ��' + errmsg);
                      end
                      else
                      begin
                        DspMsg('�������');
                      end;
                    finally
                      wxapi.free;
                    end;
                  end, 10000 * dm.FDMemTable_Huifu.FieldByName('������ʱ').AsInteger * (i + 1), TQJobExtData.Create([temptoid, sendStr]), false, jdfFreeAsObject, False);
              end
              else if sendType = 'ͼƬ' then
              begin
                Workers.Delay(
                  procedure(ajob: pQJob)
                  var
                    t1, t2, errmsg: string;
                    wxapi: TWXAPI;
                  begin
                    t1 := ajob.ExtData.Params[0];
                    t2 := ajob.ExtData.Params[1];
                    wxapi := TWXAPI.Create;
                    try
                      if not wxapi.sendImagesMsg(t1, t2, errmsg) then
                      begin
                        DspMsg('��' + t1 + '��ͼƬʧ��' + errmsg);
                      end
                      else
                      begin
                        DspMsg('��ͼƬ���');
                      end;
                    finally
                      wxapi.free;
                    end;
                  end, 10000 * dm.FDMemTable_Huifu.FieldByName('������ʱ').AsInteger * (i + 1), TQJobExtData.Create([temptoid, sendStr]), false, jdfFreeAsObject, False);
              end
              else if sendType = '�ļ�' then
              begin
                Workers.Delay(
                  procedure(ajob: pQJob)
                  var
                    t1, t2, errmsg: string;
                    wxapi: TWXAPI;
                  begin
                    t1 := ajob.ExtData.Params[0];

                    t2 := ajob.ExtData.Params[1];
                    wxapi := TWXAPI.Create;
                    try
                      if not wxapi.sendFileMsg(t1, t2, errmsg) then
                      begin
                        DspMsg('��' + t1 + ' ���ļ�ʧ��' + errmsg);
                      end
                      else
                      begin
                        DspMsg('���ļ����');
                      end;
                    finally
                      wxapi.free;
                    end;
                  end, 10000 * dm.FDMemTable_Huifu.FieldByName('������ʱ').AsInteger * (i + 1), TQJobExtData.Create([temptoid, sendStr]), false, jdfFreeAsObject, False);
              end;

            end;
          end
          else
          begin

            if sendType = '�ı�' then
            begin
              Workers.Delay(
                procedure(ajob: pQJob)
                var
                  t1, t2, errmsg: string;
                  wxapi: TWXAPI;
                begin
                  t1 := ajob.ExtData.Params[0];
                  t2 := ajob.ExtData.Params[1];
                  wxapi := TWXAPI.Create;
                  try
                    if not wxapi.sendTextMsg(t1, t2, errmsg) then
                    begin
                      DspMsg('��' + t1 + '����ʧ��' + errmsg);
                    end
                    else
                    begin
                      DspMsg('�������');
                    end;
                  finally
                    wxapi.free;
                  end;
                end, 10000 * dm.FDMemTable_Huifu.FieldByName('������ʱ').AsInteger, TQJobExtData.Create([toid, sendStr]), false, jdfFreeAsObject, False);
            end
            else if sendType = 'ͼƬ' then
            begin
              Workers.Delay(
                procedure(ajob: pQJob)
                var
                  t1, t2, errmsg: string;
                  wxapi: TWXAPI;
                begin
                  t1 := ajob.ExtData.Params[0];
                  t2 := ajob.ExtData.Params[1];
                  wxapi := TWXAPI.Create;
                  try
                    if not wxapi.sendImagesMsg(t1, t2, errmsg) then
                    begin
                      DspMsg('��' + t1 + '��ͼƬʧ��' + errmsg);
                    end
                    else
                    begin
                      DspMsg('��ͼƬ���');
                    end;
                  finally
                    wxapi.free;
                  end;
                end, 10000 * dm.FDMemTable_Huifu.FieldByName('������ʱ').AsInteger, TQJobExtData.Create([toid, sendStr]), false, jdfFreeAsObject, False);
            end
            else if sendType = '�ļ�' then
            begin
              Workers.Delay(
                procedure(ajob: pQJob)
                var
                  t1, t2, errmsg: string;
                  wxapi: TWXAPI;
                begin
                  t1 := ajob.ExtData.Params[0];

                  t2 := ajob.ExtData.Params[1];
                  wxapi := TWXAPI.Create;
                  try
                    if not wxapi.sendFileMsg(t1, t2, errmsg) then
                    begin
                      DspMsg('��' + t1 + ' ���ļ�ʧ��' + errmsg);
                    end
                    else
                    begin
                      DspMsg('���ļ����');
                    end;
                  finally
                    wxapi.free;
                  end;
                end, 10000 * dm.FDMemTable_Huifu.FieldByName('������ʱ').AsInteger, TQJobExtData.Create([toid, sendStr]), false, jdfFreeAsObject, False);
            end;
          end;

        end;
      end;

      dm.FDMemTable_Huifu.Next;
    end;
  finally
    System.TMonitor.Exit(dm);
  end;

end;

procedure TForm_Main.Timer1Timer(Sender: TObject);
var
  msgs: TList<string>;
  msg: string;
begin
  msgs := MsgQueue.LockList;
  try
    if msgs.Count > 0 then
    begin
      cxMemo_Msg.Lines.BeginUpdate;
      try
        for msg in msgs do
          cxMemo_Msg.Lines.Add(TimeToStr(Now) + '==>' + msg);
        msgs.Clear;
      finally
        cxMemo_Msg.Lines.EndUpdate;
      end;
    end;
  finally
    MsgQueue.UnlockList;
  end;
end;

initialization
  firstMsg := True;
  FaddrList := TDictionary<string, string>.Create;


finalization
  FaddrList.free;

end.

