import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String url = "";
  Color color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    if(data['isDayTime']) {
      url = "assets/day/day.png";
      color = Colors.blue;
    }
    else {
      url = "assets/day/night.png";
      color = Colors.indigo;
    }
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(url),
                fit: BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDayTime': result['isDayTime']
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location,
                    color: Colors.grey[300]
                    ),
                    label: Text('Edit Location',
                      style: TextStyle(
                        color: Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center
                    ,
                    children: [
                      Text(
                        "${data['location']}",
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
