import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  String location = "";
  String time = "";
  String flag = "";
  String url = "";
  bool isDayTime = true;

  WorldTime({this.location = "", this.flag = "", this.url = ""});
  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from data
      String dateTime = data['datetime'];
      int hour_off = int.parse(data['utc_offset'].substring(1, 3));
      int min_off = int.parse(data['utc_offset'].substring(4, 6));
      String sign = data['utc_offset'].substring(0, 1);
      //Create a datetime object
      DateTime now = DateTime.parse(dateTime);
      if (sign == '+')
        now = now.add(Duration(hours: hour_off, minutes: min_off));
      else
        now = now.subtract(Duration(hours: hour_off, minutes: min_off));
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = "Could not find time data";
    }
  }
}
