abstract class Endpoints {
//--------------------------------TESTED--------------------------------------\\
  static const String login = '/authenticate/login';
  static const String register = '/authenticate/register';
  static const String verifyCode = '/users/verifyAccount';
  static const String resendCode = '/users/sendVerificationCode';
  static const String forgotPassword = '/users/sendVerificationCode';
  static const String changePhoneNumber = '/users/updateMyPhoneNumber';
  static const String visitor = '/visitors/checkIn';
  static const String resetPassword = '/users/updatePassword';
  static const String changePassword = '/users/changePassword';
//----------------------------------HOME--------------------------------------\\

  static const String homeBundles = '/bundles/searchBundles';

  static const String homeAuction = '/auctions/homePageFilterAuction';
  static const String auctions = '/auctions/list';
  static const String featuredAuction = '/auctions/featuredAuction';
  static const String inProgressAuction = '/auctions/liveAuction';
  static const String upComingAuction = '/auctions/upcommingAuction';
//----------------------------------CATEGORY--------------------------------------\\
  static const String getCategories = '/auctionCategory/listActiveCategories';

  //----------------------------------SEARCH--------------------------------------\\
  static const String getSearchResult = '/searchResult/getLatestSearchResult';
  static const String getSearch = homeAuction;

//--------------------------------USER OPERATIONS--------------------------------------\\
  static const String getUserInfo = '/profile';

//--------------------------------STATIC PAGES--------------------------------------\\
  static const String privacyAndPolicy =
      '/settings?key=policies_terms&limit=1000';
  static const String support = '/settings?key=support&limit=1000';

  static const String gameSettings = '/game-settings';

//-------------------------------NOT TESTED------------------------------------\\

  static const String cities = '/cities/searchByKeyword';
  static const String ages = '/age/listAgeLookups';
  static const String auctionStatuses = '/auction/statuses';
  static const String banks = '/banks/searchBanks';
  static const String googleLogin = '/client/google';
}
