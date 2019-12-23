uses GraphWPF;
var dx, x0, xk,  // переменные, относящиеся к поставленной задаче
    Hu, Hv, rx, Sx, Sy: real; // переменные для работы с графикой

///Рисует сетку с шагом dx по оси Х и с шагом dy по оси Y
procedure Grid(dx, dy: real);
begin
  var (du, dv) := (dx * Sx, dy * Sy); // Шаг сетки по осям
  var (nx, ny) := (round(1 / dx), round(1 / dy));
  Pen.Color := colors.Gold;
  Pen.Width := 1;
  //Вертикальные линии сетки
  var u := Hu; //Начинаем от оси OY...
  var k := 1;  //... и смещаемся влево и вправо на (k * du)
  while (u + k * du).InRange(0, Window.Width) or
        (u - k * du).InRange(0, Window.Width) do
  begin 
    Pen.Color := k mod nx > 0? colors.Gold: colors.DarkOrange ; 
    line(u + k * du, 0, u + k * du, Window.Height);
    line(u - k * du, 0, u - k * du, Window.Height);
    k += 1;
  end;
  //Горизонтальные линии сетки
  var v := Hv; //Начинаем от оси OX...
  k := 1;      //... и смещаемся вверх и вниз на (k * dv)
  while (v + k * dv).InRange(0, Window.Height) or 
        (v - k * dv).InRange(0, Window.Height) do
  begin
    Pen.Color := k mod ny > 0? colors.Gold: colors.DarkOrange ; 
    line(0, v + k * dv, Window.Width, v + k * dv);
    line(0, v - k * dv, Window.Width, v - k * dv);
    k += 1;
  end;
end;

///Рисует оси ПДСК, проходящие через точку (Hu; Hv)
procedure Axes;
begin
  Grid(0.1, 0.1); // Сетка с шагом 1 по осям
  Pen.Width := 2; // Толщина пера = 2 пиксела
  line(0, Hv, Window.Width, Hv, colors.Gray);  // OX
  line(Hu, 0, Hu, Window.Height, colors.Gray); // OY
end;

///Инициализация переменных
procedure Init;
begin
  // задание переменных, используемых в постановке задачи
  (x0, xk) := (-3, 3); // начальное и конечное значения по Х
  dx := 0.001; // шаг по Х
  // задание переменных для работы с графикой
  Hu := Window.Width / 2; //см. рис. 2(в)
  Hv := Window.Height - 1; // (-1) -- чтобы ось не ушла под экран
  rx := (xk - x0); // область построения графика по ОХ
  // ry не вычисляем, т.к. используем одинаковый масштаб по осям
  Sx := Window.Width / rx; // см. формулу (3)
  Sy := Sx;
  Window.Caption := 'Парабола: версия 2'; // Заголовок окна
  Axes; //Построение осей системы координат
end;

///Рисует точку на экране цветом с, соответствующую точке (x; y)
procedure OutPixel(x, y: real; c: color);
begin
  // Переводим (x; y) -> (u; v)  (см. (1))
  var u := x * Sx + Hu;
  var v := -y * Sy + Hv;
  SetPixel(u, v, c); // Ставим точку
end;

///Строит график функции в соответствии с инициализацией
procedure Plot;
begin
  var x := x0; // От х = х0...
  while x < xk do  //... и пока х < xk
  begin
    var y := x * x; // Вычисляем значение функции в точке х
    OutPixel(x, y, colors.Red); // Рисуем точку красным
    x += dx; // Берём следующую точку
  end;
end;

begin
  Init;
  Plot;  
end.