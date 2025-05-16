clc; clear;

% Definir función simbólica y su derivada
syms x
f_sym = 1 + 2*x - 3*x^2 + 4*x^3 - 5*x^4 + 6*x^5;
f = matlabFunction(f_sym);
f4 = matlabFunction(diff(f_sym, x, 4));

a = 0; b = 1;

% Valor exacto de la integral (cálculo simbólico)
I_exacta = double(int(f_sym, x, a, b));

% Simpson 1/3 (n = 2)
n1 = 2;
h1 = (b - a)/n1;
x1 = a:h1:b;
y1 = f(x1);
I_13 = (h1/3)*(y1(1) + 4*y1(2) + y1(3));

% Simpson 3/8 (n = 3)
n2 = 3;
h2 = (b - a)/n2;
x2 = a:h2:b;
y2 = f(x2);
I_38 = (3*h2/8)*(y2(1) + 3*y2(2) + 3*y2(3) + y2(4));

% Aproximación total (promedio)
I_total = (I_13 + I_38)/2;

% Valor medio de la cuarta derivada
x_vals = linspace(a, b, 1000);
f4_vals = abs(f4(x_vals));
f4_medio = mean(f4_vals);

% Error de truncamiento estimado (Simpson 3/8)
% Fórmula: E <= -(b-a)*h^4/80 * max|f⁽⁴⁾(x)|
E_trunc = ((b - a)*h2^4 / 80) * max(f4_vals);

% Error relativo porcentual
E_rel = abs((I_38 - I_exacta)/I_exacta) * 100;

% Resultados
fprintf('Integral exacta: %.5f\n', I_exacta);
fprintf('Integral aproximada (Simpson 1/3): %.5f\n', I_13);
fprintf('Integral aproximada (Simpson 3/8): %.5f\n', I_38);
fprintf('Integral aproximada total: %.5f\n', I_total);
fprintf('Valor medio de la cuarta derivada: %.5f\n', f4_medio);
fprintf('Error de truncamiento estimado: %.5e\n', E_trunc);
fprintf('Error relativo porcentual: %.2f%%\n', E_rel);
