import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(uRl: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(uRl: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(uRl: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(uRl: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(uRl: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(uRl: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(uRl: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(uRl: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(uRl: 'Asia/Kolkata', location: 'Kolkata', flag: 'india.png'),
  ];

  void updateTime(index) async {
        WorldTime instance=locations[index];
        await instance.getTime();
        Navigator.pop(context,{
          'location':instance.location,
          'flag':instance.flag,
          'time':instance.time,
          'isDaytime':instance.isDayTime,
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:AppBar(
          backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:ListView.builder(
          itemCount: locations.length,
          itemBuilder:(context,index){
            return Padding(
              padding:EdgeInsets.symmetric(vertical:1.0,horizontal: 4.0 ),
              child: Card(
                child:ListTile(
                  onTap:(){
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading:CircleAvatar(
                    backgroundImage: AssetImage('images/${locations[index].flag}') ,
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
