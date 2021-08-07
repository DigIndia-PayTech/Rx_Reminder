import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class Some {
  // static BackgroundService _instance;
  // factory BackgroundService() => _instance ??= new BackgroundService._();
  // BackgroundService._();

  Some._privateConstructor();

  static final Some instance = Some._privateConstructor();

  static final FlutterBackgroundService service = FlutterBackgroundService();

  get onStart => _onStart();

   _onStart() {
    WidgetsFlutterBinding.ensureInitialized();
    service.onDataReceived.listen((event) {
      if (event["action"] == "setAsForeground") {
        service.setForegroundMode(true);
        return;
      }
      if (event["action"] == "setAsBackground") {
        service.setForegroundMode(false);
      }
      if (event["action"] == "stopService") {
        service.stopBackgroundService();
      }
    });
    // bring to foreground
    service.setForegroundMode(true);

  }
}
