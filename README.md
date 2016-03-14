#content
```
I succeeded doing it as you started. Just create a simple class and register it with "TCefRTTIExtension.Register".

I could even use properties with all their benefits like in the following example

    ...

     

    type
      TMyClass = class(TObject)
      private
        FValue: string;
      protected
        procedure SetValue(Value: string);
        function GetValue: string;
      public
        property Value: string read GetValue write SetValue;
      end;

     

    implementation

     

    procedure TMyClass.SetValue(Value: string)
    begin
      if (Value <> FValue) then begin
        // set the Value and do anything you want.
        FValue := Value;

        ShowMessage('JavaScript tells us the following: ' + FValue); 

        FValue := FValue + ' This is a modification from Delphi!';

      end;
    end;

     

    function TMyclass.GetValue: string;

    begin
      Result := 'This is the result from the getter: ' + FValue;
    end; 




Register class with something like TCefRTTIExtension.Register('myclass', TMyClass);

That should it be from Delphi side.

In javascript you now just can do things like this:

    myclass.Value = 'Hello World!';
    alert(myclass.Value);
```
A. window binding，将自定义数据绑定到JS context的window对象上

1.在回调CefRenderProcessHandler的OnContextCreated()中注册。注册过程：

1.1获取CefV8Value形式的window对象

1.2构造数据

1.3绑定到window对象上


B.extensions，将预定义的JS代码注册到context中，并且一旦注册，不可修改。这种方式威力很弱，我想只会在特殊的场景下选它。

 

在CefRenderProcessHandler的回调OnWebKitInitialized()中执行注册

示例：
[cpp] view plain copy

    void MyRenderProcessHandler::OnWebKitInitialized() {  
        std::string extensionCode =   
        "var test;"  
        "if (!test)"  
        "  test = {};"  
        "(function() {"  
        "  test.myval = 'My Value!';"  
        "})();";  
      
      
      CefRegisterExtension("v8/test", extensionCode, NULL);  
    }  
    void MyRenderProcessHandler::OnContextCreated(  
        CefRefPtr<CefBrowser> browser,  
        CefRefPtr<CefFrame> frame,  
        CefRefPtr<CefV8Context> context) {  
      CefRefPtr<CefV8Value> object = context->GetGlobal();// 获取到window  
      CefRefPtr<CefV8Value> str = CefV8Value::CreateString("My Value!");  
      object->SetValue("myval", str, V8_PROPERTY_ATTRIBUTE_NONE);  
    }  
    
    
        CefRefPtr<CefBrowser> browser = ...;  
    CefRefPtr<CefFrame> frame = browser->GetMainFrame();  
    frame->ExecuteJavaScript("alert('ExecuteJavaScript works!');",  
        frame->GetURL(), 0);  
        
https://bitbucket.org/chromiumembedded/cef/wiki/JavaScriptIntegration        
