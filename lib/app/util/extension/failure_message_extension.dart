//@formatter:off

import 'package:cache_storage_demo/app/localization/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

extension FailureMessageExtension on BuildContext {
  String getApiFailureMessage(ApiFailure failure) {
    switch (failure.failure) {
      case ServerFailure.noNetwork:
        return S.current.apiFailureNoNetwork;
      case ServerFailure.exception:
        return S.current.apiFailureUndefined;
      case ServerFailure.unAuthorized:
        return S.current.apiFailureUnAuthorized;
      case ServerFailure.tooManyRequests:
        return S.current.apiFailureTooManyRequests;
      case ServerFailure.response:
        return failure.message;
      case ServerFailure.unknown:
        return S.current.apiFailureUndefined;
    }
  }
}
