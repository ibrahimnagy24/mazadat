abstract class Endpoints {
//--------------------------------TESTED--------------------------------------\\
  static const String login = '/authenticate/login';
  static const String register = '/authenticate/register';
  static const String verifyCode = '/users/verifyAccount';
  static const String resendCode = '/users/sendVerificationCode';
  static const String forgotPassword = '/users/sendVerificationCode';
  static const String visitor = '/visitors/checkIn';
  static const String resetPassword = '/reset/password';
//----------------------------------HOME--------------------------------------\\
  static const String featuredAuction = '/auctions/featuredAuction';
  static const String inProgressAuction = '/auctions/liveAuction';
  static const String upComingAuction = '/auctions/upcommingAuction';
//----------------------------------CATEGORY--------------------------------------\\
  static const String getCategories = '/auctionCategory/listActiveCategories';

//--------------------------------USER OPERATIONS--------------------------------------\\
  static const String getUserInfo = '/profile';

//--------------------------------STATIC PAGES--------------------------------------\\
  static const String privacyAndPolicy =
      '/settings?key=policies_terms&limit=1000';
  static const String support = '/settings?key=support&limit=1000';

  static const String gameSettings = '/game-settings';

//-------------------------------NOT TESTED------------------------------------\\

  static const String cities = 'cities';
  static const String ages = 'ages';
  static const String googleLogin = 'client/google';
}
