import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../model/bundle_details_model.dart';
import '../params/bundle_details_route_params.dart';

abstract class BundleDetailsRepo {
  static Future<Either<ErrorEntity, BundleDetailsModel>> getBundleDetails(
      BundleDetailsRouteParams params) async {
    try {
      final response = await Network().request(
        Endpoints.viewBundle(params),
        method: ServerMethods.GET,
      );
      return Right(BundleDetailsModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, Response>> validateJoiningAuction(
      int id) async {
    try {
      final response = await Network().request(
        Endpoints.validateAuctionJoining(id),
        method: ServerMethods.GET,
      );

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
