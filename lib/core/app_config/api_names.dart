import '../../features/bundle_details/data/params/bundle_details_route_params.dart';

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
  static const String deleteAccount = '/users/deleteAccount';
  static const String checkDeleteAccount = '/users/checkDeleteAccount';
//----------------------------------HOME--------------------------------------\\
  static const String homeBundles = '/bundles/searchBundles';
  static const String homeAuction = '/auctions/homePageFilterAuction';

  static auctionDetails(id) => '/auctions/viewAuction/$id';
  static validateAuctionJoining(id) => '/auctions/validateJoining?id=$id';
  static const String submitJoiningAuction = '/auctions/submitJoining';
  static const String checkOnJoiningAuction = '/auctions/checkInsurancePayment';
  static const String auctionBidding = '/bidding/placeBid';
  static const String switchBiddingMethod = '/bidding/switchBiddingMethod';
  static const String withdrawAuction = '/auctions/withdrawAuction';
  static const String auctions = '/auctions/list';
  static const String featuredAuction = '/auctions/featuredAuction';
  static const String inProgressAuction = '/auctions/liveAuction';
  static const String upComingAuction = '/auctions/upcommingAuction';
//----------------------------------CATEGORY--------------------------------------\\
  static const String getCategories = '/auctionCategory/listActiveCategories';

  //----------------------------------SEARCH--------------------------------------\\
  static const String getSearchResult = '/searchResult/getLatestSearchResult';
  static String deleteSearchResult(id) => '/searchResult/delete?id=$id';
  static const String deleteAllSearchResult = '/searchResult/deleteAll';
  static const String getSearch = homeAuction;

  static const String myPurchases = '/shipments/searchMyPurchases';
  static const String mySales = '/auctions/homePageFilterAuction';

//----------------------------------WALLET--------------------------------------\\
  static const String walletHistory = '/wallet/viewMyWallet';
  static const String chargeWallet = '/wallet/chargeBalance';
  static const String checkWalletCharge = '/wallet/checkWalletCharge';

//--------------------------------Addresses--------------------------------------\\

  static const String addressTypes = '/addressType/listAddressTypeLookups';
  static const String cities = '/cities/search';
  static const String regions = '/regions/search';
  static const String districts = '/district/search';

  static const String addresses = '/address/getMyAddresses';
  static const String addAddresses = '/address/add';
  static const String editAddresses = '/address/update';
  static const String deleteAddresses = '/address/delete';

//--------------------------------Favourites--------------------------------------\\

  static const String getFavorites = '/favorites/getFavoriteList';
  static const String toggleFavoriteAuction =
      '/favorites/toggleFavoriteAuction';
//----------------------------------BUNDLES--------------------------------------\\
  static String viewBundle(BundleDetailsRouteParams params) =>
      '/bundles/view/${params.bundleId}';
//--------------------------------USER OPERATIONS--------------------------------------\\
  static const String getUserInfo = '/users/viewMyProfile';
  static const String updateUserInfo = '/users/updateMyProfile';
  static const String updateBankInfo = '/users/updateMyBankDetails';

//--------------------------------STATIC PAGES--------------------------------------\\
  static const String privacyAndPolicy =
      '/setting/getContent?code=PRIVACY_POLICY';
  static const String support = '/settings?key=support&limit=1000';
  static const String termsAndConditions =
      '/setting/getContent?code=TERMS_CONDITION';
  static const String gameSettings = '/game-settings';
  static const String aboutUs = '/setting/getContent?code=ABOUT_US';
//-------------------------------NOT TESTED------------------------------------\\

  static const String paymentList = '/paymentMehods/listAll';
  static const String ages = '/age/listAgeLookups';
  static const String auctionStatuses =
      '/utils/getLookup?lookups=AUCTION_STATUS';
  static const String banks = '/banks/searchBanks';
  static const String googleLogin = '/client/google';
}
