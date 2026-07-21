import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:io';

//NECESARIOS PARA SUBIR ARCHIVOS
import 'package:async/async.dart'; //DelegatingStream
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import '../models/modulos.dart';

import '../models/upc.dart';
import 'dart:io' as doc;

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_config.dart';
import '../../core/exceptions/exception_helper.dart';
import '../../core/exceptions/exceptions.dart';

import '../../domain/repositories/domain_repositories.dart';
import '../models/items.dart';
import '../models/models.dart';
import '../models/servicios.dart';

part 'local/mi_upc_local_store_provider.dart';

part 'remote/host/url_api_provider.dart';
part 'remote/host/cabecera_json_model.dart';
part 'remote/host/host.dart';
part 'remote/modulos_api_provider.dart';
part 'remote/servicios_api_provider.dart';
part 'remote/items_api_provider.dart';
part 'remote/mapa_upc_api_provider.dart';
part 'remote/registro_usuario_api_provider.dart';
