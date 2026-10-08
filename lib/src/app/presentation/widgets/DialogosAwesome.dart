part of 'custom_widgets.dart';

/// 🎯 Diálogos institucionales profesionales — versión mejorada
class DialogosAwesome {
//=======================================================
// ✅ DIALOGO DE ERROR (Versión Institucional Mejorada)
// ============================================================
  static getError({
    String title = 'ERROR',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader, // Eliminamos header estándar para diseño personalizado
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      padding: const EdgeInsets.all(20),
      dialogBorderRadius: BorderRadius.circular(16),
      dialogBackgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔴 Ícono circular con gradiente
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFB00020), Color(0xFFE53935)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
              size: 46,
            ),
          ),
          const SizedBox(height: 18),

          // 🔹 Título
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFB00020),
              fontWeight: FontWeight.w900,
              fontSize: 19,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          // 🔸 Descripción
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.45,
              color: Color(0xFF3E4A59),
            ),
          ),
          const SizedBox(height: 24),

          // 🔘 Botón institucional
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: btnOkOnPress ?? () => Get.back(),
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              label: const Text(
                "ACEPTAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB00020),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                shadowColor: const Color(0xFFB00020).withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    ).show();
  }


//===========================================================
// ✅ DIALOGO DE ÉXITO (Versión Institucional Mejorada)
// ============================================================
  static getSucess({
    String title = 'ÉXITO',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader, // diseño moderno sin header estándar
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      padding: const EdgeInsets.all(20),
      dialogBorderRadius: BorderRadius.circular(16),
      dialogBackgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🟢 Ícono circular con gradiente institucional
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF167D42), Color(0xFF43A047)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 46,
            ),
          ),
          const SizedBox(height: 18),

          // 🔹 Título
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: Color(0xFF167D42),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          // 🔸 Descripción
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.5,
              color: Color(0xFF2E384D),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),

          // 🔘 Botón institucional
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: btnOkOnPress ?? () => Get.back(),
              icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
              label: const Text(
                "ACEPTAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF167D42),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF167D42).withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    ).show();
  }


  // ============================================================
// ⚠️ DIALOGO DE ADVERTENCIA SIMPLE (Versión Institucional Mejorada)
// ============================================================
  static getWarning({
    String title = 'ADVERTENCIA',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader, // diseño limpio sin header estándar
      animType: AnimType.scale,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      dialogBackgroundColor: Colors.white,
      padding: const EdgeInsets.all(20),
      dialogBorderRadius: BorderRadius.circular(16),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🟡 Ícono circular con gradiente cálido institucional
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 46,
            ),
          ),
          const SizedBox(height: 18),

          // 🔹 Título
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFFF57C00),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          // 🔸 Descripción
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.5,
              color: Color(0xFF3E4A59),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),

          // 🔘 Botón institucional
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: btnOkOnPress ?? () {Get.back();},
              icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
              label: const Text(
                "ACEPTAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                shadowColor: const Color(0xFFFF9800).withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    ).show();
  }


  // ============================================================
// ⚠️ DIALOGO CONFIRMAR SI / NO (Versión Institucional Mejorada)
// ============================================================
  static getWarningSiNo({
    String title = 'CONFIRMAR ACCIÓN',
    required String descripcion,
    Function()? btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      padding: const EdgeInsets.all(20),
      dialogBorderRadius: BorderRadius.circular(16),
      dialogBackgroundColor: Colors.white,
      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 0.9),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🟠 Ícono circular con gradiente institucional de advertencia
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF9800),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              color: Colors.white,
              size: 46,
            ),
          ),
          const SizedBox(height: 18),

          // 🔹 Título
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF06245B),
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),

          // 🔸 Descripción
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF3E4A59),
              fontSize: 15.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 26),

          // 🔘 Botones
          Row(
            children: [
              // ❌ BOTÓN NO
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: btnCancelOnPress ?? () => Get.back(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  label: const Text(
                    "NO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C757D),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF6C757D).withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // ✅ BOTÓN SÍ
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: btnOkOnPress,
                  icon:
                  const Icon(Icons.check_circle_rounded, color: Colors.white),
                  label: const Text(
                    "SÍ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF195BA6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFF195BA6).withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).show();
  }


  // ============================================================
// ℹ️ DIALOGO DE INFORMACIÓN (Versión Institucional Mejorada)
// ============================================================
  static getInformation({
    String title = 'INFORMACIÓN',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader, // diseño limpio y moderno
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      dialogBackgroundColor: Colors.white,
      dialogBorderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(20),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔵 Ícono circular institucional
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF195BA6), Color(0xFF06245B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 46,
            ),
          ),
          const SizedBox(height: 18),

          // 🔹 Título
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF06245B),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          // 🔸 Descripción
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.5,
              color: Color(0xFF3E4A59),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),

          // 🔘 Botón institucional azul
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: btnOkOnPress ?? () => Get.back(),
              icon: const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.white),
              label: const Text(
                "ACEPTAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF195BA6),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF195BA6).withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    ).show();
  }


  // ============================================================
  // 📋 ALERTA DETALLE SERVICIOS (MEJORADA)
  // ============================================================
  static getAlertDetalleServicios({
    required String title,
    required Widget body,
    required String imagen,
    Function()? btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300, width: 0.8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header institucional
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF06245B), Color(0xFF195BA6)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  imgPerfilRedonda(size: 12, img: imagen.isEmpty ? null : imagen),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cuerpo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              color: const Color(0xFFF9FAFB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  body,
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 0.7,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (btnCancelOnPress != null)
                        TextButton(
                          onPressed: btnCancelOnPress,
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.grey.shade700),
                          child: const Text("CANCELAR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4)),
                        ),
                      ElevatedButton(
                        onPressed: btnOkOnPress ?? () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF195BA6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("ACEPTAR",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  // ============================================================
  // 🌀 DIALOGO DE CARGA MODERNO
  // ============================================================
  static void getLoading({String descripcion = "Procesando..."}) {
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 6))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Color(0xFF195BA6),
                strokeWidth: 3,
              ),
              const SizedBox(height: 18),
              Text(
                descripcion,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF06245B),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  // ============================================================
  // ℹ️ INFORMACIÓN CON BOTÓN ACEPTAR PERSONALIZADO
  // ============================================================
  static getInformationAceptar({
    String title = 'INFORMACIÓN',
    required String descripcion,
    required Function() btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader, // sin header para un look más moderno
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      dialogBorderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(20),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔷 Icono principal institucional
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF195BA6), Color(0xFF06245B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 45,
            ),
          ),
          const SizedBox(height: 16),

          // 🔹 Título
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF06245B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          // 🔹 Descripción
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF3E4A59),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // 🔹 Botón Aceptar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: btnOkOnPress,
              icon: const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.white, size: 22),
              label: const Text(
                "ACEPTAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF195BA6),
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
      dialogBackgroundColor: Colors.white,
      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
    ).show();
  }

}
