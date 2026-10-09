part of 'custom_widgets.dart';

class ModuleCard extends StatefulWidget {
  final String title;
  final String? base64Img;
  final VoidCallback onTap;
  final bool destacado;

  const ModuleCard({
    Key? key,
    required this.title,
    this.base64Img,
    this.destacado = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails _) => setState(() => _pressed = true);
  void _onTapUp(TapUpDetails _) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final double scale = _pressed ? 0.975 : 1.0;
    final double blur = _pressed ? 8.0 : 16.0;
    final double offsetY = _pressed ? 3.0 : 7.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: widget.destacado
                  ? [const Color(0xFFFFFBFB), const Color(0xFFF8FAFD)]
                  : [Colors.white, const Color(0xFFF7FAFD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: widget.destacado ? const Color(0xFFD94B4B) : const Color(0xFF092443),
              width: widget.destacado ? 1.8 : 1.0,
            ),
            boxShadow: [
              if (widget.destacado)
                BoxShadow(
                  color: const Color(0xFFD94B4B).withOpacity(0.16),
                  blurRadius: 18,
                  spreadRadius: 0.3,
                  offset: const Offset(0, 3),
                ),
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: blur,
                offset: Offset(0, offsetY),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double w = constraints.maxWidth;
                final double h = constraints.maxHeight;
                final bool esHorizontal = w > h * 1.55;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      bottom: -26,
                      left: -20,
                      child: Container(
                        width: _valorResponsivo(w * 0.20, 70, 95),
                        height: _valorResponsivo(w * 0.20, 70, 95),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF6C757D).withOpacity(0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _valorResponsivo(w * 0.045, 10, 22),
                        vertical: _valorResponsivo(h * 0.045, 10, 22),
                      ),
                      child: esHorizontal
                          ? _buildHorizontal(constraints)
                          : _buildVertical(constraints),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVertical(BoxConstraints constraints) {
    final double w = constraints.maxWidth;
    final double h = constraints.maxHeight;
    final double referencia = w < h ? w : h;

    final double avatarSize = _valorResponsivo(referencia * 0.22, 58, 90);
    final double titleSize = _valorResponsivo(referencia * 0.038, 11.5, 15.5);
    final double subtitleSize = _valorResponsivo(referencia * 0.030, 10.5, 13);
    final double gapAvatar = _valorResponsivo(h * 0.025, 7, 14);
    final double gapTexto = _valorResponsivo(h * 0.012, 4, 7);
    final double gapLinea = _valorResponsivo(h * 0.018, 6, 11);
    final double lineWidth = _valorResponsivo(w * 0.10, 30, 45);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAvatar(size: avatarSize),
          SizedBox(height: gapAvatar),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _valorResponsivo(w * 0.025, 4, 12)),
            child: Text(
              widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF06245B),
                letterSpacing: 0.30,
                height: 1.15,
              ),
            ),
          ),
          SizedBox(height: gapTexto),
          Text(
            'Acceder al módulo',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade500,
            ),
          ),
          SizedBox(height: gapLinea),
          _buildLineaDecorativa(width: lineWidth),
        ],
      ),
    );
  }

  Widget _buildHorizontal(BoxConstraints constraints) {
    final double w = constraints.maxWidth;
    final double h = constraints.maxHeight;

    final double avatarSize = _valorResponsivo(h * 0.48, 55, 82);
    final double titleSize = _valorResponsivo(h * 0.105, 12, 16);
    final double subtitleSize = _valorResponsivo(h * 0.078, 10.5, 13);
    final double separacion = _valorResponsivo(w * 0.03, 10, 18);

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(size: avatarSize),
          SizedBox(width: separacion),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title.toUpperCase(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF06245B),
                    letterSpacing: 0.20,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Acceder al módulo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade500,
                  ),
                ),
                const SizedBox(height: 7),
                _buildLineaDecorativa(width: _valorResponsivo(w * 0.09, 32, 46)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar({required double size}) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(_valorResponsivo(size * 0.045, 2.5, 4)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: widget.destacado
            ? const LinearGradient(
          colors: [Color(0xFFD94B4B), Color(0xFF195BA6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : const LinearGradient(
          colors: [Color(0xFF195BA6), Color(0xFF6C757D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (widget.destacado ? const Color(0xFFD94B4B) : const Color(0xFF195BA6)).withOpacity(0.24),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipOval(
          child: Padding(
            padding: EdgeInsets.all(_valorResponsivo(size * 0.07, 4, 7)),
            child: _buildImageContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildImageContent() {
    if (widget.base64Img == null || widget.base64Img!.trim().isEmpty) {
      return _buildFallbackIcon();
    }

    try {
      return Image.memory(
        base64Decode(widget.base64Img!),
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _buildFallbackIcon(),
      );
    } catch (_) {
      return _buildFallbackIcon();
    }
  }

  Widget _buildFallbackIcon() {
    return Container(
      color: const Color(0xFFF4F7FB),
      child: const Center(
        child: Icon(
          Icons.eighteen_mp_rounded,
          size: 30,
          color: Color(0xFF195BA6),
        ),
      ),
    );
  }

  Widget _buildLineaDecorativa({required double width}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: width,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: widget.destacado
            ? const LinearGradient(
          colors: [Color(0xFFD94B4B), Color(0xFF195BA6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : const LinearGradient(
          colors: [Color(0xFF195BA6), Color(0xFF6C757D)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  double _valorResponsivo(double valor, double minimo, double maximo) {
    if (valor < minimo) return minimo;
    if (valor > maximo) return maximo;
    return valor;
  }
}