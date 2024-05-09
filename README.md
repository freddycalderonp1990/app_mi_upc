
Para implementar mi UPC

## Features


## Getting started

1. Copiar a tu propyecto /assets/imgs_mi_upc/*
2. crear la sigueinte estructura
        app
            presentation
                routes
                    app_pages.dart //contine todas las paguinas del proyecto y se debe agregar la de mi upc.. ejemplo
```dart

                            import 'package:app_mi_upc/app_mi_upc.dart';
                            import 'package:flutter/animation.dart';
                            import 'package:get/get.dart';



                            class AppPages {
                            static final _transition = Transition.rightToLeft;
                            static final _transitionDuration = const Duration(milliseconds: 400);
                            static final _curve = Curves.fastOutSlowIn;
                            static List<GetPage> _pages = [];

                            static GetPage getPageConfig(
                                {required String name,
                                required GetPageBuilder page,
                                required Bindings binding}) {
                                return GetPage(
                                    transition: _transition,
                                    transitionDuration: _transitionDuration,
                                    curve: _curve,
                                    name: name,
                                    page: page,
                                    binding: binding);
                            }

                            static List<GetPage> getPages() {
                                _pages = [];

                                //agregamos las paguinas de cada app
                                _pages.addAll(MiUpc.getPages);

                                return _pages;
                            }
                            }
```

            dependency_injection_app.dart
```dart
            import 'package:app_mi_upc/app_mi_upc.dart';
            import 'package:get/get.dart';

            class DependencyInjectionApp extends Bindings {
            static ini() {
                //agregar la inyeccion de dependencia de todos las apps

                  DependencyInjectionMiUpc.ini();

            }

            @override
            void dependencies() {
                print('DependencyInjection');
                ini();
            }
            }

```


## Usage


```dart

import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../app/dependency_injection_app.dart';

import 'presentation/routes/app_pages.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.lightTheme,
      theme: ThemeData(fontFamily: 'Sans'),
      locale: Locale('es'),
      // translations will be displayed in that locale
      fallbackLocale: Locale('es'),
      initialRoute: AppRoutesMiUpc.SPLASH,
      initialBinding: DependencyInjectionApp(),
      getPages: AppPages.getPages(),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Mi UPC'),
          ),
        ),
      ),
    );
  }
}

```

## Additional information

## Archivos del Proyecto

### Podfile
1. /ios/Podfile agregar lo siguiente

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      # Here are some configurations automatically generated by flutter

      # You can remove unused permissions here
      # for more infomation: https://github.com/BaseflowIT/flutter-permission-handler/blob/develop/permission_handler/ios/Classes/PermissionHandlerEnums.h
      # e.g. when you don't need camera permission, just add 'PERMISSION_CAMERA=0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        ## dart: [PermissionGroup.calendarWriteOnly, PermissionGroup.calendar (iOS 16 and below)]
        'PERMISSION_EVENTS=0',
           
        ## dart: [PermissionGroup.calendarFullAccess, PermissionGroup.calendar (iOS 17 and above)]
        'PERMISSION_EVENTS_FULL_ACCESS=0',
          
        ## dart: PermissionGroup.reminders
        'PERMISSION_REMINDERS=0',

                ## dart: PermissionGroup.contacts
                'PERMISSION_CONTACTS=0',

                ## dart: PermissionGroup.camera
                'PERMISSION_CAMERA=0',

                ## dart: PermissionGroup.microphone
                'PERMISSION_MICROPHONE=0',

                ## dart: PermissionGroup.speech
                'PERMISSION_SPEECH_RECOGNIZER=0',

                ## dart: PermissionGroup.photos
                'PERMISSION_PHOTOS=0',

                ## dart: PermissionGroup.photosAddOnly
                'PERMISSION_PHOTOS_ADD_ONLY=0',

                ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
                #'PERMISSION_LOCATION=1',

                ## dart: PermissionGroup.notification
                'PERMISSION_NOTIFICATIONS=0',

                ## dart: PermissionGroup.mediaLibrary
                'PERMISSION_MEDIA_LIBRARY=0',

                ## dart: PermissionGroup.sensors
                'PERMISSION_SENSORS=0',

                ## dart: PermissionGroup.bluetooth
                'PERMISSION_BLUETOOTH=0',

                ## dart: PermissionGroup.appTrackingTransparency
                'PERMISSION_APP_TRACKING_TRANSPARENCY=0',

                ## dart: PermissionGroup.criticalAlerts
                'PERMISSION_CRITICAL_ALERTS=0'
      ]

    end
  end
end

```

2. /ios/Runner/Info.plist agregar los mensajes que requiere el aplicativo
```xml
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>Necesitamos Acceder a tú ubicación para que puedas ver las Unidades de Policia Comunitaria</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>Necesitamos Acceder a tú ubicación para que puedas ver las Unidades de Policia Comunitaria</string>
	<key>NSLocationUsageDescription</key>
	<string>Necesitamos Acceder a tú ubicación para que puedas ver las Unidades de Policia Comunitaria</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Necesitamos Acceder a tú ubicación para que puedas ver las Unidades de Policia Comunitaria</string>
```

