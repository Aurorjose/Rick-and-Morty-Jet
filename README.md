# Rick and Morty | Prueba técnica para AllInBicking.

# Cómo instalar

Para instalar la app, tendrás que acceder al directorio `example` y ejecutar `Flutter run`.

# Clean architecture

Esta prueba ha sido realizada siguiendo el método de desarrollo clean architecture:

- El directorio `example` se correspondería con la app.
- El directorio superior al de la app, se corresponde con el sdk que la app utiliza. Consta de 3 partes principales:
  - `data_layer`: Contiene los DTOs, los repositorios y proveedores de datos y el mappeado de DTOs a modelos (y viceversa). También contiene la librería para trabajar con el backend (`network`).
  - `domain_layer`: Contiene los repositorios abstractos, los modelos y los casos de uso los cuales se encargan de realizar una acción en específico y proveer datos a los cubits. Los repositorios abstractos permiten que se pueda cambiar de repositorios y proveedores de datos dependiendo de las necesidades de la app. Los use cases permiten testear pequeñas partes de la app con test unitarios.
  - `presentation_layer`: Contine un directorio de cubits que la app puede utilizar. En el caso de que este SDK fuera usado por varias app, los cubits específicos de cada app pasarían a estar en la app y en este directorio sólo se quedarían los cubits que pueden ser compartidos por las apps.

Esta estructura nos aporta beneficios tales cómo:

- Es fácil generar diferentes flavors para la app (dev, test, prod...) para trabajar en diferentes entornos de desarrollo.
- Se puede cambiar de repositorios y proveedores de datos de una manera sencilla sin tener que realizar grandes cambios en los demás elementos del SDK.
- El testeo unitario de los cubits es más sencillo, ya que no tenemos que preocuparnos de los repositorios y proveedores de datos, sólo de los estados que el cubit expone hacia la app. Los repositorios y proveedores de datos se pueden testear a nivel de cada método de manera individual en los test unitarios de los use cases que los cubits utilizan.
- Migrar a un nuevo repositorio para una nueva app es sencillo, ya que el SDK provee todo lo necesario para comenzar un nuevo desarrollo.

Se han utilizado varias clases con métodos o gettes estáticos en la app. Esto se ha hecho para simplificar la prueba técnica, pero en un caso real, estas clases pasarían a ser `InheritedWidgets` con una estructura diferente que podrían ser inyectados por encima de nuestra `MaterialApp` para proveer dicha clase a todo el widget tree. (Localizaciones, Temas, etc.)
