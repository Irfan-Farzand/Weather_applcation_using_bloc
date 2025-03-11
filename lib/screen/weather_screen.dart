import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_b/data/weather_repository.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset('lottie/w.json', height: 250),
                TextField(
                  controller: _cityController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter City Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.blue.shade700,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final city = _cityController.text;
                    if (city.isNotEmpty) {
                      weatherBloc.add(FetchWeather(city));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    "Get Weather",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 30),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return Center(child: CircularProgressIndicator(color: Colors.white));
                    } else if (state is WeatherLoaded) {
                      return Column(
                        children: [
                          Image.network(state.weather.iconUrl, height: 100),
                          Text(
                            state.weather.cityName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${state.weather.temperature}°C",
                            style: TextStyle(fontSize: 24, color: Colors.white70),
                          ),
                          Text(
                            state.weather.description,
                            style: TextStyle(fontSize: 20, color: Colors.white70),
                          ),
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Text(
                        "Error: ${state.message}",
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      );
                    }
                    return Text(
                      "Enter a City to get weather info",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}