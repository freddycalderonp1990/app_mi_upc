import 'dart:ffi';

import 'package:get/get.dart';
import '../models/modulos.dart';
import '../models/servicios.dart';
import '../models/upc.dart';
import '../../core/exceptions/exception_helper.dart';
import '../../data/providers/providers_impl.dart';
import '../../domain/repositories/domain_repositories.dart';
import '../models/items.dart';

part 'local/local_store_impl.dart';
part 'remote/apis/modulos_api_impl.dart';
part 'remote/apis/servicios_api_impl.dart';
part 'remote/apis/items_api_impl.dart';
part 'remote/apis/mapa_upc_api_impl.dart';
part 'remote/apis/registro_usuario_api_impl.dart';
