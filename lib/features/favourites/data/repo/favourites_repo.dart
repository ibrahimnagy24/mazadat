import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../params/toggle_favourites_params.dart';

abstract class FavouritesRepo {
  static Future<Either<ErrorEntity, Response>> favouritesAuction(
      SearchEngine params) async {
    try {
      final response = await Network().request(
        Endpoints.getFavorites,
        method: ServerMethods.GET,
        queryParameters: params.toJson(),
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

  static Future<Either<ErrorEntity, Response>> toggleFavoriteAuction(
     ToggleFavouritesParams params) async {
    try {
      final response = await Network().request(
        Endpoints.toggleFavoriteAuction,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
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
