uses GraphWPF;
begin
  Window.Caption := 'Первая попытка';
  var (a, b, dx) := (-10.0, 10.0, 0.01);
  var x := a;
  while x < b do
  begin
    var y := x * x;
    SetPixel(x, y, colors.Red);
    x += dx;
  end;
end.