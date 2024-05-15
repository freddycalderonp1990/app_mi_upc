import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_config.dart';
import '../../core/services/auditoria.dart';
import '../../core/utils/check_internet_conexion.dart';
import '../../core/utils/photo_helper.dart';
import '../../core/utils/preferenciasUsuario.dart';
import '../../core/utils/responsiveUtil.dart';
import '../../core/utils/utilidadesUtil.dart';
import '../../core/values/app_images.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_widgets.dart';

import 'controllers.dart';

part 'splash/mi_upc_splash_page.dart';
part 'menu/menu_principal_page.dart';
part 'servicios/servicios_page.dart';
part 'acuerdo/acuerdo_page.dart';
part 'mapaUpc/mapa_upc_page.dart';
part 'registroUsuario/registro_usuario_page.dart';
