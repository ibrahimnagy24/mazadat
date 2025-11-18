import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/utils/utility.dart';
import '../entities/faq_entity.dart';
import '../models/faq_model.dart';

abstract class FaqRepo {
  const FaqRepo();

  static Future<Either<ErrorEntity, Map<String, dynamic>>> getFaqs() async {
    try {
      final response = await Network().request(
        Endpoints.publicQuestions,
        method: ServerMethods.GET,
      );
      final List<FaqEntity> faqs =
          checkFromArray(response.data['DATA']['content'])
              ? (response.data['DATA']['content'] as List)
                  .map((e) => FaqModel.fromJson(e))
                  .toList()
              : [];
      final String? lastUpdateDate = response.data['LAST_UPDATE_DATE'];
      return Right({
        'faqs': faqs,
        'lastUpdateDate': lastUpdateDate,
      });
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
