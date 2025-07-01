import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../../core/utils/utility.dart';
import '../entity/age_entity.dart';
import '../model/age_model.dart';

abstract class CitiesRepo {
  const CitiesRepo();

  static Future<Either<ErrorEntity, List<AgeEntity>>> getAges() async {
    try {
      final response = await Network().request(
        Endpoints.ages,
        method: ServerMethods.GET,
      );
      final List<AgeEntity> user = checkFromArray(response.data)
          ? (response.data as List)
              .map((e) => AgeModel.fromJson(e))
              .toList()
          : [];
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
