//Paquete de flutter
export 'package:flutter/material.dart';
export 'dart:io';
export 'dart:convert';

//Paquete configuración
export '../config/api_config.dart';

//Paquete provider
export 'package:app_demo/providers/museo_service.dart';
export 'package:app_demo/providers/pagina_handler.dart';
export 'package:app_demo/providers/theme_provider.dart';
export 'package:provider/provider.dart';
export 'package:app_demo/providers/obra_provider.dart';
export 'package:app_demo/providers/obra_detalle_provider.dart';
export 'package:app_demo/providers/artista_provider.dart';
export 'package:app_demo/providers/peticiones_base_provider.dart';
export 'package:app_demo/providers/ocupacion_provider.dart';

//Paquete widgets
export 'package:app_demo/widgets/navegacion.dart';
export 'package:app_demo/widgets/drawer_menu.dart';
export 'package:app_demo/widgets/imagen/full_screen.dart';
export 'package:app_demo/widgets/obra/galeria_card.dart';
export 'package:app_demo/widgets/imagen/gif_loading.dart';
export 'package:app_demo/widgets/paginacion_control.dart';
export 'package:app_demo/widgets/obra/app_bar.dart';
export 'package:app_demo/widgets/obra/cabecera.dart';
export 'package:app_demo/widgets/obra/info_card.dart';
export 'package:app_demo/widgets/obra/seccion.dart';
export 'package:app_demo/widgets/obra/extra_info.dart';
export 'package:app_demo/widgets/obra/titulo_extra.dart';
export 'package:app_demo/widgets/recurso_no_encontrado.dart';
export 'package:app_demo/widgets/obra/lista_info.dart';
export 'package:app_demo/widgets/artista/tarjeta_artista.dart';
export 'package:app_demo/widgets/artista/tarjeta_artista_detalle.dart';
export 'package:app_demo/widgets/obra/card_img.dart';
export 'package:app_demo/widgets/form/selector_ocupacion.dart';
export 'package:app_demo/widgets/resApi/mensaje_api.dart';

//Paquete Screens
export 'package:app_demo/screens/inicio.dart';
export 'package:app_demo/screens/artista/obras_artista_screen.dart';
export 'package:app_demo/screens/artista/artistas_screen.dart';
export 'package:app_demo/screens/obras/galeria_obras_screen.dart';
export 'package:app_demo/screens/obras/obra_detalle_screen.dart';
export 'package:app_demo/screens/artista/artista_form_screen.dart';

//Paquete modelos
export 'package:app_demo/models/obra_model.dart';
export 'package:app_demo/models/obra_detalle_model.dart';
export 'package:app_demo/models/fecha_model.dart';
export 'package:app_demo/models/artista_model.dart';
export 'package:app_demo/models/titulo_alternativo_model.dart';
export 'package:app_demo/models/img_model.dart';
export 'package:app_demo/models/api_respuesta_model.dart';
export 'package:app_demo/models/paginacion_model.dart';
export 'package:app_demo/models/ocupacion_model.dart';
//paquete servicio
export 'package:app_demo/services/obra_detalle_servicio.dart';
export 'package:app_demo/services/obra_servicio.dart';
export 'package:app_demo/services/artista_servicio.dart';
export 'package:app_demo/services/api_service.dart';
export 'package:app_demo/services/ocupacion_service.dart';

//paquete temas
export 'package:app_demo/theme/theme.dart';

//errores
export 'package:app_demo/errors/entidad_no_encontrada.dart';
export 'package:app_demo/errors/widget_error.dart';
export 'package:app_demo/errors/api_exception.dart';
