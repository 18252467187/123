program wxbot2;

uses
  Vcl.Forms,
  uForm_Main in 'uForm_Main.pas' {Form_Main},
  uWeChat in 'uWeChat.pas',
  uInject in 'uInject.pas',
  uWXAPI in 'uWXAPI.pas',
  uForm_AddrList in 'Forms\uForm_AddrList.pas' {Form_Addrlist},
  uDM in 'uDM.pas' {DM: TDataModule},
  uForm_AI in 'Forms\uForm_AI.pas' {Form_AI},
  uForm_Add2 in 'Forms\uForm_Add2.pas' {Form_Add2},
  uForm_Add in 'Forms\uForm_Add.pas' {Form_Add},
  uForm_Select in 'Forms\uForm_Select.pas' {Form_Select},
  uForm_Add3 in 'Forms\uForm_Add3.pas' {Form_Add3},
  uForm_JICI in 'Forms\uForm_JICI.pas' {Form_JICI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TForm_JICI, Form_JICI);
  Application.Run;
end.

