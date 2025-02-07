VideoGamesIA
Esta aplicación permite a los usuarios gestionar un catálogo de videojuegos descargados desde una API pública. La app ofrece una interfaz intuitiva y funcional, desarrollada en SwiftUI utilizando la arquitectura MVVM con persistencia local mediante CoreData.

*Características principales*


1.- Carga Inicial
Descarga automática del catálogo de videojuegos desde la API:
https://www.freetogame.com/api/games 
Los datos se almacenan localmente en una base de datos para acceso offline.


2.-Pantalla de Búsqueda y Filtros
Búsqueda por nombre del videojuego o categoría.
Resultados con sugerencias automáticas.
Navegación al detalle del videojuego seleccionado.


3.- Pantalla de Detalle del Videojuego
Visualización de información detallada del videojuego (título, imagen, descripción, etc.).
Opciones para editar y eliminar (eliminación lógica) un registro.


4.- Persistencia de Datos
Los videojuegos se almacenan en CoreData para acceso rápido y eficiente.
Implementación de eliminación lógica para conservar los registros en la base de datos.


5.- Interfaz
UI responsiva y accesible, diseñada con SwiftUI.
Actualizaciones en tiempo real al realizar búsquedas o cambios en los registros.


*Arquitectura*
Patrón: MVVM (Model-View-ViewModel).
Persistencia: CoreData.
Consumo de API: URLSession con Combine.
Gestión de errores: Uso de operadores como catch en Combine.

-Instalación-
git clone https://github.com/tu-usuario/game-catalog-app.git

Pruebas unitarias implementadas con XCTest para validar la lógica del ViewModel y la correcta gestión de datos.

Tecnologías utilizadas:
- Swift 5
- SwiftUI
- Combine
- CoreData
- Xcode 16.1
