part of 'notification_helper.dart';

scheduleNotification(String title, String subtitle, String data) async {
  var rng = math.Random();
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel_id',
    'your channel name',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
    icon: '@drawable/ic_notifications',
  );
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await _notificationsPlugin!.show(
    rng.nextInt(100000),
    title,
    subtitle,
    platformChannelSpecifics,
    payload: data,
  );
}

void iOSPermission() {
  _firebaseMessaging!.requestPermission(alert: true, announcement: true, badge: true, sound: true);
}

// void handlePath(Map dataMap) {
//   // updateUserFunctions(notify: dataMap);
//   // handlePathByRoute(dataMap);
// }

// updateUserFunctions({@required notify}) async {
//   if (notify['type'] == 'block') {
//     Future.delayed(Duration.zero, () {
//       LogoutBloc.instance.add(Click());
//       AppCore.showSnackBar(
//         notification: AppNotification(
//           message: 'you_are_blocked'.tr,
//           backgroundColor: AppColors.IN_ACTIVE,
//           borderColor: AppColors.DARK_RED,
//           iconName: 'fill-close-circle',
//         ),
//       );
//     });
//   } else if (notify['type'] == 'vendor' && notify['navigateType'] == 'cancel_order') {
//     Future.delayed(Duration.zero, () {
//       CustomNavigator.push(Routes.mainPage, arguments: 0, clean: true);
//     });
//   } else {}
// }

// Future<void> handlePathByRoute(Map notify) async {
//   cprint('routes $notify');
//   // bool? inChat = await SharedHelper.sharedHelper!.readBoolean(CachingKey.IN_CHAT);
//   // bool? inOffersView = await SharedHelper.sharedHelper!.readBoolean(CachingKey.IN_OFFERS_VIEW);
//   // bool? inOrderDetails = await SharedHelper.sharedHelper!.readBoolean(CachingKey.IN_ORDER_DETAILS);
//
//   if (notify['id'] != null) {
//     if (notify['navigateType'] == 'new_order' && notify['type'] == 'vendor') {
//       CustomNavigator.push(Routes.HomeNavBar, arguments: 0, clean: true);
//     } else if (notify['navigateType'] == 'chat' && !inChat) {
//       CustomNavigator.push(Routes.ChatView, arguments: int.parse(notify['id'].toString()));
//     } else if (notify['navigateType'] == 'offer' && !inOffersView && notify['type'] != 'vendor') {
//       CustomNavigator.push(Routes.OFFERS, arguments: int.parse(notify['id'].toString()));
//     } else if (notify['navigateType'] == 'order' && !inOrderDetails) {
//       if (notify['type'] == 'vendor') {
//         CustomNavigator.push(Routes.VENDOR_ORDER_DETAILS, arguments: int.parse(notify['id'].toString()));
//       } else {
//         CustomNavigator.push(Routes.OrderDetailsView, arguments: int.parse(notify['id'].toString()));
//       }
//     }
//   }
// }

downloadAndSaveFile(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await http.get(Uri.parse(url));
  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}
