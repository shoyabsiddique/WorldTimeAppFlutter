import 'package:flutter/material.dart';
import 'package:world_time/Services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setupWorldTime() async {
    WorldTime instance = WorldTime(location: "India", flag: "India", url: "/Asia/Kolkata");
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag':instance.flag,
      'isDayTime': instance.isDayTime
    });
  }
  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourGlass(
          color: Colors.black,
          size: 150,
          strokeWidth: 4,
        )
      )
    );
  }
}
