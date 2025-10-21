unit uWXAPI;

interface

uses
  uSimpleClass_old, System.Classes, FireDAC.Comp.Client;

type
  TWXAPI = class(TSimpleClass)
  private
  public
    function checkLogin(var errmsg: string): Boolean;
    function hookSyncMsg(var errmsg: string): Boolean;
    function userInfo(var auserinfo, nickName, errmsg: string; ms: tmemorystream): Boolean;
    function getContactList(var rsjson: string; var errmsg: string): Boolean;
    function sendTextMsg(wxid, msg: string; var errmsg: string): Boolean;
    function sendImagesMsg(wxid, ImgPath: string; var errmsg: string): Boolean;
    function sendFileMsg(wxid, filePath: string; var errmsg: string): Boolean;
  end;

implementation

uses
  System.RegularExpressions, qjson, System.Net.HttpClient;

const
  baseurl = 'http://127.0.0.1:19088/';

{ TWXAPI }

function TWXAPI.checkLogin(var errmsg: string): Boolean;       //{"code":0,"data":null,"msg":"success"}  未登录     //{"code":1,"data":null,"msg":"success"} 已登录
var
  json: TQJson;
begin
  Result := False;
  url := baseurl + 'api/checkLogin';
  postdata := '{}';
  httppost(url, postdata, rs);
  json := TQJson.Create;
  try
    if not json.TryParse(rs) then
    begin
      errmsg := rs;
    end;
    if json.IntByPath('code', -1) = 1 then
    begin
      Result := True;
    end
    else if json.IntByPath('code', -1) = 0 then
    begin
      errmsg := '未登录：交互正常';
    end
    else
    begin
      errmsg := '未登录：异常码  ' + rs;
    end;
  finally
    json.Free;
  end;
end;

 //刷新通讯录
function TWXAPI.getContactList(var rsjson: string; var errmsg: string): Boolean;
var
  item, items, json: TQJson;
begin
  Result := False;
  url := baseurl + 'api/getContactList';
  postdata := '{}';
  httppost(url, postdata, rs);
  json := TQJson.Create;
  try
    if not json.TryParse(rs) then
    begin
      errmsg := rs;
      Exit;
    end;
    if not json.HasChild('data', items) then
    begin
      errmsg := rs;
      Exit;
    end;
    rsjson := items.Encode(false);
    Result := True;
  finally
    json.Free;
  end;

  errmsg := rs;
end;

function TWXAPI.hookSyncMsg(var errmsg: string): Boolean;
begin
  Result := false;
  url := baseurl + 'api/hookSyncMsg';
  postdata := '{"port": "19099","ip":"127.0.0.1","url":"http://localhost:8080","timeout":"3000","enableHttp":"0"}';
  httppost(url, postdata, rs);
  if TRegEx.IsMatch(rs, 'msg":"success') then
  begin
    Result := True;
  end
  else
    errmsg := rs;
end;

function TWXAPI.sendFileMsg(wxid, filePath: string; var errmsg: string): Boolean;
var
  postjson: TQJson;
begin
  Result := False;
  url := baseurl + 'api/sendFileMsg';
  postjson := TQJson.Create;
  try
    postjson.Add('wxid').AsString := wxid;
    postjson.Add('filePath').AsString := filePath;
    postdata := postjson.Encode(False);
  finally
    postjson.Free;
  end;
  httppost(url, postdata, rs);
  if TRegEx.IsMatch(rs, 'msg":"success"') then
  begin
    Result := True;
  end
  else
  begin
    errmsg := rs;
  end;
end;

function TWXAPI.sendImagesMsg(wxid, ImgPath: string; var errmsg: string): Boolean;
var
  postjson: TQJson;
begin
  Result := False;
  url := baseurl + 'api/sendImagesMsg';
  postjson := TQJson.Create;
  try
    postjson.Add('wxid').AsString := wxid;
    postjson.Add('imagePath').AsString := ImgPath;
    postdata := postjson.Encode(False);
  finally
    postjson.Free;
  end;
  httppost(url, postdata, rs);
  if TRegEx.IsMatch(rs, 'msg":"success"') then
  begin
    Result := True;
  end
  else
  begin
    errmsg := rs;
  end;
end;

function TWXAPI.sendTextMsg(wxid, msg: string; var errmsg: string): Boolean;
var
  postjson: TQJson;
begin
  Result := False;
  url := baseurl + 'api/sendTextMsg';
  postjson := TQJson.Create;
  try
    postjson.Add('wxid').AsString := wxid;
    postjson.Add('msg').AsString := msg;
    postdata := postjson.Encode(False);
  finally
    postjson.Free;
  end;
  httppost(url, postdata, rs);
  if TRegEx.IsMatch(rs, 'msg":"success"') then
  begin
    Result := True;
  end
  else
  begin
    errmsg := rs;
  end;
end;

function TWXAPI.userInfo(var auserinfo, nickName, errmsg: string; ms: tmemorystream): Boolean;
var
  json: TQJson;
  imageurl: string;
  res: IHTTPResponse;
begin
  Result := false;
  url := baseurl + 'api/userInfo';
  postdata := '{}';
  httppost(url, postdata, rs);
  json := TQJson.Create;
  try
    if not json.TryParse(rs) then
    begin
      errmsg := rs;
    end;
    nickName := json.ValueByPath('data.name', '');
    imageurl := json.ValueByPath('data.headImage', '');
    if (nickName = '') or (imageurl = '') then
    begin
      errmsg := '昵称或头像为空';
      Exit;
    end;
    httpGet(imageurl, res);
    if Assigned(res.ContentStream) and (res.ContentStream.Size > 0) then
    begin
      res.ContentStream.Position := 0; // 重置流位置
      ms.CopyFrom(res.ContentStream, res.ContentStream.Size);
      ms.Position := 0; // 重置目标流位置
    end;
    auserinfo := rs;
    Result := true;
  finally
    json.Free;
  end;
end;

end.

