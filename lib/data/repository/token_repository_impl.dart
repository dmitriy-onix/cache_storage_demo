import 'dart:async';

import 'package:cache_storage_demo/data/source/local/secure_storage/secure_storage_keys.dart';
import 'package:cache_storage_demo/data/source/local/secure_storage/secure_storage_source.dart';
import 'package:cache_storage_demo/domain/entity/authentication/authentication.dart';
import 'package:cache_storage_demo/domain/repository/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  @override
  String? accessToken;

  @override
  String? refreshToken;

  final SecureStorageSource _secureStorage;

  TokenRepositoryImpl(this._secureStorage);

  @override
  Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    await _secureStorage.delete(SecureStorageKeys.kAccessToken);
    await _secureStorage.delete(SecureStorageKeys.kRefreshToken);
  }

  @override
  Future<void> update(Authentication authEntity) async {
    accessToken = authEntity.accessToken;
    refreshToken = authEntity.refreshToken;

    await _secureStorage.write(
      SecureStorageKeys.kAccessToken,
      authEntity.accessToken,
    );
    await _secureStorage.write(
      SecureStorageKeys.kRefreshToken,
      authEntity.refreshToken,
    );
  }

  @override
  Future<Authentication?> getAuthData() async {
    final accessToken =
        await _secureStorage.read(SecureStorageKeys.kAccessToken);
    final refreshToken =
        await _secureStorage.read(SecureStorageKeys.kRefreshToken);

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      return Authentication(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }
    return null;
  }
}
