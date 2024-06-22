import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';

class GetWeather extends StatefulWidget {
  String city;
  GetWeather({super.key,required this.city});

  @override
  State<GetWeather> createState() => _GetWeatherState();
}

class _GetWeatherState extends State<GetWeather> {
  final controller = WeatherController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getWeather(widget.city),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          print('${widget.city}');
          return CircularProgressIndicator(color: Color(0xFF2E335A),);
        }

        if(snapshot.hasError)
          return Center(child: Icon(Icons.cancel,color: Colors.red,),);

        if(!snapshot.hasData)
          return Center(child: Text("Hech qanaqa ma'lumot topilmadi!"),);
        return Container();
      },
    );
  }
}
