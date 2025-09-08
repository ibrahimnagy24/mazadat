import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/utils/utility.dart';
import '../entity/region_entity.dart';
import '../model/regions_model.dart';
import '../params/region_params.dart';

abstract class RegionsRepo {
  const RegionsRepo();

  static Future<Either<ErrorEntity, List<RegionEntity>>> getRegions(
      RegionParams params) async {
    try {
      final response = await Network().request(
        Endpoints.regions,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      List<RegionEntity> regions = checkFromArray(response.data['content'])
          ? (response.data['content'] as List)
              .map((e) => RegionModel.fromJson(e))
              .toList()
          : [];

      return Right(regions);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
