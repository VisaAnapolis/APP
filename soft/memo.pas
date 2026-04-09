unit memo;

interface
Function GetMemoSize(TheMemo: TObject): integer;


implementation
uses SysUtils, StdCtrls ;

Function GetMemoSize(TheMemo: TObject): integer;
var i: integer;
begin
result := 0;
with (TheMemo as TMemo).lines do
begin
for i := count - 1 downto 0 do
begin
result := result + length(strings[i]);
end;
end;
end;

end.
 