import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/services/error_handler/error_handler.dart';
import '../../../core/services/network/network_helper.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../entity/save_file_entity.dart';
import '../model/save_file_model.dart';
import '../params/save_file_params.dart';

abstract class SaveFileRepo {
  const SaveFileRepo();

  static Future<Either<ErrorEntity, SaveFileEntity>> saveFile(
      SaveFileParams params) async {
    try {
      final body = await params.returnedMap();
      final response = await Network().request(
        'Endpoints.saveFile',
        method: ServerMethods.POST,
        body: FormData.fromMap(body),
        timoutDuration: const Duration(minutes: 10),
      );
      return Right(SaveFileModel.fromJson(
        response.data['data']['file'],
        message: response.data['message'],
      ));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
