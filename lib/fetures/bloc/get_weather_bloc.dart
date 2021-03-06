import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_simple_weather_app/core/geolocator.dart';

import 'package:test_simple_weather_app/fetures/data/datasource/remote_datasource.dart';
import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/data/models/weather.dart';

part 'get_weather_event.dart';
part 'get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherDataSourceImpl dataSourceImpl;

  GetWeatherBloc(
    this.dataSourceImpl,
  ) : super(GetWeatherLoading()) {
    on<GetApiWeather>((event, emit) async {
      emit(GetWeatherLoading());

      final getforcast = await dataSourceImpl.getForecast();

      final getcurrent = await dataSourceImpl.getCurrentWeather();

      emit(GetWeatherLoaded(current: getcurrent, forecast: getforcast));
    });
  }
}
