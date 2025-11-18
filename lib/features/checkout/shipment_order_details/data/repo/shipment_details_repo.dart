import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../entity/shipment_details_entity.dart';
import '../model/shipment_details_model.dart';
import '../params/shipment_details_params.dart';
abstract class ShipmentDetailsRepo {
  const ShipmentDetailsRepo();
  
  static Future<Either<ErrorEntity, ShipmentDetailsEntity>> getShipmentDetails(
      ShipmentDetailsParams params) async {
    try {
      final response = await Network().request(
        '${Endpoints.shipments}/viewShipmentDetails/${params.shipmentId}',
        method: ServerMethods.GET,
      );
      return Right(ShipmentDetailsModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
