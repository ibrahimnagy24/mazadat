import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../params/get_preview_auction_details_params.dart';
import '../params/preview_auction_validation_params.dart';
import '../params/preview_auction_joining_params.dart';
import '../params/preview_auction_bidding_params.dart';
import '../params/preview_auction_withdrawal_params.dart';

abstract class PreviewAuctionRepository {
  static Future<Either<ErrorEntity, Response>> getAuctionDetails(
    GetPreviewAuctionDetailsParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.auctionDetails(params.id),
        method: ServerMethods.GET,
      );
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> getAuctionBids(int id) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/$id/bids',
        method: ServerMethods.GET,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  // Bidding Methods
  static Future<Either<ErrorEntity, Response>> placeBid(
      int auctionId, double amount) async {
    try {
      final response = await Network().request(
        '/api/v1/bids',
        method: ServerMethods.POST,
        body: {'auction_id': auctionId, 'amount': amount},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> getMyBids(int auctionId) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/$auctionId/my-bids',
        method: ServerMethods.GET,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> getHighestBid(
      int auctionId) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/$auctionId/highest-bid',
        method: ServerMethods.GET,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  // Favorite Methods
  static Future<Either<ErrorEntity, Response>> toggleFavorite(
      int auctionId) async {
    try {
      final response = await Network().request(
        '/api/v1/favorites/toggle',
        method: ServerMethods.POST,
        body: {'auction_id': auctionId},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  // Categories Methods
  static Future<Either<ErrorEntity, Response>> getCategories() async {
    try {
      final response = await Network().request(
        '/api/v1/categories',
        method: ServerMethods.GET,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  // Share Methods
  static Future<Either<ErrorEntity, Response>> shareAuction(
      int auctionId) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/share',
        method: ServerMethods.POST,
        body: {'auction_id': auctionId},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> auctionWithdrawal(
      PreviewAuctionWithdrawalParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/withdraw',
        method: ServerMethods.GET,
        queryParameters: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  // Additional methods that were referenced in cubit
  static Future<Either<ErrorEntity, Response>> validateJoiningAuction(
      PreviewAuctionValidationParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/validate-joining',
        method: ServerMethods.POST,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> validateJoiningAuctionById(
      int id) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/$id/validate-joining',
        method: ServerMethods.GET,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> submitJoining(
      PreviewAuctionJoiningParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/join',
        method: ServerMethods.POST,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> checkOnJoining(
      PreviewAuctionValidationParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/auctions/check-joining',
        method: ServerMethods.POST,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> firstBid(
      PreviewAuctionBiddingParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/bids/first',
        method: ServerMethods.POST,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> manualBidding(
      PreviewAuctionBiddingParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/bids/manual',
        method: ServerMethods.POST,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, Response>> switchBidding(
      PreviewAuctionBiddingParams params) async {
    try {
      final response = await Network().request(
        '/api/v1/bids/switch',
        method: ServerMethods.POST,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
