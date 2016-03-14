unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cefvcl, ceflib;

type
  TForm5 = class(TForm)
    ch1: TChromium;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { D?clarations priv?es }
  public
    { D?clarations publiques }
  end;

  TMyClass = class(TObject)
  private
    FValue: string;
  protected
    procedure SetValue(Value: string);
    function GetValue: string;
  public
    property Value: string read GetValue write SetValue;
  end;

  TCustomRenderProcessHandler = class(TCefRenderProcessHandlerOwn)
  protected
    procedure OnWebKitInitialized; override;
  end;

var
  Form5: TForm5;
  test: TMyClass;

implementation

{$R *.dfm}

procedure TCustomRenderProcessHandler.OnWebKitInitialized;
begin
  TCefRTTIExtension.Register('myclass', Test);
end;

procedure TMyClass.SetValue(Value: string);
begin
  if (Value <> FValue) then
  begin
    // set the Value and do anything you want.
    FValue := Value;
    ShowMessage('Js said: ' + FValue);
    FValue := FValue + ' !Send by Js';
  end;
end;

{
  In javascript:
  myclass.Value = 'Hello from Js!';
}
function TMyClass.GetValue: string;
begin
  Result := FValue;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  ch1.Load(Edit1.Text);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  edit2.text := test.value;
end;

procedure TForm5.FormDestroy(Sender: TObject);
begin
  test.Free;
end;

initialization
  CefRenderProcessHandler := TCustomRenderProcessHandler.Create;
  test := TMyClass.Create;
end.
