# Autómata
Omar Emilio Casillas Alday - A01712114

# Descripción
El idioma élfico es un idioma Wikipedia (2024)"dentro del universo ficticio creado por J.R.R Tolkien" Tolkien dedicó muchos años a la creación de estas lenguas élficas, él era filólogo de profesión, dentro de las lenguas élficas más desarrolladas están el quenya (hablado por Altos Elfos Noldor) y el sindarin (Usada por los Elfos Grises).
Las palabras de este idioma que utilizaré en este proyecto son:
* Dae - 'Sombra'.
* Dagor - Del Sindarin para 'Batalla'.
* Daro - Palabra Sindarin que significa 'Descender'.
* Del - 'Horror'.
* Din - 'Silencioso'.

Para este proyecto ocuparemos un AFD (Autómata Finito Determinístico), estos, según el libro "Teoría de autómatas y lenguajes formales" escrito por Elena Jurado Málaga, "Los Autómatas Finitos son máquinas teóricas que van cambiando de estado dependiendo de la entrada que reciban." en estos autómatas solo existen 2 tipos de salidas: aceptado y no aceptado.

# Modelos
Para nuestro caso, nuestro autómata solo será válido para las palabras ya mencionadas, por ende solo para ese alfabeto, siendo este:
A={D, a,e,g,o,r,l,i,n}
Para el cual, obtuvimos este diagrama para el autómata:

![image](https://github.com/user-attachments/assets/73eaa9fc-3fc6-4eeb-b00e-992106bf8d4c)

Según Elena Jurado Málaga, Este modelo se considera como Autómata Incompleto ya que tiene situaciones que no están definidas, las cuales deberían considerarse como situaciones de error, tambien menciona que "Si una cadena hace llegar al autómata hasta una situación no definida, consideraremos que la cadena no ha sido reconocida por dicho autómata" dejándonos que no está mal la implementación, ya que al no ser parte de las situaciones, marcaría falso (siendo la respuesta que buscamos), sin embargo, hay una manera de implementarlo de manera completa, para la cual se consideran todos los casos, esta quedaría de esta manera:

![image](https://github.com/user-attachments/assets/599cf319-3c73-42bd-9019-a71f06f28757)

https://dehesa.unex.es:8443/flexpaper/template.html?path=https://dehesa.unex.es:8443/bitstream/10662/2367/1/978-84-691-6345-0.pdf#page=58 

De igual manera Elena Jurado menciona que "Las gramáticas regulares generan lenguajes regulares que pueden ser representados mediante expresiones regulares. A su vez, estos lenguajes pueden ser reconocidos por Autómatas Finitos" dejándonos que nuestro autómata mencionado anteriormente de igual manera se puede mostrar en una expresión regular siendo la de nuestro caso:

^D(el$|a(ro|gor|e)$|in$)

# Implementación
### Automata
Ya que tenemos definido nuestro autómata, ahora lo traducimos a un archivo prolog, para esto primero definimos los estados, el origen, el destino y el símbolo que los mueve a ese destino.
```prolog
% move(Origen, Destino, símbolo)
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
```
Una vez que tenemos esto, ya podemos empezar a trabajar nuestras reglas, comenzando por el estado de aceptación el cual nos ayudará a verificar si los arreglos dados son verdaderos o falsos, en nuestro caso será a4, todo fuera de este estado se considerará falso
```prolog
estado_aceptacion(a4).
```
Ya que tenemos nuestros estados y los símbolos que nos llevan a ellos, comenzaremos a implementar las reglas que nos ayudarán a recorrer los arreglos.

Tenemos nuestra función que será llamada en la terminal 
```prolog
analisisDFA(InputList) :-
    ayuda_analisis_DFA(InputList, a1).
```
Ésta recibe una lista la cual es mandada a otra función que nos ayudará a revisar el DFA junto con el estado inicial ya definido (a1).

Una vez que se envía el arreglo con el estado inicial, se ejecuta la regla "ayuda_analisis_DFA"
```prolog
ayuda_analisis_DFA([], EstadoActual) :-
    %Este sirve para corroborar si el estado actual es igual al aceptado de arriba
    estado_aceptacion(EstadoActual), 
    %Si este falla, se va abajo
    write('Accepted').
```
Tenemos este caso base el cual se ejecutará cuando el arreglo esté vacío, en este se pasa la regla "estado_aceptacion" junto con el estado en el que terminó el recorrido, como esa regla la definimos anteriormente con un átomo y no una variable, lo que hace es que comparará el estado declarado con el actual, si es el mismo, mandará un mensaje a la consola mencionando que fue aceptado, de lo contrario, se saldrá de la regla y al no tener otro caso con arreglo vacío, prolog lo marcará como falso.

Nuestra siguiente regla es:
```prolog
ayuda_analisis_DFA([Simbolo|Resto], EstadoActual) :-
    move(EstadoActual, SiguienteEstado, Simbolo),
    ayuda_analisis_DFA(Resto, SiguienteEstado).
```
Prolog utiliza esta regla mientras el arreglo enviado por "analisisDFA" no esté vacío, en esta separamos la cabeza del arreglo con el resto y lo comparamos con el estado actual, (en la primer iteración el estado actual es a1 ya que es el inicial) y ejecutamos la regla "move(Origen, Destino, simbolo)", ésta la declaramos anteriormente con átomos, que, como ya mencionamos, esto hace que compare los datos en lugar de rellenar los datos(esto si fueran variables).Prolog comparará con cada una de los "move" hasta encontrar con uno que coincida como al momento de pasarlo, solo enviamos el "EstadoActual" y el "Simbolo", prolog al encontrar el match, rellenará la variable "SiguienteEstado" con el dato con el que hizo match, si no coincide, devolverá falso, de lo contrario llama nuevamente a la función "ayuda_analisis_DFA" pero ahora manda el resto de la cadena y el estado siguiente (siendo este el que encontró con el match) ya que ese es ahora el "Estado Actual".
Toda esta codificación se encuentra en el archivo [test.pl](https://github.com/Elmay05/Automata/blob/main/test.pl), si la palabra se encuentra en el idioma devuelve verdadero, de lo contrario, falso, recordando que la mayuscula inicial (D) se debe escribir entre 'comillas simples' para ser aceptada, si no, prolog la tomará como variable.

### Expresión regular
Por otro lado, tenemos nuestra expreción regular, para esta ocupamos un codigo mas corto el cual fue 
```Prolog
:- use_module(library(pcre)).

analisisDFA(Palabra) :-
   regex_match('^D(el$|a(ro|gor|e)$|in$)', Palabra),
    write('Accepted').

regex_match(Regex, Atom) :-
    re_match(Regex, Atom). %Funcion que compara el atomo con expresión regular, ocupa modulo library(pcre)


```
En este hacemos uso del módulo "library(pcre)", comenzamos analizando nuestra palabra (recordando que esta se escribe entre comillas por la mayúscula inicial y trabajamos con átomos), esta palabra la mandamos a la función que analizará el átomo con la expresión regular, aquí ocupamos el módulo que incluimos con la función "re_match" esta comparará el átomo con la expresión regular que le mandamos.
https://www.swi-prolog.org/pldoc/doc_for?object=re_match/2
# Pruebas
Para poder implementar nuestras pruebas de manera correcta, en el caso de la D, la guardaremos con comillas simples ya que de esta manera prolog no la tomará como variable, si no que la usará como un Átomo (una constante), ya que, según la Universidad de Valladolid, la forma de guardar constantes átomo es:
- Empezando por minúsculas
- Puede tener "_" (subrayado)
- Si va entre comillas simples('Esta es la que nos interesa') cualquier carácter.
### Automata
Para ejecutar el programa, hay que abrir el programa [test.pl](https://github.com/Elmay05/Automata/blob/main/test.pl) en una terminal de prolog. En el caso de Windows, se coloca el directorio donde se encuentra el archivo con cd *Inserte ruta donde está el archivo* y se escribe swipl test.pl
### Expresión regular
Para ejecutar el programa, hay que abrir el programa [regex.pl](https://github.com/Elmay05/Automata/blob/main/regex.pl) en una terminal de prolog. En el caso de Windows, se coloca el directorio donde se encuentra el archivo con cd *Inserte ruta donde está el archivo* y se escribe swipl regex.pl
### Pruebas exitosas Automata
A continuación se muestran los comandos con los que prolog debería devolver verdadero ya que son palabras definidas en el autómata y lenguaje:
- analisisDFA(['D',a,e]).
- analisisDFA(['D',a,g,o,r]).
- analisisDFA(['D',a,r,o]).
- analisisDFA(['D',e,l]).
- analisisDFA(['D',i,n]).
### Pruebas exitosas expresión regular
A continuación se muestran los comandos con los que prolog debería devolver verdadero ya que son palabras definidas en el autómata y lenguaje:
- analisisDFA('Dae').
- analisisDFA('Dagor').
- analisisDFA('Daro').
- analisisDFA('Del').
- analisisDFA('Din').
### Pruebas fallidas Automata
A continuación se muestran palabras formadas parecidas a las del lenguaje y con el mismo abecedario pero al no estar en él, estas serán devueltas con falso:
- analisisDFA(['D',i,n,o]).
- analisisDFA(['D',i,g,e,l]).
- analisisDFA(['D',i,l]).
- analisisDFA(['D',a,r]).
- analisisDFA(['D',a,r,o,n]).
### Pruebas fallidas expresión regular
A continuación se muestran palabras formadas parecidas a las del lenguaje y con el mismo abecedario pero al no estar en él, estas serán devueltas con falso:
- analisisDFA('Dino').
- analisisDFA('Digel').
- analisisDFA('Dil').
- analisisDFA('Dar').
- analisisDFA('Daron').

# Análisis
### Complejidad temporal 
Este programa utiliza recursión ya que así suele trabajar prolog, en específico, utiliza el derecha tail, esto ya que el programa acaba cuando el arreglo fue recorrido por completo, ya no tiene más operaciones ni motivo para regresar en las funciones ya pasadas (como lo sería con la recursividad izquierda/Head).
Al ser un código que acaba al recorrer todo el arreglo, se podría decir que actúa similar a un ciclo "for" recorriendo el largo del arreglo, por ello mismo, podemos concluir que la complejidad asintótica de este programa es de O(n).
### Complejidad espacial
Para la implementacion del regex, tenemos una complejidad de O(1) ya que simplemente ocupamos la memoria para la cadena de entrada y la expresión regular.
En cambio, para el Automata, ocupamos n+1 llamadas a memoria, n por la parte de resto de la cadena que enviamos [H|R] y una mas para verificar si la cadena ya está vacía y verificar el estado de aceptación, entonces en este caso tenemos una complejidad temporal de O(n).
### Otras implementaciones
Respecto a otras soluciones, pregunté a Chat GPT sobre alguna otra manera de implementar este código, a lo que me respondió con hacer uso de diccionarios:
```prolog
% Definir transiciones en un diccionario
% Definir el diccionario de transiciones
transiciones_dict(Dict) :-
    Dict = _{
        a1: [('D', a2)],
        a2: [('e', a5), ('a', a3), ('i', a9)],
        a3: [('e', a4), ('r', a6), ('g', a7)],
        a6: [('o', a4)],
        a7: [('o', a8)],
        a8: [('r', a4)],
        a5: [('l', a4)],
        a9: [('n', a4)]
    }.

% Estado de aceptación
estado_aceptacion(a4).

% Función para mover de un estado a otro usando el diccionario
move(EstadoActual, SiguienteEstado, Simbolo) :-
    transiciones_dict(Dict),
    get_dict(EstadoActual, Dict, Transiciones),  % Obtiene la lista de transiciones del estado actual
    member((Simbolo, SiguienteEstado), Transiciones).  % Verifica si existe la transición

% Función principal para analizar cadenas en el DFA
analisisDFA(InputList) :-
    ayuda_analisis_DFA(InputList, a1).

ayuda_analisis_DFA([], EstadoActual) :-
    estado_aceptacion(EstadoActual),
    write('Accepted').

ayuda_analisis_DFA([Simbolo|Resto], EstadoActual) :-
    move(EstadoActual, SiguienteEstado, Simbolo),
    ayuda_analisis_DFA(Resto, SiguienteEstado).
```
Podemos ver que en esta implementación se crea el diccionario de los estados en el cual es más fácil la visualización de las transiciones ya que están agrupadas, se ve más organizado, de igual manera el acceso es más rápido a todas las transiciones al hacerlas en una misma consulta a diferencia del que implementé en el que tiene que recorrer cada "move", de igual manera, considero que al estar más organizado, es más fácil realizar modificaciones a las transiciones.
Algunas de las desventajas es que para cada ejecución del move ocupa cargar y definir el diccionario al igual que, según la AcademiaLab, los diccionarios no son una estructura nativa de prolog, haciendo que no sea tan eficiente en algunas implementaciones del lenguaje
https://academia-lab.com/enciclopedia/comparacion-de-implementaciones-de-prolog/.

# Referencias
Colaboradores de Wikipedia. (2024, 2 abril). Lenguas élficas. Wikipedia, la Enciclopedia Libre. https://es.wikipedia.org/wiki/Lenguas_%C3%A9lficas 

Jurado Málaga, J. Teoría de autómatas y lenguajes formales. Universidad de Extremadura, Servicio de Publicaciones, 2008. ISBN 978-84-691-6345-0 [http://hdl.handle.net/10662/2367] 

Universidad de Valladolid. (s. f.). Tema 2. La sintaxis [Diapositivas]. https://www.infor.uva.es/~calonso/IAI/PracticasProlog/Tema2/Tema%202.%20La%20Sintaxis.pdf

Comparación de implementaciones de Prolog. (s.f.). En AcademiaLab. Recuperado de https://academia-lab.com/enciclopedia/comparacion-de-implementaciones-de-prolog/

re_match/2. (s. f.). https://www.swi-prolog.org/pldoc/doc_for?object=re_match/2
