


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_b/bloc/weather_event.dart';
import 'package:weather_b/bloc/weather_state.dart';
import 'package:weather_b/data/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent , WeatherState>{
  final WeatherRepository repository;
  WeatherBloc(this.repository): super(WeatherInitial()){
    on<FetchWeather>((event ,emit) async{

      emit(WeatherLoading());

      try{
        final weather = await repository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));

      }catch(e){
        emit(WeatherError(e.toString()));
      }
    });
  }
}