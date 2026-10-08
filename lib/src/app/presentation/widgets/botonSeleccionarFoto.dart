part of 'custom_widgets.dart';
class BotonSeleccionarFoto extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;
  final IconData icono;
  final Color colorFondo;
  final Color colorTexto;

  const BotonSeleccionarFoto({
    Key? key,
    required this.onPressed,
    this.texto = 'Seleccione una Foto',
    this.icono = Icons.camera_alt,
    this.colorFondo = Colors.blue,
    this.colorTexto = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, color: colorTexto),
      label: Text(
        texto,
        style: TextStyle(
          color: colorTexto,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorFondo,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
      ),
    );
  }
}
