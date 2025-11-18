import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../params/delete_account_params.dart';

abstract class DeleteAccountRepo {
  const DeleteAccountRepo();
  static Future<Either<ErrorEntity, Response>> deleteAccount(
      DeleteAccountParams params) async {
    try {
      final response = await Network().request(
        Endpoints.deleteAccount,
        method: ServerMethods.DELETE,
        body: params.returnedMap(),
      );

      return Right(response);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, Response>> checkDeleteAccount() async {
    try {
      final response = await Network().request(
        Endpoints.checkDeleteAccount,
        method: ServerMethods.GET,
      );

      return Right(response);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
