# Museo Rijks App

Aplicación desarrollada en Flutter para explorar obras de arte y artistas de un museo virtual. Permite visualizar colecciones, buscar artistas y gestionar información.

## Captura de pantallas

<table width="100%">
  <tr>
    <td align="center" width="33%">
      <img src="assets/appImages/inicio.jpg" width="250" alt="Inicio"/><br/>
      <b>Inicio</b>
    </td>
    <td align="center" width="33%">
      <img src="assets/appImages/pantalla1.jpg" width="250" alt="Lista Obras"/><br/>
      <b>Lista Obras</b>
    </td>
    <td align="center" width="33%">
      <img src="assets/appImages/pantalla2.jpg" width="250" alt="Lista Artistas"/><br/>
      <b>Lista Artistas</b>
    </td>
  </tr>
</table>

<div style="display: flex; justify-content: center; gap: 20px;">
  <figure>
    <img src="assets/appImages/pantalla3.jpg" width="250">
    <figcaption><strong>Inicio</strong></figcaption>
  </figure>
  <figure>
    <img src="assets/appImages/pantalla4.jpg" width="250">
    <figcaption><stronge>Lista Obras</stronge></figcaption>
  </figure>
  <figure>
    <img src="assets/appImages/pantalla5.jpg" width="250">
    <figcaption><stronge>Lista Artistas</stronge></figcaption>
  </figure>
</div>

## Características Principales

Características

> Galería de Obras: Visualiza todas las obras de arte disponibles en el museo

> Directorio de Artistas: Lista completa de artistas con funcionalidad de búsqueda

> Perfil de Artista: Información detallada del artista y sus obras

> Detalles de Obra: Vista ampliada con información completa de cada pieza

> Gestión de Artistas: Formulario para crear y actualizar artistas (CRUD)

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
