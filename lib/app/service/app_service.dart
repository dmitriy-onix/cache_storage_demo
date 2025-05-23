import 'dart:async';

import 'package:cache_storage_demo/app/service/env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

/*
* Example of .env file
*
* APIKEY1=demo
* APIKEY2=demo
*
*/

class AppService {
  static final String apiKey1 = Env.apiKey1;
  static final String apiKey2 = Env.apiKey2;

  //Change if not need to check for root or jail brake
  final _secureFromJailbreak = true;

  Future<bool> initialize() async {
    if (_secureFromJailbreak && !kIsWeb && !kDebugMode) {
      final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
      if (isJailBroken) {
        return false;
      }
    }

    return true;
  }
}
