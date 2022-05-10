:- use_module(library(lists)).

main :-
    write("Ingresa el anio: "), read(A),
    format('~d\n', [A]),
    imprimirMeses(A),
    nl.

imprimirMeses(A) :- forall(between(1, 12, M), imprimirMes(M,A)).

anio_Bisiesto(A) :- X is A mod 4, Y is A mod 100, Z is A mod 400, ((X=0, Y\=0); Z=0).

imprimirMes(M, A) :-
    clnd_mes(M, Cant),
    ((M is 2, anio_Bisiesto(A)) -> Cant1 is Cant+1 ; Cant1 is Cant),
    (M is 1 -> diaInicial(A, D) ; diaInicial(A, M, D)),

    numlist(1, Cant1, L),

    nombreMes(M),
    writeln("  D  L  M  M   J  V  S"),
    forall(between(1, D, _), write("     ")),
    imprimirDias(L, D), nl, nl.


imprimirDias([], _) :- !.
imprimirDias([Actual | Dias], Res) :-
    (Actual < 10 -> format("   ~d", [Actual]); format(" ~d", [Actual])),
    (6 is Res mod 7 -> nl ; write("")),
    Res1 is Res + 1, imprimirDias(Dias, Res1).
    

% Cálculo del día de la semana por método de Gauss
diaInicial(A, D) :-
    D is (1 + 5*((A-1) mod 4) + 
              4*((A-1) mod 100) + 
              6*((A-1) mod 400)) mod 7, !.

diaInicial(A, M, D) :-
    tabla(A, Meses),
    nth1(M, Meses, M1),
    diaInicial(A-1, D1),
    D is (1 + M1 + D1) mod 7, !.     

tabla(A, Meses) :- 
  anio_Bisiesto(A) -> 
  append([], [0, 3, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6], Meses);
  append([], [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5], Meses).

clnd_mes(Anio_mes, Total_Dias) :-
  (Anio_mes=4; Anio_mes=6; Anio_mes=9; Anio_mes=11) -> Total_Dias is 30;
  (Anio_mes=1; Anio_mes=3; Anio_mes=5; Anio_mes=7; Anio_mes=8; Anio_mes=10; Anio_mes=12) -> Total_Dias is 31;
  ((Anio_mes=2) -> Total_Dias is 28).
    
nombreMes(M) :-
  M is 1 ->   writeln('Enero');
  (M is 2 ->  writeln('Febrero');
  (M is 3 ->  writeln('Marzo');
  (M is 4 ->  writeln('Abril');
  (M is 5 ->  writeln('Mayo');
  (M is 6 ->  writeln('Junio');
  (M is 7 ->  writeln('Julio');
  (M is 8 ->  writeln('Agosto');
  (M is 9 ->  writeln('Septiembre');
  (M is 10 -> writeln('Octubre');
  (M is 11 -> writeln('Noviembre');
  (M is 12 -> writeln('Diciembre'); false))))))))))).