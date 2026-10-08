part of '../pages.dart';

class RegistroUsuarioPage extends GetView<RegistroUsuarioController> {
  const RegistroUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.inicializacionCompleta.value &&
            !controller.modalSeleccionMostrado.value &&
            !controller.mostrarFormulario.value &&
            !controller.datosCargados.value &&
            !(Get.isDialogOpen ?? false)) {
          abrirModalTipoRegistro();
        }
      });

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: (controller.mostrarFormulario.value ||
            controller.datosCargados.value)
            ? _getAppBar('Registro de Usuario')
            : AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: controller.inicializacionCompleta.value
            ? Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    if (controller.mostrarFormulario.value ||
                        controller.datosCargados.value) ...[
                      _cardEstadoRegistro(),
                      const SizedBox(height: 12),
                      _formularioPrincipal(context),
                    ] else ...[
                      const SizedBox(height: 120),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            CargandoWidget(
              mostrar: controller.peticionServerState.value ||
                  controller.cargandoSocialLogin.value,
            ),
          ],
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  AppBar _getAppBar(String titleAppBar) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF06245B), Color(0xFF6c757d)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      title: Text(
        titleAppBar,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
        tooltip: 'Atrás',
        onPressed: () => Get.back(),
      ),
    );
  }

  void abrirModalTipoRegistro() {
    if (controller.modalSeleccionMostrado.value) return;
    if (Get.isDialogOpen ?? false) return;

    controller.modalSeleccionMostrado.value = true;
ResponsiveUtil responsiveUtil=new ResponsiveUtil();
    Get.dialog(
      PopScope(
        canPop: true,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/img/cabecera2.png',height: responsiveUtil.diagonalP(4),),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.modalSeleccionMostrado.value = false;
                        Get.back();
                        Get.offAllNamed(AppRoutes.MENU);
                      },
                      child: Container(
                        width: 35,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Color(0xFF06245B),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF06245B), Color(0xFF195ba6)],
                    ),
                  ),
                  child: const Icon(
                    Icons.how_to_reg_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Seleccione el tipo de registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF06245B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Puede registrarse con Google o completar sus datos manualmente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF5F6B7A),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                _buildBotonModalRegistro(
                  texto: 'Continuar con Google',
                  icono: Icons.g_mobiledata_rounded,
                  colorFondo: Colors.white,
                  colorTexto: const Color(0xFFEC0606),
                  colorBorde: Colors.grey,
                  onTap: () async {
                    Get.back();
                    controller.modalSeleccionMostrado.value = false;
                    await controller.registrarConGoogle();
                  },
                ),
                const SizedBox(height: 10),
                _buildBotonModalRegistro(
                  texto: 'Completar manualmente',
                  icono: Icons.edit_note_rounded,
                  colorFondo: const Color(0xFF195ba6),
                  colorTexto: Colors.white,
                  colorBorde: const Color(0xFF195ba6),
                  onTap: () async {
                    Get.back();
                    controller.modalSeleccionMostrado.value = false;
                    controller.usarRegistroManual();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildBotonModalRegistro({
    required String texto,
    required IconData icono,
    required Color colorFondo,
    required Color colorTexto,
    required Color colorBorde,
    required Future<void> Function()? onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorFondo,
          side: BorderSide(color: colorBorde, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        icon: Icon(icono, color: colorTexto, size: 26),
        label: Text(
          texto,
          style: TextStyle(
            color: colorTexto,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _formularioPrincipal(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Form(
      key: controller.formKeyNacional,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _encabezadoFormulario(),
            const SizedBox(height: 16),
            if (controller.metodoRegistro.value.isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F8FE),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFB8D4F6)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_user_rounded,
                      color: Color(0xFF195ba6),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.metodoRegistro.value == 'manual'
                            ? 'Registro manual seleccionado.'
                            : 'Datos precargados desde ${controller.metodoRegistro.value.toUpperCase()}.',
                        style: const TextStyle(
                          color: Color(0xFF06245B),
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            _txtCedula(responsive),
            const SizedBox(height: 15),
            _txtNombresApellidos(responsive),
            const SizedBox(height: 10),
            _txtCelular(responsive),
            const SizedBox(height: 10),
            _txtCorreo(responsive),
            const SizedBox(height: 14),
            _wgFoto(responsive),
            const SizedBox(height: 10),
            _btnRegistrar(),
            if (controller.datosCargados.value) _btnLimpiarRegistro(),
          ],
        ),
      ),
    );
  }

  Widget _btnRegistrar() {
    final isEdit = controller.datosCargados.value;
    final esManual = controller.metodoRegistro.value == 'manual';

    if (isEdit || !esManual) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF195ba6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 6,
        ),
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        label: const Text(
          'REGISTRARSE',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        onPressed: () => controller.registrarUsuario(),
      ),
    );
  }

  Widget _btnLimpiarRegistro() {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 8),
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFc62828), width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: const Icon(Icons.restart_alt_rounded, color: Color(0xFFc62828)),
        label: const Text(
          'REGISTRAR OTRO USUARIO',
          style: TextStyle(
            color: Color(0xFFc62828),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          DialogosAwesome.getInformation(
            title: "Mi UPC",
            descripcion:
            "Se eliminarán los datos guardados localmente para permitir un nuevo registro. ¿Desea continuar?",
            btnOkOnPress: () async {
              Get.back();
              await controller.limpiarDatosRegistrados();
              Future.delayed(const Duration(milliseconds: 250), () {
                abrirModalTipoRegistro();
              });
            },
          );
        },
      ),
    );
  }

  Widget _encabezadoFormulario() {
    return Row(
      children: [
        const Icon(
          Icons.assignment_ind_rounded,
          color: Color(0xFF195ba6),
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            controller.datosCargados.value
                ? 'Datos personales del usuario'
                : 'Ingrese la información solicitada',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF06245B),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputStyle(String label, String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: const Color(0xFF195ba6)),
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF195ba6), width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(14),
      ),
      labelStyle: const TextStyle(color: Color(0xFF06245B)),
    );
  }

  Widget _txtCedula(ResponsiveUtil res) {
    return TextFormField(
      controller: controller.controllerCedula,
      maxLength: 10,
      keyboardType: TextInputType.number,
      decoration: _inputStyle(
        'Cédula',
        'Ingrese su número de cédula',
        Icons.badge,
      ).copyWith(counterText: ""),
      validator: (v) => controller.validarCedula(v),
    );
  }

  Widget _txtNombresApellidos(ResponsiveUtil res) {
    return Column(
      children: [
        TextFormField(
          controller: controller.controllerPrimerNombre,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
            ),
          ],
          validator: (v) => controller.validarSoloLetras(v, 'su primer nombre'),
          decoration: _inputStyle(
            'Primer Nombre',
            'Ingrese su primer nombre',
            Icons.person,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: res.anchoP(42),
              child: TextFormField(
                controller: controller.controllerApellido1,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                  ),
                ],
                validator: (v) =>
                    controller.validarSoloLetras(v, 'su primer apellido'),
                decoration: _inputStyle(
                  'Apellido 1',
                  'Apellido 1',
                  Icons.account_box,
                ),
              ),
            ),
            SizedBox(
              width: res.anchoP(42),
              child: TextFormField(
                controller: controller.controllerApellido2,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                  ),
                ],
                validator: (v) =>
                    controller.validarSoloLetras(v, 'su segundo apellido'),
                decoration: _inputStyle(
                  'Apellido 2',
                  'Apellido 2',
                  Icons.account_box_outlined,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _txtCelular(ResponsiveUtil res) {
    return TextFormField(
      maxLength: 10,
      controller: controller.controllerContacto,
      keyboardType: TextInputType.phone,
      decoration: _inputStyle(
        'Número de Contacto',
        'Ej: 0999999999',
        Icons.contact_phone,
      ).copyWith(counterText: ""),
      validator: (v) => controller.validarCelular(v),
    );
  }

  Widget _txtCorreo(ResponsiveUtil res) {
    return TextFormField(
      controller: controller.controllerCorreo,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => controller.emailValidator(value ?? ''),
      decoration: _inputStyle(
        'Correo Electrónico',
        'Ingrese su email',
        Icons.email_outlined,
      ),
    );
  }

  Widget _wgFoto(ResponsiveUtil responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Foto de Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF06245B),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            controller.mGaleryCameraModel.value =
            await PhotoHelper.getDesingPictureGaleryOrCamera(
              initPeticion: (value) => controller.peticionServerState(value),
              titleImg: "Foto Perfil",
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.grey.shade100,
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_a_photo, color: Color(0xFF195ba6)),
                const SizedBox(width: 10),
                Text(
                  controller.mGaleryCameraModel.value == null &&
                      controller.fotoPerfilBytes.value == null
                      ? "Agregar Imagen"
                      : "Cambiar Imagen",
                  style: const TextStyle(
                    color: Color(0xFF06245B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Obx(() {
          if (controller.mGaleryCameraModel.value != null) {
            return Center(
              child: ClipOval(
                child: Image.file(
                  controller.mGaleryCameraModel.value!.imageFile,
                  fit: BoxFit.cover,
                  height: responsive.altoP(16),
                  width: responsive.altoP(16),
                ),
              ),
            );
          } else if (controller.fotoPerfilBytes.value != null) {
            return Center(
              child: ClipOval(
                child: Image.memory(
                  controller.fotoPerfilBytes.value!,
                  fit: BoxFit.cover,
                  height: responsive.altoP(16),
                  width: responsive.altoP(16),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }

  Widget _cardEstadoRegistro() {
    final bool isEdit = controller.datosCargados.value;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEdit
              ? [const Color(0xFF0F3D75), const Color(0xFF195ba6)]
              : [const Color(0xFF195ba6), const Color(0xFF6c757d)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEdit
                  ? Icons.verified_user_rounded
                  : Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isEdit ? 'Usuario registrado' : 'Edición de usuario',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}