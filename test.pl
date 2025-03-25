% move(Origen, Destino, simbolo)
move(a1, a2, 'D').
move(a2,a5,e).
move(a2, a3,a).
move(a2,a9,i).
move(a3, a4, e).
move(a3,a6,r).
move(a3,a7,g).
move(a6,a4,o).
move(a7,a8,o).
move(a8,a4,r).
move(a5,a4,l).
move(a9,a4,n).

estado_aceptacion(a4).

analisisDFA(InputList) :-
    ayuda_analisis_DFA(InputList, a1).

ayuda_analisis_DFA([], EstadoActual) :-
    %Este sirve para corroborar si el estado actual es igual al aceptado de arriba
    estado_aceptacion(EstadoActual), 
    %Si este falla, se va abajo
    write('Accepted').
ayuda_analisis_DFA([Simbolo|Resto], EstadoActual) :-
    move(EstadoActual, SiguienteEstado, Simbolo),
    ayuda_analisis_DFA(Resto, SiguienteEstado).


pruebas_aceptadas():-
    write('Pruevas aceptadas'),nl,
    write("analisisDFA(['D',a,e])."),nl,
    analisisDFA(['D',a,e]),nl,
    write("analisisDFA(['D',a,g,o,r])."),nl,
    analisisDFA(['D',a,g,o,r]),nl,
    write("analisisDFA(['D',a,r,o])."),nl,
    analisisDFA(['D',a,r,o]),nl,
    write("analisisDFA(['D',e,l])."),nl,
    analisisDFA(['D',e,l]),nl,
    write("analisisDFA(['D',i,n])."),nl,
    analisisDFA(['D',i,n]),nl.


pruebas_fallidas():-
    write('Pruevas fallidas'),nl,
    write("analisisDFA(['D',i,n,o])."),nl,
    analisisDFA(['D',i,n,o]),nl|
    write("analisisDFA(['D',i,g,e,l])."),nl,
    analisisDFA(['D',i,g,e,l]),nl|
    write("analisisDFA(['D',i,l])."),nl,
    analisisDFA(['D',i,l]),nl|
    write("analisisDFA(['D',a,r])."),nl,
    analisisDFA(['D',a,r]),nl|
    write("analisisDFA(['D',a,r,o,n])."),nl,
    analisisDFA(['D',a,r,o,n]),nl.