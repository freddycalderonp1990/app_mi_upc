
import 'dart:async';
import 'dart:typed_data';

import '../../data/models/items.dart';
import '../../data/models/itemsOffLine.dart';
import '../../data/models/models.dart';
import '../../data/models/modulos.dart';
import '../../data/models/servicios.dart';
import '../../data/models/upc.dart';
import '../entities/evento_entity.dart';


part 'local/local_storage_repository.dart';
part 'remote/apis/modulos_repository.dart';
part 'remote/apis/servicios_repository.dart';
part 'remote/apis/items_repository.dart';
part 'remote/apis/mapa_upc_repository.dart';
part 'remote/apis/registro_usuario_respository.dart';
part 'remote/apis/registro_alerta_vehiculos.dart';
part 'remote/apis/alerta_violencia_repository.dart';
part 'remote/apis/alertas_delitos_repository.dart';