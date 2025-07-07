import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../../core/utils/utility.dart';
import '../entity/age_entity.dart';
import '../model/bank_model.dart';

abstract class BanksRepo {
  const BanksRepo();

  static Future<Either<ErrorEntity, List<BankEntity>>> getBanks() async {
    try {
      final response = await Network().request(
        Endpoints.ages,
        method: ServerMethods.GET,
      );
      final List<BankEntity> user = checkFromArray(response.data['content'])
          ? (response.data['content'] as List)
              .map((e) => BankModel.fromJson(e))
              .toList()
          : [];
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
