class InstructionStep {
  final String instruction;
  final double distance;
  final double duration;
  final String? modifier;
  final String? name;
  final String type;
  final double maneuverLat;
  final double maneuverLng;

  InstructionStep({
    required this.instruction,
    required this.distance,
    required this.duration,
    this.modifier,
    this.name,
    required this.type,
    required this.maneuverLat,
    required this.maneuverLng,
  });

  factory InstructionStep.fromJson(Map<String, dynamic> json) {
    final maneuver = json['maneuver'];
    final type = maneuver['type'] ?? '';
    final modifier = maneuver['modifier'] ?? '';
    final name = json['name'] ?? '';
    final distance = json['distance']?.toDouble() ?? 0.0;


    String instruction = _buildInstruction(type, modifier, name, distance);

    return InstructionStep(
      instruction: instruction,
      distance: distance,
      duration: json['duration']?.toDouble() ?? 0.0,
      modifier: modifier,
      name: name,
      type: type,
      maneuverLat: json['maneuver']['location'][1],
      maneuverLng: json['maneuver']['location'][0],
    );
  }

  static String _buildInstruction(String type, String modifier, String name, double distance) {
    String mod = modifier.isNotEmpty ? _traducirDireccion(modifier) : '';
    String calle = name.isNotEmpty ? ' hacia $name' : '';
    String dist = 'En ${distance.toStringAsFixed(0)} metros';

    switch (type) {
      case 'depart':
        return 'Empieza a conducir$calle';
      case 'arrive':
        return 'Has llegado a tu destino$calle';
      case 'turn':
      case 'end of road':
        return '$dist gire a la $mod$calle';
      default:
        return '$dist continúe recto$calle';
    }
  }

  static String _traducirDireccion(String modifier) {
    switch (modifier) {
      case 'left':
        return 'izquierda';
      case 'right':
        return 'derecha';
      case 'straight':
        return 'recto';
      default:
        return modifier;
    }
  }
}
