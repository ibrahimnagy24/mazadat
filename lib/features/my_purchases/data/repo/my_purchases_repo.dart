import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../entity/shipment_entity.dart';
import '../model/shipment_model.dart';
import '../params/shipment_params.dart';

abstract class MyPurchasesRepo {
  static Future<Either<ErrorEntity, List<ShipmentEntity>>> getShipments(
      ShipmentParams params) async {
    try {
      final response = await Network().request(
        Endpoints.myPurchases,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final ShipmentsResponseModel shipmentsResponse = 
          ShipmentsResponseModel.fromJson(response.data);
      
      return Right(shipmentsResponse.content);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
