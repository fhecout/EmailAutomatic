unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdSMTP, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  Vcl.StdCtrls, IdSSLOpenSSL;

type
  TForm1 = class(TForm)
    IdSMTP1: TIdSMTP;
    EnviarEmail: TButton;
    procedure EnviarEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    Mail: TIdMessage;
    CaminhoAnexo: string;
  end;

var
  Form1: TForm1;
  SMTP: TIdSMTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  CaminhoAnexo: string;

implementation

{$R *.dfm}

procedure TForm1.EnviarEmailClick(Sender: TObject);
begin
  SMTP := TIdSMTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Mail := TIdMessage.Create(nil);
  try
    SSLHandler.SSLOptions.Method := sslvSSLv23;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    SSLHandler.SSLOptions.VerifyMode := [];
    SSLHandler.SSLOptions.VerifyDepth := 0;

    SMTP.IOHandler := SSLHandler;
    SMTP.Port := 587; // porta SMT
    SMTP.Host := 'smtp.gmail.com';  //Host do Gmail
    SMTP.Username := '';    //Login Gmail
    SMTP.Password := '';    //Senha Para APP do Gmail
    SMTP.UseTLS := utUseExplicitTLS;
    SMTP.Connect;

        mail.From.Address := ''; // Quem irar mandar o Email / Email Informado no Login
        mail.Recipients.EmailAddresses := ''; // para a pessoa que deseja mandar
        mail.Subject := 'TESTE'; // Assunto da Mensagem
        mail.Body.Text := 'TESTE'; // Mensagem


    if SMTP.Connected then
    begin
      SMTP.Send(Mail);
      SMTP.Disconnect;
    end;
  finally
    Mail.Free;
    SSLHandler.Free;
    SMTP.Free;
    showmessage('Mensagem Enviada com Sucesso');
  end;
end;

end.
