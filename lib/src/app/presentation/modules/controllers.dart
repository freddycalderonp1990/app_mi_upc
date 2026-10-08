import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_mi_upc/src/app/presentation/modules/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../core/app_config.dart';
import '../../core/change_notifier/connection_status_change_notifier.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/services/google_auth_service.dart';
import '../../core/utils/check_internet_conexion.dart';
import '../../core/utils/deviceNetworkHelper.dart';
import '../../core/utils/device_info.dart';
import '../../core/utils/feactures/saveFile/domain/request/file_request.dart';
import '../../core/utils/feactures/saveFile/domain/use_cases/save_file_img_use_case.dart';
import '../../core/utils/file_adjunto_helper.dart';
import '../../core/utils/my_date.dart';
import '../../core/utils/my_gps.dart';
import '../../core/utils/photo_helper.dart';
import '../../core/utils/utilidadesUtil.dart';
import '../../data/models/items.dart';
import '../../data/models/itemsOffLine.dart';
import '../../data/models/models.dart';
import '../../data/models/modulos.dart';
import '../../data/models/servicios.dart';
import '../../data/models/upc.dart';
import '../../data/repository/data_repositories.dart';
import '../../domain/entities/evento_entity.dart';
import '../../domain/repositories/domain_repositories.dart';
import '../gps/gps_impl_helper.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_widgets.dart';
import 'package:geolocator/geolocator.dart' as myGeolocator;
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';

import 'mapaUpc/includes/claseInstructionStep.dart';
import 'dart:typed_data';

part 'splash/splash_controller.dart';
part 'menu/menu_principal_controller.dart';
part 'servicios/servicios_controller.dart';
part 'acuerdo/acuerdo_controller.dart';
part 'mapaUpc/mapa_upc_controller.dart';
part 'registroUsuario/registro_usuario_controller.dart';

part 'eventos/eventos_controller.dart';
part 'vehiculos/vehiculos_controller.dart';
part 'detalleAlertas/detalle_alertas_controller.dart';
part 'alertasDelitos/alertas_delitos_controller.dart';