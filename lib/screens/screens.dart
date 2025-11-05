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
export '../providers/obra_provider.dart';
export '../providers/obra_detalle_provider.dart';

//Paquete widgets
export 'package:app_demo/widgets/navegacion.dart';
export 'package:app_demo/widgets/drawer_menu.dart';
export 'package:app_demo/widgets/full_screen.dart';
export 'package:app_demo/widgets/galeria_card.dart';
export 'package:app_demo/widgets/tarjeta_artista.dart';
export 'package:app_demo/widgets/gif_loading.dart';
export 'package:app_demo/widgets/titulos.dart';
export 'package:app_demo/widgets/detalles.dart';
export 'package:app_demo/widgets/descripcion.dart';
export 'package:app_demo/widgets/paginacion.dart';
export 'package:app_demo/widgets/app_bar.dart';
export 'package:app_demo/widgets/cabecera.dart';
export 'package:app_demo/widgets/info_card.dart';
export 'package:app_demo/widgets/seccion.dart';
export 'package:app_demo/widgets/extra_info.dart';
export 'package:app_demo/widgets/titulo_extra.dart';
export 'package:app_demo/widgets/error_msg.dart';

//Paquete Screens
export 'package:app_demo/screens/inicio.dart';
export 'package:app_demo/screens/artista/galeria_artista.dart';
export 'package:app_demo/screens/artista/buscador_artista.dart';
export 'package:app_demo/screens/obras/galeria.dart';
export 'package:app_demo/screens/obras/obra_screen.dart';

//Paquete modelos
export 'package:app_demo/models/obra_model.dart';
export 'package:app_demo/models/obra_detalle_model.dart';
export 'package:app_demo/models/fecha_model.dart';
export 'package:app_demo/models/artista_model.dart';
export 'package:app_demo/models/titulo_alternativo_model.dart';
export 'package:app_demo/models/img_model.dart';
export 'package:app_demo/models/api_respuesta_model.dart';
export 'package:app_demo/models/paginacion_model.dart';
//paquete servicio
export 'package:app_demo/services/obra_detalle_servicio.dart';
export 'package:app_demo/services/obra_servicio.dart';

//paquete temas
export 'package:app_demo/theme/theme.dart';
