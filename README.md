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
