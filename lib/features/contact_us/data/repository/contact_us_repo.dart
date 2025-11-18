import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../../core/utils/utility.dart';
import '../entities/contact_us_response_entity.dart';
import '../entities/message_type_entity.dart';
import '../entities/whatsapp_config_entity.dart';
import '../models/contact_us_response_model.dart';
import '../models/message_type_model.dart';
import '../models/whatsapp_config_model.dart';
import '../params/contact_us_request_params.dart';

abstract class ContactUsRepo {
  const ContactUsRepo();

  static Future<Either<ErrorEntity, List<MessageTypeEntity>>> getMessageTypes() async {
    try {
      final response = await Network().request(
        Endpoints.messageTypesContactUs,
        method: ServerMethods.GET,
      );
      final List<MessageTypeEntity> messageTypes = checkFromArray(response.data['content'])
          ? (response.data['content'] as List).map((e) => MessageTypeModel.fromJson(e)).toList()
          : [];
      return Right(messageTypes);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, ContactUsResponseEntity>> submitContactRequest(
    ContactUsRequestParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.contactRequestAdd,
        method: ServerMethods.POST,
        body: params.toJson(),
      );
      final ContactUsResponseEntity contactResponse = ContactUsResponseModel.fromJson(response.data);
      return Right(contactResponse);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, WhatsappConfigEntity>> getWhatsappConfiguration() async {
    try {
      final response = await Network().request(
        Endpoints.contactConfiguration,
        method: ServerMethods.GET,
      );
      final WhatsappConfigEntity whatsappConfig = WhatsappConfigModel.fromJson(response.data);
      return Right(whatsappConfig);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
