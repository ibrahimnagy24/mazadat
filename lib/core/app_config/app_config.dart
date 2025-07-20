import 'package:flutter/material.dart';

class AppConfig {
  // static const LOCALE = 'https://2f04-197-61-38-60.eu.ngrok.io/api/v1/';
  static String appName = 'بيت العسجدية';
  static String BASE_URL = 'https://mazadat.api.innoeg.com';
  static String BASE_URL_STAGING = 'https://mazadat.api.innoeg.com';
  static String BASE_URL_PRODUCTION = 'https://mazadat.api.innoeg.com';

  static const BASE_URL_SHARE = 'https://mazadat.api.innoeg.com/details/';

  static const SHA1_DEBUG =
      '84:BC:EA:74:6D:BB:33:C7:96:6F:21:B3:39:CE:D7:DC:44:92:05:17';
  static const SHA1_RELEASE =
      '63:DB:1E:60:0C:50:D2:05:F5:FA:F6:77:F4:99:C8:53:BB:07:97:85';
  static const SHA256_RELEASE =
      '77:AE:31:71:D6:4B:2F:FD:00:93:62:82:80:9E:43:A8:05:A1:C4:16:05:A9:64:DE:A8:AA:37:F2:D8:06:A0:8E';
  static const SHA1_PROFILE =
      '84:BC:EA:74:6D:BB:33:C7:96:6F:21:B3:39:CE:D7:DC:44:92:05:17';

  static const ANDROID_CLIENT_ID = '107000000000000000000';
  static const IOS_CLIENT_ID = '10700001230000000';

  static const APP_LINK = 'https://mazadat.api.innoeg.com';

  static const PUSHER_API_KEY = '484829b34536dc168dcb';
  static const PUSHER_API_CLUSTER = 'eu';
  static const PUSHER_AUTH_ENDPOINT = 'https://mazadat.api.innoeg.com';

  static const int maximunNumberOfQuestions = 36;
  static const ScrollPhysics appPhysics = BouncingScrollPhysics();

  static APP_DEEP_LINK_JOIN_ROOM(String gameCode) =>
      'barq://app/join-room/$gameCode';
}
