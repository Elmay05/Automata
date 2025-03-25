:- use_module(library(pcre)).

analisisDFA(Palabra) :-
   regex_match('^D(el$|a(ro|gor|e)$|in$)', Palabra),
    write('Accepted').

regex_match(Regex, Atom) :-
    re_match(Regex, Atom). %Funcion que compara el atomo con expresión regular, ocupa modulo library(pcre)


pruebas_aceptadas():-
    write('Pruevas aceptadas'),nl,
    write("analisisDFA('Dae')."),nl,
    analisisDFA('Dae'),nl,
    write("analisisDFA('Dagor')."),nl,
    analisisDFA('Dagor'),nl,
    write("analisisDFA('Daro')."),nl,
    analisisDFA('Daro'),nl,
    write("analisisDFA('Del')."),nl,
    analisisDFA('Del'),nl,
    write("analisisDFA('Din')."),nl,
    analisisDFA('Din'),nl.


pruebas_fallidas():-
    write('Pruevas Fallidas'),nl,
    write("analisisDFA('Dino')."),nl,
    analisisDFA('Dino'),nl|
    write("analisisDFA('Digel')."),nl,
    analisisDFA('Digel'),nl|
    write("analisisDFA('Dil')."),nl,
    analisisDFA('Dil'),nl|
    write("analisisDFA('Dar')."),nl,
    analisisDFA('Dar'),nl|
    write("analisisDFA('Daron')."),nl,
    analisisDFA('Daron'),nl.

    

    
    
    