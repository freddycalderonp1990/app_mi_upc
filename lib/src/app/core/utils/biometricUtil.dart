import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';


import 'package:local_auth_android/src/auth_messages_android.dart';




class BiometricUtil {
  static Future<bool> checkAccesoBiometrico() async {
    bool accesoBiometrico = false;
    bool? _canCheckBiometrics;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      //Para verificar si hay autenticación local disponible en este dispositivo
      await auth.canCheckBiometrics;

      _canCheckBiometrics = await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      availableBiometrics.forEach(
            (BiometricType age) => print("PERMISOS BIOMETRICOS = ${age}"),
      );

      if (GetPlatform.isAndroid) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }
        if (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.weak)) {
          print('fingerprint');
          accesoBiometrico = true;
        }
      } else if (GetPlatform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID IOS');
          accesoBiometrico = true;
        }
        if (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.weak)) {
          accesoBiometrico = true;
        }
      }

      print('accesoBiometrico');

      print(accesoBiometrico);

      return accesoBiometrico;
    } catch (e) {
      print(e.toString());
      print('cath');
      return false;
    }
  }

  static Future<bool> biometrico() async {
    bool autenticar = false;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      //Para verificar si hay autenticación local disponible en este dispositivo
      await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }
        // Touch ID.
        print('Touch ID');

        const androidString = const AndroidAuthMessages(
          cancelButton: "Cancelar",

          signInTitle: "Acceso con Huella",
          signInHint: "Pon tu dedo en el sensor para acceder.",

          /*biometricRequiredTitle:'biometricRequiredTitle',
              deviceCredentialsRequiredTitle:'deviceCredentialsRequiredTitle',
              deviceCredentialsSetupDescription:'deviceCredentialsSetupDescription',*/
        );
        /*
        const iosStrings = const IOSAuthMessages(
            cancelButton: 'Cancelar',
            goToSettingsButton: 'Ajustes',
            goToSettingsDescription: 'Configure su Huella',
            lockOut: 'Vuelva a habilitar su Huella');*/

        /*  autenticar = await auth.authenticate(
              localizedReason: "Autentiquese para acceder",
              useErrorDialogs: false,
              stickyAuth: true,
              androidAuthStrings: androidString,
              iOSAuthStrings: iosStrings);*/

        autenticar = await auth.authenticate(
          authMessages: [androidString],
          localizedReason: "Autentiquese para acceder",
        );
      }

      if (!autenticar) {
        print(' eror No se autentico');
      }
      return autenticar;
    } on PlatformException catch (e) {
      print('Error biometric: {$e.toString()}');

      //Error:PlatformException(no_fragment_activity, local_auth plugin requires activity to be a FragmentActivity., null, null)
      //Soltion: Modificar el archivo MainActivity.kt
      /*   import io.flutter.embedding.android.FlutterActivity
      import androidx.annotation.NonNull;
      import io.flutter.embedding.android.FlutterFragmentActivity
      import io.flutter.embedding.engine.FlutterEngine
      import io.flutter.plugins.GeneratedPluginRegistrant

    class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
    }*/

      return false;
    }
  }
}
