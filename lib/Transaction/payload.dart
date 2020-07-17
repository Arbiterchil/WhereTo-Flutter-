// import 'dart:convert';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:http/http.dart' as http;

// sentNotif(String restoStreet) async {
//   await OneSignal.shared.setLocationShared(true);
//   await OneSignal.shared.promptLocationPermission();

//   await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

//   OneSignal.shared
//       .setInFocusDisplayType(OSNotificationDisplayType.notification);
//   await OneSignal.shared.setSubscription(true);

//   var tags = await OneSignal.shared.getTags();
//   print(tags);

//   var status = await OneSignal.shared.getPermissionSubscriptionState();
//   String url = 'https://onesignal.com/api/v1/notifications';
//   var playerId = status.subscriptionStatus.userId;

//   await OneSignal.shared.sendTags({"$restoStreet": "True"});
//   var contents = {
//     "include_player_ids": [playerId],
//     "include_segments": ["Penongs Users"],
//     "excluded_segments": [],
//     "contents": {"en": "hehhehehehehhe"},
//     "headings": {"en": "Jayce Mico Trial"},
//     // "data":{"test":userData["name"]},
//     "filter": [
//       {"field": "tag", "key": "$restoStreet", "relation": "=", "value": "True"},
//     ],
//     "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
//   };
//   Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
//   };
//   var repo =
//       await http.post(url, headers: headers, body: json.encode(contents));
//   print(repo.body);
// }
