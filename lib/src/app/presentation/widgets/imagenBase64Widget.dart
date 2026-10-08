part of 'custom_widgets.dart';

class ImagenBase64Widget extends StatefulWidget {
  final String base64String;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final bool isCircular;

  const ImagenBase64Widget({
    Key? key,
    required this.base64String,
    this.width = 120,
    this.height = 120,
    this.borderRadius = 16,
    this.backgroundColor = Colors.white,
    this.isCircular = false,
  }) : super(key: key);

  @override
  State<ImagenBase64Widget> createState() => _ImagenBase64WidgetState();
}

class _ImagenBase64WidgetState extends State<ImagenBase64Widget> {
  Uint8List? _imageBytes;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  void _decodeImage() {
    try {
      final cleaned = widget.base64String.contains(',')
          ? widget.base64String.split(',').last
          : widget.base64String;

      setState(() {
        _imageBytes = base64Decode(cleaned);
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_hasError || _imageBytes == null) {
      content = Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.broken_image, color: Colors.red, size: 40),
        ),
      );
    } else {
      content = Image.memory(
        _imageBytes!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: widget.isCircular
            ? null
            : BorderRadius.circular(widget.borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.isCircular
          ? ClipOval(child: content)
          : ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: content,
      ),
    );
  }
}
