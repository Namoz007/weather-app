import 'dart:ffi';

import 'package:weather/models/weather.dart';
import 'package:weather/services/weather_http_services.dart';

class WeatherController{
  final services = WeatherHttpServices();

  Future<Weather> getWeather(String city) async{
    return await services.getWeather(city);
  }
}