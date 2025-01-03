import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:network_info_plus/network_info_plus.dart';

import '../../data/models/items.dart';

import '../../core/app_config.dart';
import '../../core/change_notifier/connection_status_change_notifier.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/utils/check_internet_conexion.dart';
import '../../core/utils/device_info.dart';
import '../../core/utils/my_date.dart';

import '../../core/utils/utilidadesUtil.dart';
import '../../core/values/app_images.dart';
import '../../data/models/models.dart';
import '../../data/models/modulos.dart';
import '../../data/models/servicios.dart';
import '../../data/models/upc.dart';
import '../../data/repository/data_repositories.dart';

import '../routes/app_routes.dart';
import '../widgets/custom_widgets.dart';


part 'splash/mi_upc_splash_controller.dart';
part 'menu/menu_principal_controller.dart';
part 'servicios/servicios_controller.dart';
part 'acuerdo/acuerdo_controller.dart';

part 'registroUsuario/registro_usuario_controller.dart';
