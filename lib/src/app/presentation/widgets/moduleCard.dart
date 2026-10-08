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
                  ? [
                const Color(0xFFFFFBFB),
                const Color(0xFFF8FAFD),
              ]
                  : [
                Colors.white,
                const Color(0xFFF7FAFD),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: widget.destacado
                  ? const Color(0xFFD94B4B)
                  : const Color(0xFF092443),
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
                final bool esHorizontal =
                    constraints.maxWidth > constraints.maxHeight * 1.3;
                return Stack(
                  children: [
                    Positioned(
                      bottom: -26,
                      left: -20,
                      child: Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF6C757D).withOpacity(0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: esHorizontal ? 16 : 12,
                        vertical: esHorizontal ? 14 : 14,
                      ),
                      child: esHorizontal
                          ? _buildHorizontal()
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

  Widget _buildHorizontal() {
    ResponsiveUtil responsiveUtil=new ResponsiveUtil();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(size: 70),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title.toUpperCase(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  fontSize: responsiveUtil.diagonalP(1.6),
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF06245B),
                  letterSpacing: 0.20,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Acceder al módulo",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.8,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade500,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  _buildLineaDecorativa(width: 42),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Color(0xFF195BA6),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVertical(BoxConstraints constraints) {
    final double h = constraints.maxHeight;

    final double avatarSize = h < 185 ? 64 : h < 210 ? 72 : 84;
    final double gap1 = h < 185 ? 6 : 12;
    final double gap2 = h < 185 ? 4 : 6;
    final double gap3 = h < 185 ? 6 : 10;
    final double titleSize = h < 185 ? 11.8 : 13.2;
    final double subtitleSize = h < 185 ? 10.5 : 11.4;
    final double lineWidth = h < 185 ? 30 : 38;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAvatar(size: avatarSize),
        SizedBox(height: gap1),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: h < 185 ? 2 : 3,
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
        ),
        SizedBox(height: gap2),
        Text(
          "Acceder al módulo",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: subtitleSize,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey.shade500,
          ),
        ),
        SizedBox(height: gap3),
        _buildLineaDecorativa(width: lineWidth),
      ],
    );
  }
  Widget _buildAvatar({required double size}) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
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
            color: (widget.destacado
                ? const Color(0xFFD94B4B)
                : const Color(0xFF195BA6))
                .withOpacity(0.24),
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
            padding: const EdgeInsets.all(6), // 👈 espacio interno
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
          colors: [
            Color(0xFFD94B4B),
            Color(0xFF195BA6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : const LinearGradient(
          colors: [
            Color(0xFF195BA6),
            Color(0xFF6C757D),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _buildBadgeDestacado() {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFD94B4B),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD94B4B).withOpacity(0.24),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.priority_high_rounded,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              "DESTACADO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.2,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}