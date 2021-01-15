/*
* This class will be responsible for making the http requests to the
* This class weather api is the lowest layer in our application(The data provider)
* Responsible to only fetch datadirectly from the api
* */
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/models.dart';

class WeatherApiClient {

  //This is the constant for our base URL and instantiating our http client
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  // Here we telling the constructor that we will inject an instance of httpClient
  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);


  // This methods will get the locationId for a given city
  Future<int> getLocationId(String city) async {
  final locationUrl = '$baseUrl/api/location/search/?query=$city';
  final locationResponse = await this.httpClient.get(locationUrl);
  if (locationResponse.statusCode != 200) {
    throw Exception('error getting locationId for city');
  }

  //Decoding the response as a list
  final locationJson = jsonDecode(locationResponse.body) as List;
  return (locationJson.first)['woeid'];
}

//This method will get the weather for a city given it;ss locationId
Future<Weather> fetchWeather(int locationId) async {
  final weatherUrl = '$baseUrl/api/location/$locationId';
  final weatherResponse = await this.httpClient.get(weatherUrl);

  if (weatherResponse.statusCode != 200) {
    throw Exception('error getting weather for location');
  }

  final weatherJson = jsonDecode(weatherResponse.body);
  return Weather.fromJson(weatherJson);
}
}

