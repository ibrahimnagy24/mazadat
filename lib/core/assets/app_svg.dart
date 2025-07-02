import '../../features/auctions/data/enums/auction_enums.dart';

class AppSvg {
  static const String _svgPath = 'assets/svgs';
  //mazadat
  static const String saudiArabiaFlag = '$_svgPath/saudi_arabia_flag.svg';
  //mazadat
  static const String checkRightCircle = '$_svgPath/tick_circle.svg';
  static const String tickCheck = '$_svgPath/tick_check.svg';
  //mazadat
  //mazadat
  static const String searchIcon = '$_svgPath/search_icon.svg';
  //mazadat
  static const String filterIcon = '$_svgPath/filter_icon.svg';
  //mazadat
  static const String timer = '$_svgPath/timer.svg';
  //mazadat
  static const String calendar = '$_svgPath/calendar.svg';
  //mazadat
  static const String saudiArabiaSymbol = '$_svgPath/Saudi_Riyal_Symbol.svg';
  static const String logo = '$_svgPath/logo.svg';
  static const String success = '$_svgPath/success.svg';
  static const String edit = '$_svgPath/edit.svg';
  static const String male = '$_svgPath/male.svg';
  static const String female = '$_svgPath/female.svg';
  static gender(v) => '$_svgPath/$v.svg';
  static const String backArrow = '$_svgPath/back_arrow.svg';
  static const String user = '$_svgPath/user.svg';
  static const String notification = '$_svgPath/notification.svg';
  static const String menu = '$_svgPath/menu.svg';
  static const String favourite = '$_svgPath/favourite.svg';
  static const String auction = '$_svgPath/auction.svg';
  static const String list = '$_svgPath/list.svg';
  static const String grid = '$_svgPath/grid.svg';
  static const String package = '$_svgPath/package.svg';
  static const String fav = '$_svgPath/fav.svg';
  static const String fillFav = '$_svgPath/fill_fav.svg';
  static auctionType(AuctionType type) =>
      type == AuctionType.public ? public : private;
  static const String public = '$_svgPath/public.svg';
  static const String private = '$_svgPath/private.svg';
  static const String arrowBack = '$_svgPath/arrow_back.svg';
  static const String filter = '$_svgPath/filter.svg';
}
