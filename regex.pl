:- use_module(library(pcre)).

analisisDFA(Palabra) :-
   regex_match('^D(el$|a(ro|gor|e)$|in$)', Palabra),
    write('Accepted').

regex_match(Regex, Atom) :-
    re_match(Regex, Atom). %Funcion que compara el atomo con expresión regular, ocupa modulo library(pcre)
