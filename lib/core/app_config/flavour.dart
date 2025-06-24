enum FlavorEnum { PRODUCTION, STAGING }

class Flavour {
  static FlavorEnum? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case FlavorEnum.PRODUCTION:
        return 'Mazadat';
      case FlavorEnum.STAGING:
        return 'Mazadat Staging';
      default:
        return 'title';
    }
  }
}
