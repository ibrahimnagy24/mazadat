import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/utils/utility.dart';
import '../entity/district_entity.dart';
import '../model/districts_model.dart';
import '../params/district_params.dart';

abstract class DistrictsRepo {
  const DistrictsRepo();

  static Future<Either<ErrorEntity, List<DistrictEntity>>> getDistricts(
      DistrictParams params) async {
    try {
      final response = await Network().request(
        Endpoints.districts,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      List<DistrictEntity> districts = checkFromArray(response.data['content'])
          ? (response.data['content'] as List)
              .map((e) => DistrictModel.fromJson(e))
              .toList()
          : [];

      return Right(districts);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
