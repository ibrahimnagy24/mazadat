import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../entity/notifications_response_entity.dart';
import '../entity/seen_all_notification_response_entity.dart';
import '../entity/seen_notification_response_entity_new.dart';
import '../model/notifications_response_model.dart';
import '../model/seen_all_notification_response_model.dart';
import '../model/seen_notification_response_model_new.dart';
import '../params/get_notification_params.dart';

abstract class NotificationRepo {
  const NotificationRepo();

  static Future<Either<ErrorEntity, NotificationsResponseEntity>>
      getNotifications(GetNotificationParams params) async {
    try {
      final response = await Network().request(
        Endpoints.userNotificationList,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final notificationsResponse =
          NotificationsResponseModel.fromJson(response.data);
      return Right(notificationsResponse);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, SeenAllNotificationResponseEntity>>
      seenAllNotification() async {
    try {
      final response = await Network().request(
        Endpoints.seenAllNotification,
        method: ServerMethods.GET,
      );

      final seenAllResponse =
          SeenAllNotificationResponseModel.fromJson(response.data);
      return Right(seenAllResponse);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, SeenNotificationResponseEntity>>
      seenNotification(int notificationId) async {
    try {
      final response = await Network().request(
        '${Endpoints.seenNotification}/$notificationId',
        method: ServerMethods.GET,
      );

      final SeenNotificationResponseEntity seenResponse =
          SeenNotificationResponseModel.fromJson(response.data);
      return Right(seenResponse);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
