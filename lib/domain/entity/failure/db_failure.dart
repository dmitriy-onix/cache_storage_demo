class DbFailure implements Exception {
  final Object? error;
  final StackTrace? stackTrace;

  DbFailure([this.error, this.stackTrace]);

  @override
  String toString() {
    return 'DbFailure{e: $error, stackTrace: $stackTrace}';
  }
}

class NoDataFoundFailure extends DbFailure {
  NoDataFoundFailure();
}

class ExpiredDataFailure extends DbFailure {
  ExpiredDataFailure();
}

class DecodingFailure extends DbFailure {
  DecodingFailure([super.e, super.stackTrace]);

  @override
  String toString() {
    return 'DecodingFailure{e: $error, stackTrace: $stackTrace}';
  }
}

class CacheStorageUndefinedFailure extends DbFailure {
  CacheStorageUndefinedFailure([super.e, super.stackTrace]);

  @override
  String toString() {
    return 'CacheStorageFailure{e: $error, stackTrace: $stackTrace}';
  }
}
