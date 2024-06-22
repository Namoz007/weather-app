import 'dart:convert';
import 'package:weather/models/weather.dart';
import 'package:http/http.dart' as http;


class WeatherHttpServices{
  final String apiKey = "b6c571512ddd5ed4c2314a41788a6b5a";

  Future<Weather> getWeather(String city) async{
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}');
    final response = await http.get(url);
    Map<String,dynamic> data = jsonDecode(response.body);
    return Weather(city: data['name'].toString(),temp: data['main']['temp'].toString(), description: data['weather'][0]['description'].toString(), iconCode: data['weather'][0]['icon'].toString(), windSpeed: data['wind']['speed'].toString());
  }
  
}