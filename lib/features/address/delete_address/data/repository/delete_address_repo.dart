import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';

abstract class DeleteAddressRepo {
  const DeleteAddressRepo();
  static Future<Either<ErrorEntity, Response>> deleteAddress(int id) async {
    try {
      final response = await Network().request(Endpoints.deleteAddresses,
          method: ServerMethods.DELETE, body: {'id': id});
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(ApiErrorHandler().handleError(response.data['message']));
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
