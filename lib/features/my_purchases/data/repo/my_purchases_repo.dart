import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../model/my_purchases_model.dart';

abstract class MyPurchasesRepo {
  static Future<Either<ErrorEntity, MyPurchasesModel>> myPurchases(
      SearchEngine params) async {
    try {
      final response = await Network().request(
        Endpoints.myPurchases,
        method: ServerMethods.GET,
        queryParameters: params.toJson(),
      );

      if (response.statusCode == 200) {
        final model = MyPurchasesModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(ApiErrorHandler().handleError(response.data['message']));
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
