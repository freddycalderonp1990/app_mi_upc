import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../core/app_config.dart';
import '../../core/utils/check_internet_conexion.dart';
import '../../core/utils/photo_helper.dart';
import '../../core/utils/responsiveUtil.dart';
import '../../core/utils/utilidadesUtil.dart';
import '../../core/values/app_images.dart';
import '../../data/models/models.dart';
import '../../data/models/modulos.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_widgets.dart';
import 'controllers.dart';


part 'splash/splash_page.dart';
part 'menu/menu_principal_page.dart';
part 'servicios/servicios_page.dart';
part 'acuerdo/acuerdo_page.dart';
part 'mapaUpc/mapa_upc_page.dart';
part 'registroUsuario/registro_usuario_page.dart';
part 'eventos/eventos_page.dart';

part 'vehiculos/vehiculos_page.dart';
part 'detalleAlertas/detalle_alertas_page.dart';
part 'alertasDelitos/alertas_delitos_page.dart';