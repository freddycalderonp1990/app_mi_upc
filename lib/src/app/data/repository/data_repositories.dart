import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../core/exceptions/exception_helper.dart';
import '../../data/providers/providers_impl.dart';
import '../../domain/entities/evento_entity.dart';
import '../../domain/repositories/domain_repositories.dart';
import '../models/items.dart';
import '../models/itemsOffLine.dart';
import '../models/models.dart';
import '../models/modulos.dart';
import '../models/servicios.dart';
import '../models/upc.dart';


part 'local/local_store_impl.dart';
part 'remote/apis/modulos_api_impl.dart';
part 'remote/apis/servicios_api_impl.dart';
part 'remote/apis/items_api_impl.dart';
part 'remote/apis/mapa_upc_api_impl.dart';
part 'remote/apis/registro_usuario_api_impl.dart';

part 'remote/apis/registro_alerta_vehiculos_api_impl.dart';
part 'remote/apis/alerta_violencia_api_impl.dart';
part 'remote/apis/alertas_delitos_api_impl.dart';
