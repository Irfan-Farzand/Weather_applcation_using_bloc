


import 'dart:convert';

import '../models/weather_model.dart';
import 'package:http/http.dart'as http;
class WeatherRepository{

  Future<Weather> fetchWeather(String city) async{
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=fff10b4bd6c28f355fbccc5f90e8ff85&units=metric'));

    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      return Weather.fromJson(jsonData);
    }else{
      throw Exception("failed to load weather data");
    }
  }
}