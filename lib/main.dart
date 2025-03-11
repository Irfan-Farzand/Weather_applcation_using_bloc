import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_b/screen/weather_screen.dart';

import 'bloc/weather_bloc.dart';
import 'data/weather_repository.dart';

void main() {

  runApp(

    BlocProvider(
      create: (context) => WeatherBloc(WeatherRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherScreen(),
      ),
    ),
  );
}
