import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/utils/utility.dart';
import '../entity/category_entity.dart';
import '../model/category_model.dart';

abstract class CategoryRepo {
  const CategoryRepo();

  static Future<Either<ErrorEntity, List<CategoryEntity>>> categories() async {
    try {
      final response = await Network().request(
        Endpoints.getCategories,
        method: ServerMethods.GET,
      );
      final List<CategoryEntity> user = checkFromArray(response.data['content'])
          ? (response.data['content'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : [];
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
