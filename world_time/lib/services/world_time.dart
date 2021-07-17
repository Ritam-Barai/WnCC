import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{

    String location;
    String time;
    String flag;
    String uRl;
    bool isDayTime;

    WorldTime({this.location, this.flag, this.uRl,});

    Future<void> getTime() async{

      try{
        var url=Uri.parse('https://worldtimeapi.org/api/timezone/$uRl');
        Response response=await get(url);
        Map data =jsonDecode(response.body);

        String datetime=data['datetime'];
        String offset1= data['utc_offset'].substring(1,3);
        String offset2= data['utc_offset'].substring(4,6);

        DateTime now=DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

        isDayTime =now.hour>5 && now.hour<18 ?true : false;
        time = DateFormat.jm().format(now);
      }

      catch(e){
          print('Caught error:$e');
          time=' Could Not Find Time';
      }

    }
}