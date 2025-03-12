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

![image](https://github.com/user-attachments/assets/4db0b450-e38a-4e3c-97b9-1a622f1ebe44)

De igual manera Elena Jurado menciona que "Las gramáticas regulares generan lenguajes regulares que pueden ser representados mediante expresiones regulares. A su vez, estos lenguajes pueden ser reconocidos por Auómatas Finitoss" dejandonos que nuestro automata mencionado anteriormente de igual manera se puede mostrar en una expresión regular siendo la de nuestro caso:

^D(el$|a(ro|gor|e)$|in$)

# Implemetacion

# Pruebas
Para poder implementar nuestras pruevas de manera correcta, en el caso de la D, la guardaremos con comillas simples ya que de esta manera prolog no la tomará como variable, si no que la usará como un Átomo (una constante), ya que según la Universidad de Valladolid, la forma de guardar constantes átomo es:
- Empezando por minúsculas
- Puede tener "_" (subrayado)
- Si va entre comillas simples('Esta es la que nos interesa') cualquier carácter



# Análisis


# Referencias
Colaboradores de Wikipedia. (2024, 2 abril). Lenguas élficas. Wikipedia, la Enciclopedia Libre. https://es.wikipedia.org/wiki/Lenguas_%C3%A9lficas 

Jurado Málaga, J. Teoría de autómatas y lenguajes formales. Universidad de Extremadura, Servicio de Publicaciones, 2008. ISBN 978-84-691-6345-0 [http://hdl.handle.net/10662/2367] 

Universidad de Valladolid. (s. f.). Tema 2. La sintaxis [Diapositivas]. https://www.infor.uva.es/~calonso/IAI/PracticasProlog/Tema2/Tema%202.%20La%20Sintaxis.pdf
