import 'dart:async';

import 'package:cache_storage_demo/app/service/session_service/session_status.dart';
import 'package:cache_storage_demo/core/di/repository.dart';
import 'package:cache_storage_demo/domain/entity/authentication/authentication.dart';
import 'package:flutter/foundation.dart';

class SessionService extends ChangeNotifier {
  SessionStatus _sessionStatus = SessionStatus.closed;

  SessionStatus get sessionStatus => _sessionStatus;

  Future<void> renewSession() async {
    final authData = await tokenRepository.getAuthData();
    if (authData == null) {
      return;
    }
    if (authData.accessToken.isEmpty) {
      return;
    }
    _sessionStatus = SessionStatus.open;

    notifyListeners();
  }

  Future<void> openSession(Authentication authEntity) async {
    await tokenRepository.update(authEntity);
    _sessionStatus = SessionStatus.open;

    notifyListeners();
  }

  Future<void> closeSession() async {
    await tokenRepository.clear();
    _sessionStatus = SessionStatus.closed;

    notifyListeners();
  }
}
