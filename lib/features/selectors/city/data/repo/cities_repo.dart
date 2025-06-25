import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../../core/utils/utility.dart';
import '../entity/city_entity.dart';
import '../model/city_model.dart';

abstract class CitiesRepo {
  const CitiesRepo();

  static Future<Either<ErrorEntity, List<CityEntity>>> getCities() async {
    try {
      final response = await Network().request(
        Endpoints.cities,
        method: ServerMethods.GET,
      );
      final List<CityEntity> user = checkFromArray(response.data['content'])
          ? (response.data['content'] as List)
              .map((e) => CityModel.fromJson(e))
              .toList()
          : [];
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
