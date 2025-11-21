# Museo Rijks App

Aplicación desarrollada en Flutter para explorar obras de arte y artistas de un museo virtual. Permite visualizar colecciones, buscar artistas y gestionar información.

## Captura de pantallas

<div style="display: flex; justify-content: center; gap: 20px;">
  <figure>
    <img src="assets/appImages/inicio.jpg" width="250">
    <figcaption>Inicio</figcaption>
  </figure>
  <figure>
    <img src="assets/appImages/pantalla1.jpg" width="250">
    <figcaption>Lista Obras</figcaption>
  </figure>
  <figure>
    <img src="assets/appImages/pantalla2.jpg" width="250">
    <figcaption>Lista Artistas</figcaption>
  </figure>
</div>

<div style="display: flex; justify-content: center; gap: 20px;">
  <figure>
    <img src="assets/appImages/pantalla4.jpg" width="250">
    <figcaption>Inicio</figcaption>
  </figure>
  <figure>
    <img src="assets/appImages/pantalla4.jpg" width="250">
    <figcaption>Lista Obras</figcaption>
  </figure>
  <figure>
    <img src="assets/appImages/pantalla5.jpg" width="250">
    <figcaption>Lista Artistas</figcaption>
  </figure>
</div>

## Características Principales

Características

*Galería de Obras: Visualiza todas las obras de arte disponibles en el museo
*Directorio de Artistas: Lista completa de artistas con funcionalidad de búsqueda
*Perfil de Artista: Información detallada del artista y sus obras
*Detalles de Obra: Vista ampliada con información completa de cada pieza
\*Gestión de Artistas: Formulario para crear y actualizar artistas (CRUD)

## Configuración y Dependencias

## Tecnologías y Dependencias

Flutter: Framework de desarrollo de aplicaciones móviles multiplataforma.
La aplicación utiliza las siguientes dependencias principales:

```
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  http: ^1.1.0                 # Peticiones HTTP
  flutter_dotenv: ^5.1.0       # Gestion variables de entorno
  provider: ^6.1.1             # Gestión de estado
```

API del Museo Rijks

La aplicación utiliza la api del Museo Rijks, para obtener información sobre las obras de arte. Puedes encontrar más información sobre la API en la siguiente dirección: https://museo-dwgk.onrender.com
