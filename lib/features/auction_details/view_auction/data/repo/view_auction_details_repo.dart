import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../entity/view_auction_details_entity.dart';
import '../model/auction_bidding_model.dart';
import '../model/view_auction_details_model.dart';
import '../params/auction_bid_params.dart';
import '../params/get_auction_details_params.dart';

abstract class ViewAuctionDetailsRepo {
  static Future<Either<ErrorEntity, ViewAuctionDetailsEntity>>
      getAuctionDetails(GetAuctionDetailsParams params) async {
    try {
      final response = await Network().request(
        Endpoints.auctionDetails(params.id),
        method: ServerMethods.GET,
      );

      return Right(ViewAuctionDetailsModel.fromJson(response.data['DATA']));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, AuctionBiddingModel>> auctionBid(
      AuctionBidParams params) async {
    try {
      final response = await Network().request(
        Endpoints.auctionBidding,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      return Right(AuctionBiddingModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
