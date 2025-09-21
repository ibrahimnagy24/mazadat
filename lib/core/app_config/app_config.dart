import 'package:flutter/material.dart';

class AppConfig {
  // static const LOCALE = 'https://2f04-197-61-38-60.eu.ngrok.io/api/v1/';
  static String appName = 'بيت العسجدية';
  static String BASE_URL = 'https://mazadat.api.innoeg.com';
  static String BASE_URL_STAGING = 'https://mazadat.api.innoeg.com';
  static String BASE_URL_PRODUCTION = 'https://mazadat.api.innoeg.com';

  static const BASE_URL_SHARE = 'https://mazadat.api.innoeg.com/details/';

  static const SHA1_DEBUG =
      'D5:FD:7C:36:92:0C:8C:47:22:E8:96:CD:54:D0:D0:ED:DB:3E:52:DA';
  static const SHA1_RELEASE =
      '11:8D:29:95:14:40:EA:DD:EB:64:D5:D3:D8:66:0E:41:77:60:10:58';
  static const SHA1_PROFILE =
      'D5:FD:7C:36:92:0C:8C:47:22:E8:96:CD:54:D0:D0:ED:DB:3E:52:DA';

  static const SHA256_DEBUG =
      'B3:E0:C7:A8:3B:22:06:27:69:01:16:F8:5C:7E:0A:D2:65:DC:B1:32:EB:8F:25:81:23:1F:87:FD:F5:13:A6:FB';
  static const SHA256_RELEASE =
      '86:FF:9C:62:04:C0:0C:6E:3F:B3:7B:3A:93:15:7E:C3:94:2D:7C:D4:2E:65:E8:C6:19:3F:47:F0:6A:7D:48:58';

  static const APP_LINK = 'https://mazadat.api.innoeg.com';

  static const PUSHER_API_KEY = '7e8582c43911de45f74c';
  static const PUSHER_API_CLUSTER = 'eu';
  static const PUSHER_AUTH_ENDPOINT = 'https://mazadat.api.innoeg.com';

  static const int maximunNumberOfQuestions = 36;
  static const ScrollPhysics appPhysics = BouncingScrollPhysics();

  // static APP_DEEP_LINK_JOIN_ROOM(String gameCode) =>
  //     'barq://app/join-room/$gameCode';
}
