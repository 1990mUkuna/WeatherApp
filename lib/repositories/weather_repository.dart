/*
* This Weather Repository serves as an abstraction between the client code and the data provider
* This repo will have a dependency on our WeatherApiClient.abstract
* It will expose  a public method called, getWeather(String city)
* */

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta_meta.dart';
import '../models/models.dart';
import 'repositories.dart';



class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({
    @required this.weatherApiClient
}): assert(weatherApiClient != null);

  Future<Weather>getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return weatherApiClient.fetchWeather(locationId);
  }


}

