import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/views/widgets/search_city.dart';

class HomeScreen extends StatefulWidget {
  List<String> citys;
  Weather weather;
  HomeScreen({super.key,required this.weather,required this.citys});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = WeatherController();
  Map<String,Icon> icons = {
    "01d": const Icon(CupertinoIcons.sun_max_fill,color: Colors.yellow,size: 130,),
    "02d": const Icon(CupertinoIcons.cloud_sun_fill,color: Colors.white,size: 130,),
    "03d": const Icon(CupertinoIcons.cloud_fill,color: Colors.white,size: 130,),
    "04d": const Icon(Icons.cloud,color: Colors.white,size: 130,),
    "09d": const Icon(CupertinoIcons.cloud_rain_fill,color: Colors.white,size: 130,),
    "10d": const Icon(CupertinoIcons.cloud_rain_fill,color: Colors.white,size: 130,),
    "11d": const Icon(CupertinoIcons.cloud_bolt_fill,color: Colors.white,size: 130,),
    "13d": const Icon(CupertinoIcons.snow,color: Colors.grey,size: 130,),
    "50d": const Icon(CupertinoIcons.wind,color: Colors.white,size: 130,),

    "01n": const Icon(CupertinoIcons.moon_fill,color: Colors.white,size: 130,),
    "02n": const Icon(CupertinoIcons.cloud_moon_fill,color: Colors.grey,size: 130,),
    "03n": const Icon(CupertinoIcons.cloud_fill,color: Colors.grey,size: 130,),
    "04n": const Icon(Icons.cloud,color: Colors.grey,size: 130,),
    "09n": const Icon(CupertinoIcons.cloud_rain_fill,color: Colors.grey,size: 130,),
    "10n": const Icon(CupertinoIcons.cloud_rain_fill,color: Colors.grey,size: 130,),
    "11n": const Icon(CupertinoIcons.cloud_bolt_fill,color: Colors.grey,size: 130,),
    "13n": const Icon(CupertinoIcons.snow,color: Colors.grey,size: 130,),
    "50n": const Icon(CupertinoIcons.wind,color: Colors.grey,size: 130,),
  };
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double temp = double.parse(widget.weather.temp) - 273.15;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async{
            setState(() {
              isLoading = true;
            });
            Weather data = await controller.getWeather(widget.weather.city);
            setState(() {
              widget.weather = data;
              isLoading = false;
            });
          },
          icon: const Icon(Icons.update,color: Colors.white,size: 30,),
        ),
        backgroundColor: const Color(0xFF2E335A),
        title: Text("Weather(${widget.weather.city})",style: const TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            final response = await showSearch(context: context, delegate: SearchViewDelegate(widget.weather, widget.citys));
            if(response != null){
              final pref = await SharedPreferences.getInstance();
              setState(() {
                isLoading = true;
              });
              Weather data = await controller.getWeather(response.toString());
              await pref.setString('city', response.toString());
              setState(() {
                isLoading = false;
                widget.weather = data;
              });
            }
            const CircularProgressIndicator();
          }, icon: const Icon(Icons.location_on_outlined,size: 30,color: Colors.white,))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            isLoading ? const CircularProgressIndicator() : Center(
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  icons['${widget.weather.iconCode}'] ?? const SizedBox(),
                  Text("${widget.weather.city}",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                  Text("${temp.toString().split('.')[0]}°",style: const TextStyle(fontSize: 100,color: Colors.white),),
                  Text("${widget.weather.description[0].toUpperCase()}${widget.weather.description.substring(1,widget.weather.description.length).toLowerCase()}",style: const TextStyle(fontSize: 25,color: Colors.white),),
                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.wind_snow,size: 30,color: Colors.white,),
                      const SizedBox(width: 10,),
                      Text("${widget.weather.windSpeed} m/s",style: const TextStyle(fontSize: 20,color: Colors.white),)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
