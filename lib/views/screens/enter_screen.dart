import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controllers/citys_controller.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/views/screens/home_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final controller = WeatherController();
  final citys = CitysController();
  String city = '';

  @override
  void initState(){
    print('go');
    super.initState();
    getCity();
  }

  void getCity() async{
    final pref = await SharedPreferences.getInstance();
    final response = pref.getString('city');
    if(response == null){
      setState(() {
        city = 'tashkent';
      });
    }else{
      setState(() {
        city = response.toString();
      });
    }

    Weather data = await controller.getWeather(city);
    List<String> allCitys = await citys.getCitys();
    allCitys.sort();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(weather: data,citys: allCitys,)));

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E335A),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2E335A),
                  Color(0xFF7582F4),
                ]
            )
        ),
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Weather",style: TextStyle(fontSize: 40,color: Colors.white),),
            SizedBox(height: 20,),
            CircularProgressIndicator(color: Color(0xFF2E335A),),
            SizedBox(height: 10,),
            Text('Please wait...',style: TextStyle(color: Colors.white,fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
