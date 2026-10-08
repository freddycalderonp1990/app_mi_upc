part of 'custom_widgets.dart';

class AdjuntoEventoWidget extends StatelessWidget {
  final AdjuntoModel? archivo;
  final bool cargando;
  final Future<void> Function() onTomarFoto;
  final Future<void> Function() onGrabarVideo;
  final Future<void> Function()? onSeleccionarArchivo;
  final VoidCallback onEliminar;

  const AdjuntoEventoWidget({
    super.key,
    required this.archivo,
    required this.cargando,
    required this.onTomarFoto,
    required this.onGrabarVideo,
    this.onSeleccionarArchivo,
    required this.onEliminar,
  });

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  IconData _getIconByMime(String mime) {
    if (mime.startsWith('image/')) return Icons.image_outlined;
    if (mime.startsWith('video/')) return Icons.videocam_outlined;
    return Icons.attach_file_outlined;
  }

  bool _esImagen(String mime) => mime.startsWith('image/');
  bool _esVideo(String mime) => mime.startsWith('video/');

  Future<void> _mostrarOpcionesAdjunto(BuildContext context) async {
    if (cargando) return;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Adjuntar evidencia",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A2E5C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Seleccione cómo desea cargar la evidencia del evento.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      fontSize: 13.4,
                    ),
                  ),
                  const SizedBox(height: 18),

                  _itemAccion(
                    icon: Icons.photo_camera_outlined,
                    titulo: "Tomar foto",
                    subtitulo: "Capturar imagen con la cámara",
                    onTap: () async {
                      Navigator.of(context).pop();
                      await onTomarFoto();
                    },
                  ),
                  const SizedBox(height: 12),

                  _itemAccion(
                    icon: Icons.videocam_outlined,
                    titulo: "Grabar video",
                    subtitulo: "Capturar video con la cámara",
                    onTap: () async {
                      Navigator.of(context).pop();
                      await onGrabarVideo();
                    },
                  ),
                  const SizedBox(height: 12),

                  if (onSeleccionarArchivo != null)
                    _itemAccion(
                      icon: Icons.folder_open_outlined,
                      titulo: "Galería",
                      subtitulo: "Seleccionar una imagen o video guardado",
                      onTap: () async {
                        Navigator.of(context).pop();
                        await onSeleccionarArchivo!();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _itemAccion({
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFF8FBFE),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFDCE8F5)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: const Color(0xFF195BA6).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: const Color(0xFF195BA6), size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A2E5C),
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitulo,
                      style: TextStyle(
                        color: Colors.blueGrey.shade600,
                        fontSize: 12.6,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF195BA6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarPreviewImagen(BuildContext context, File file) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Image.file(
                    file,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreviewArchivo(BuildContext context) {
    if (archivo == null) return const SizedBox.shrink();

    final current = archivo!;

    if (_esImagen(current.mimeType)) {
      return GestureDetector(
        onTap: () => _mostrarPreviewImagen(context, current.file),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFD7E3F1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Image.file(
                  current.file,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Vista previa",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      current.nombre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFD),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD7E3F1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF195BA6).withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _esVideo(current.mimeType)
                  ? Icons.videocam_outlined
                  : _getIconByMime(current.mimeType),
              color: const Color(0xFF195BA6),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current.nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A2E5C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${current.mimeType} • ${_formatBytes(current.tamanioBytes)}",
                  style: TextStyle(
                    color: Colors.blueGrey.shade600,
                    fontSize: 12.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool tieneArchivo = archivo != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _mostrarOpcionesAdjunto(context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBFD),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: tieneArchivo
                    ? const Color(0xFFBFD4EC)
                    : const Color(0xFFD7E3F1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF195BA6).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    tieneArchivo
                        ? _getIconByMime(archivo!.mimeType)
                        : Icons.add_a_photo_outlined,
                    color: const Color(0xFF195BA6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: cargando
                      ? const Text(
                    "Cargando evidencia...",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A2E5C),
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tieneArchivo
                            ? "Cambiar evidencia"
                            : "Adjuntar evidencia",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0A2E5C),
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tieneArchivo
                            ? archivo!.nombre
                            : "Tome una foto, grabe un video o busque un archivo desde su galería",
                        style: TextStyle(
                          color: Colors.blueGrey.shade600,
                          fontSize: 12.8,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                if (cargando)
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.3),
                  )
                else
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF195BA6),
                  ),
              ],
            ),
          ),
        ),
        if (tieneArchivo) ...[
          const SizedBox(height: 14),
          _buildPreviewArchivo(context),
          const SizedBox(height: 10),
          if (archivo!.superaCincoMb)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E8),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFF1D7A6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.wifi_outlined,
                    color: Color(0xFFC28A10),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "El archivo supera los 5 MB. Se recomienda conectarse a una red Wi-Fi antes de enviarlo.",
                      style: TextStyle(
                        color: Color(0xFF8A5A00),
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onEliminar,
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
              ),
              label: const Text(
                "Quitar archivo",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}