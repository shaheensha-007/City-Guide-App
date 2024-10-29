import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_interview/Api/WeatherApi.dart';
import 'package:meta/meta.dart';

import '../Model/Model_weatherApi.dart';
import '../widgets/Tostmessage.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  late WeaterModel weaterModel;
  WeatherApi weatherApi=WeatherApi();
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async{
      emit(WeatherblocLoading());
      try{

        weaterModel=await weatherApi.getTrendingWeather();
        emit(WeatherblocLoaded());
      }catch(e){
        ToastMessage().toastmessage(message:e.toString());
        emit(WeatherblocError());
        print("*******$e");
      }
      // TODO: implement event handler
    });
  }
}
