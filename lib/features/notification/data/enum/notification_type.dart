enum NotificationType {
  seller,
  buyer;

  String get arabicName {
    switch (this) {
      case NotificationType.seller:
        return 'بائع';
      case NotificationType.buyer:
        return 'مشتري';
    }
  }

  String get englishName {
    switch (this) {
      case NotificationType.seller:
        return 'Seller';
      case NotificationType.buyer:
        return 'Buyer';
    }
  }
}
