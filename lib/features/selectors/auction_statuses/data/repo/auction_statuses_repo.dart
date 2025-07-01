import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../../core/utils/utility.dart';
import '../entity/auction_types_entity.dart';
import '../model/auction_types_model.dart';

abstract class AuctionStatusesRepo {
  const AuctionStatusesRepo();

  static Future<Either<ErrorEntity, List<AuctionStatusesEntity>>>
      getAuctionStatuses() async {
    try {
      final response = await Network().request(
        Endpoints.auctionStatuses,
        method: ServerMethods.GET,
      );
      final List<AuctionStatusesEntity> user = checkFromArray(response.data)
          ? (response.data as List)
              .map((e) => AuctionStatusModel.fromJson(e))
              .toList()
          : [];
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
