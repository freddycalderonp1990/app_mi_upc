
part of 'custom_widgets.dart';
class BtnIconWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final Color color;
  final Color colorTextoIcon;
  final Future<void> Function() onTap;
  final double elevation;
  final double size;
  final double paddinHorizontal;

  const BtnIconWidget({
    required this.onTap,
    required this.iconData,
    this.title = "",
    required this.color,
    this.colorTextoIcon = Colors.white,
    this.elevation = 2.0,
    this.size = 16.0,
    this.paddinHorizontal = 8.0,
  });

  @override
  State<BtnIconWidget> createState() => _BtnIconWidgetState();
}

class _BtnIconWidgetState extends State<BtnIconWidget> {
  bool _loading = false;

  void _handleTap() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      await widget.onTap();
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.paddinHorizontal),
      child: Material(
        color: widget.color,
        borderRadius: BorderRadius.circular(30),
        elevation: widget.elevation,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: _loading ? null : _handleTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_loading)
                  SizedBox(
                    height: widget.size,
                    width: widget.size,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(widget.colorTextoIcon),
                    ),
                  )
                else
                  Icon(
                    widget.iconData,
                    size: widget.size,
                    color: widget.colorTextoIcon,
                  ),
                if (widget.title.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: widget.size,
                      color: widget.colorTextoIcon,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
