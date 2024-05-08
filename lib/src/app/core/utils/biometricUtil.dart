import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/src/auth_messages_android.dart';

class BiometricUtil {
  static Future<bool> checkAccesoBiometrico() async {
    bool accesoBiometrico = false;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      //Para verificar si hay autenticación local disponible en este dispositivo
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      print('es android ${GetPlatform.isAndroid}');

      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
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
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      print("Biometrics-canCheckBiometrics:${canCheckBiometrics}");
      print("Biometrics-availableBiometrics:${availableBiometrics}");

      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }

        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          print('Touch ID');

          const androidString = AndroidAuthMessages(
              cancelButton: "Cancelar",
              goToSettingsButton: "Ajustes",
              signInTitle: "Acceso con Huella",
              biometricHint: "Pon tu dedo en el sensor para acceder.",
              biometricNotRecognized: "Huella no Reconocida",
              biometricSuccess: "Huella Reconocida",
              goToSettingsDescription: "Configure su Huella");

          /*const iosStrings = IOSAuthMessages(
              cancelButton: 'Cancelar',
              goToSettingsButton: 'Ajustes',
              goToSettingsDescription: 'Configure su Huella',
              lockOut: 'Vuelva a habilitar su Huella');
          autenticar = await auth.authenticate(
              localizedReason: "Autentiquese para acceder",
          );*/
        }
      }

      if (!autenticar) {
        print(' eror No se autentico');
      }
      return autenticar;
    } on PlatformException catch (e) {
      print('Error biometric: {$e.toString()}');

      return false;
    }
  }

  static Future<bool> biometrico2() async {
    bool autenticar = false;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      //Para verificar si hay autenticación local disponible en este dispositivo
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      //Para obtener una lista de datos biométricos inscritos, llame a getAvailableBiometrics:
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      print("canCheckBiometrics:${canCheckBiometrics}");
      print("canCheckBiometrics:${availableBiometrics}");

      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          print('Face ID');
        }

        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          print('Touch ID');

          /*       const androidString = const AndroidAuthMessages(
              cancelButton: "Cancelar",
              goToSettingsButton: "Ajustes",
              signInTitle: "Acceso con Huella",
              biometricHint: "Pon tu dedo en el sensor para acceder.",
              biometricNotRecognized: "Huella no Reconocida",
              biometricSuccess: "Huella Reconocida",
              /*biometricRequiredTitle:'biometricRequiredTitle',
              deviceCredentialsRequiredTitle:'deviceCredentialsRequiredTitle',
              deviceCredentialsSetupDescription:'deviceCredentialsSetupDescription',*/

              goToSettingsDescription: "Configure su Huella");


          const iosStrings = const IOSAuthMessages(
              cancelButton: 'Cancelar',
              goToSettingsButton: 'Ajustes',
              goToSettingsDescription: 'Configure su Huella',
              lockOut: 'Vuelva a habilitar su Huella');

         autenticar = await auth.          authenticate(
              localizedReason: 'Autentiquese para acceder',
              authMessages: const <AuthMessages>[
                AndroidAuthMessages(
                  signInTitle: 'Oops! Biometric authentication required!',
                  cancelButton: 'No thanks',
                ),
                IOSAuthMessages(
                  cancelButton: 'No thanks',
                ),
              ]);


*/
        }
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
