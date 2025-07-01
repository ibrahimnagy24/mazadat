import 'auction_enums.dart';

abstract class AuctionEnumConverter {
  static AuctionType stringToAuctionType(String value) {
    switch (value.toUpperCase()) {
      case 'PRIVATE':
        return AuctionType.private;
      default:
        return AuctionType.public;
    }
  }

  static String AuctionTypeToString(AuctionType value) {
    switch (value) {
      case AuctionType.private:
        return AuctionType.private.name.toUpperCase();
      case AuctionType.public:
        return AuctionType.public.name.toUpperCase();
    }
  }
}
