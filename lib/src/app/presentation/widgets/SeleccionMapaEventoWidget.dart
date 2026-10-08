part of 'custom_widgets.dart';

class SeleccionMapaEventoWidget extends StatefulWidget {
  final double latInicial;
  final double lngInicial;
  final Function(double lat, double lng) onUbicacionSeleccionada;

  const SeleccionMapaEventoWidget({
    super.key,
    required this.latInicial,
    required this.lngInicial,
    required this.onUbicacionSeleccionada,
  });

  @override
  State<SeleccionMapaEventoWidget> createState() =>
      _SeleccionMapaEventoWidgetState();
}

class _SeleccionMapaEventoWidgetState
    extends State<SeleccionMapaEventoWidget> {
  late LatLng puntoSeleccionado;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    puntoSeleccionado = LatLng(widget.latInicial, widget.lngInicial);
  }

  @override
  void didUpdateWidget(covariant SeleccionMapaEventoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.latInicial != widget.latInicial ||
        oldWidget.lngInicial != widget.lngInicial) {
      final nuevoPunto = LatLng(widget.latInicial, widget.lngInicial);

      setState(() {
        puntoSeleccionado = nuevoPunto;
      });

      mapController.move(nuevoPunto, mapController.camera.zoom);
    }
  }

  void _actualizarPunto(LatLng point) {
    setState(() {
      puntoSeleccionado = point;
    });
    widget.onUbicacionSeleccionada(point.latitude, point.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD7E3F1)),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: puntoSeleccionado,
              initialZoom: 16,
              minZoom: 5,
              maxZoom: 18,
              onTap: (tapPosition, point) {
                _actualizarPunto(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://a.tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'mmeo.system.pne',
                maxZoom: 19,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: puntoSeleccionado,
                    width: 56,
                    height: 56,
                    child: const Icon(
                      Icons.location_on_rounded,
                      size: 46,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Lat: ${puntoSeleccionado.latitude.toStringAsFixed(7)} | Lng: ${puntoSeleccionado.longitude.toStringAsFixed(7)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}