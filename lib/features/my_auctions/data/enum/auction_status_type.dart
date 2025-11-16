import '../../../../core/shared/blocs/main_app_bloc.dart';

enum AuctionStatusType { ongoing, finished, cancelled }

extension AuctionStatusTypeExtension on AuctionStatusType {
  String get arabicName {
    switch (this) {
      case AuctionStatusType.ongoing:
        return mainAppBloc.isArabic ? 'جارية' : 'Ongoing';
      case AuctionStatusType.finished:
        return mainAppBloc.isArabic ? 'منتهيه' : 'Finished';
      case AuctionStatusType.cancelled:
        return mainAppBloc.isArabic ? 'مُلغاه' : 'Cancelled';
    }
  }
}

extension AuctionStatusTypeEndPointStatusExtension on AuctionStatusType {
  String get name {
    switch (this) {
      case AuctionStatusType.ongoing:
        return 'IN_PROGRESS';
      case AuctionStatusType.finished:
        return 'COMPLETED';
      case AuctionStatusType.cancelled:
        return 'CANCELED';
    }
  }
}
