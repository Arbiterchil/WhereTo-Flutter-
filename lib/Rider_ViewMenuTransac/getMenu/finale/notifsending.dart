
import 'dart:convert';

import 'package:http/http.dart' as http;
class NotifSend{

  notifySend(String device,String message) async{
     String url = 'https://onesignal.com/api/v1/notifications';
        var contents = {
          "include_player_ids": ["$device"],
          "include_segments": ["Users Notif"],
          "excluded_segments": [],
          "large_icon": "https://res.cloudinary.com/amadpogi/image/upload/v1600008167/logo_nh4bpx.png",
          "contents": {"en": "$message"},
          "headings": {"en": "WhereTo Rider"},
          "filter": [
            {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
          ],
          "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
        };
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
        };
        var repo =
            await http.post(url, headers: headers, body: json.encode(contents));
            print(repo.body);
  }

}

final notifyingSend = NotifSend();