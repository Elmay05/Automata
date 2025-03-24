# Automata
Omar Emilio Casillas Alday - A01712114

# Descripción
El idioma élfico es un idioma Wikipedia(2024)"dentro del universo ficticio creado por J.R.R Tolkien" Tolkien dedicó muchos años a la creacion de estas lenguas elficas, el era filólogo de profesion, dentro de las lenguas eéñficas mas desarrolladas están el quenya (hablado por Altos Elfos Noldor) y el sindarin (Usada por los Elfos Grises).
Las palabras de este idioma que utilizaré en este proyecto son:
* Dae - 'Sombra'.
* Dagor - Del Sindarin para 'Batalla'.
* Daro - Palabra Sindarin que significa 'Descender'.
* Del - 'Horror'.
* Din - 'Silencioso'.

Para este proyecto ocuparemos un AFD (Automata Finito Deterministico), estos, segun el libro "Teoría de autómatas y lenguajes formales" escrito por Elena Jurado Málaga, "Los Autómatas Finitos son máquinas teóricas que van cambiando de estado dependiendo de la entrada que reciban." en estos automatas solo exisen 2 tipos de salidas: aceptado y no aceptado.

# Modelos
Para nuestro caso, nuestro automata solo será valido para las palabras ya mencionadas, por ende solo para ese alfabeto, siendo este:
A={D,a,e,g,o,r,l,i,n}
Para el cual, obtubimos este diagrama para el automata:

![image](https://github.com/user-attachments/assets/73eaa9fc-3fc6-4eeb-b00e-992106bf8d4c)

Segun Elena Jurado Málaga, Este modelo se considera como Automata Incompleto ya que tiene situaciones que no están definidas, las cuales deberían considerarse como situaciones de error, tambien menciona que "Si una cadena hace llegar al automata hasta una situación no definida, consideraremos que la cadena no ha sido reconocida por dicho autómata" dejandonos que no está mal la implementacion, ya que al no ser parte de las situaciones, marcaría falso (siendo la respuesta que buscamos), sin embargo, hay una manera de implementarlo de manera completa, para la cual se consideran todos los casos, esta quedaría de esta manera:

![image](https://github.com/user-attachments/assets/599cf319-3c73-42bd-9019-a71f06f28757)


https://dehesa.unex.es:8443/flexpaper/template.html?path=https://dehesa.unex.es:8443/bitstream/10662/2367/1/978-84-691-6345-0.pdf#page=58 

De igual manera Elena Jurado menciona que "Las gramáticas regulares generan lenguajes regulares que pueden ser representados mediante expresiones regulares. A su vez, estos lenguajes pueden ser reconocidos por Auómatas Finitoss" dejandonos que nuestro automata mencionado anteriormente de igual manera se puede mostrar en una expresión regular siendo la de nuestro caso:

^D(el$|a(ro|gor|e)$|in$)

# Implemetacion
Ya que tenemos definido nuestro automata, ahora lo traducimos a un archivo prolog, para esto primero definimos los estados, el origen, el destino y el simbolo que los mueve a ese destino.
```prolog
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
```
Una vez que tenemos esto, ya podemos empezar a trabajar nuestras reglas, comenzando por el estado de aceptacion el cual nos ayudará a verificar si los arreglos dados son verdaderos o falsos, en nuestro caso será a4, todo fuera de este estado se considerará falso
```prolog
estado_aceptacion(a4).
```
Ya que tenemos nuestros estados y los simbolos que nos llevan a ellos, comenzaremos a implementar las reglas que nos ayudarán a recorrer los arreglos.

Tenemos nuestra funcion que será llamada en la terminal 
```prolog
analisisDFA(InputList) :-
    ayuda_analisis_DFA(InputList, a1).
```
Estat resive una lista la cual es mandada a otra funcion qeu nos ayudará a revisar el DFA junto con el estado inicial ya definido (a1).

Una vez que se envia el arreglo con el estado inicial, se ejecuta la regla "ayuda_analisis_DFA"
```prolog
ayuda_analisis_DFA([], EstadoActual) :-
    %Este sirve para corroborar si el estado actual es igual al aceptado de arriba
    estado_aceptacion(EstadoActual), 
    %Si este falla, se va abajo
    write('Accepted').
```
Tenemos este caso base el cual se ejecutará cuando el arreglo esté vacío, en este se pasa la regla "estado_aceptacion" junto con el estado en el qeu terminó el recorrido, como esa regla la definimos anteriormente con un atomo y no una variable, lo que hace es que comparará el estado declarado con el actual, si es el mismo, mandará un mensaje a la consola mencionando que fue aceptado, de lo contrario, se saldrá de la regla y al no tener otro caso con arreglo vacío, prolog lo marcará como falso.

Nuestra siguiente regla es:
```prolog
ayuda_analisis_DFA([Simbolo|Resto], EstadoActual) :-
    move(EstadoActual, SiguienteEstado, Simbolo),
    ayuda_analisis_DFA(Resto, SiguienteEstado).
```
Prolog utiliza esta regla mientras el arreglo enviado por "analisisDFA" no esté vacío, en esta separamos la cabeza del arreglo con el resto y lo comparamos con el estado actual, (en la primer iteración el estado actual es a1 ya que es el inicial) y ejecutamos la regla "move(Origen, Destino, simbolo)", esta la declaramos anteriormente con atomos, que, como ya mencionamos, esto hace que compare los datos en lugar de rellenar los datos(esto si fueran variables).Prolog comparará con cada una de los "move" hasta encontrar con uno que coinsida,como al momento de pasarlo, solo enviamos el "EstadoActual" y el "Simbolo", prolog al encontrar el match, rellenará la variable "SiguienteEstado" con el dato con el que hizo match, si no coincide, devolverá falso, de lo contrario llama nuevamente a la función "ayuda_analisis_DFA" pero ahora manda el resto de la cadena y el estado siguiente (siendo este el que encontró con el match) ya que ese es ahora el "Estado Actual".
Toda esta codificacion se encuentra en el archivo [test.pl](https://github.com/Elmay05/Automata/blob/main/test.pl), si la palabra se encuentra en el idioma devuelve verdadero, de lo contrario, falso, recordando que la mayuscula inicial (D) se debe escribir entre 'comillas simples' para ser aceptada, si no, prolog la tomará como variable.

# Pruebas
Para poder implementar nuestras pruevas de manera correcta, en el caso de la D, la guardaremos con comillas simples ya que de esta manera prolog no la tomará como variable, si no que la usará como un Átomo (una constante), ya que según la Universidad de Valladolid, la forma de guardar constantes átomo es:
- Empezando por minúsculas
- Puede tener "_" (subrayado)
- Si va entre comillas simples('Esta es la que nos interesa') cualquier carácter.
Para ejecutar el programa, hay que abrir el programa [test.pl](https://github.com/Elmay05/Automata/blob/main/test.pl) en una terminal de prolog. En el caso de Windows, se coloca el directorio donde se encuentra el archivo con cd *Inserte ruta donde está el archivo* y se escribe swipl test.pl

## Pruevas exitosas
A continuacion se muestran los comandos con los que prolog debería devolver verdadero ya que son palabras definidas en el autómata y lenguaje:
- analisisDFA(['D',a,e]).
- analisisDFA(['D',a,g,o,r]).
- analisisDFA(['D',a,r,o]).
- analisisDFA(['D',e,l]).
- analisisDFA(['D',i,n]).

## Pruevas fallidas
A continuacion se muestran palabras formadas parecidas a las del lenguaje y con el mismo abecedario pero al no estar en él, estas serán devueltas con falso:
- analisisDFA(['D',i,n,o]).
- analisisDFA(['D',i,g,e,l]).
- analisisDFA(['D',i,l]).
- analisisDFA(['D',a,r]).
- analisisDFA(['D',a,r,o,n]).

# Análisis


# Referencias
Colaboradores de Wikipedia. (2024, 2 abril). Lenguas élficas. Wikipedia, la Enciclopedia Libre. https://es.wikipedia.org/wiki/Lenguas_%C3%A9lficas 

Jurado Málaga, J. Teoría de autómatas y lenguajes formales. Universidad de Extremadura, Servicio de Publicaciones, 2008. ISBN 978-84-691-6345-0 [http://hdl.handle.net/10662/2367] 

Universidad de Valladolid. (s. f.). Tema 2. La sintaxis [Diapositivas]. https://www.infor.uva.es/~calonso/IAI/PracticasProlog/Tema2/Tema%202.%20La%20Sintaxis.pdf
