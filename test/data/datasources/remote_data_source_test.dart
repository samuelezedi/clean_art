import 'dart:convert';

import 'package:clean_art/data/constants.dart';
import 'package:clean_art/data/datasources/remote_data_sources.dart';
import 'package:clean_art/data/exception.dart';
import 'package:clean_art/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';

void main() {
  const String js = """
    {
    "coord": {
        "lon": 106.8451,
        "lat": -6.2146
    },
    "weather": [
        {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 302.28,
        "feels_like": 306.16,
        "temp_min": 301.98,
        "temp_max": 304.51,
        "pressure": 1009,
        "humidity": 70
    },
    "visibility": 6000,
    "wind": {
        "speed": 2.06,
        "deg": 240
    },
    "clouds": {
        "all": 20
    },
    "dt": 1642988670,
    "sys": {
        "type": 1,
        "id": 9383,
        "country": "ID",
        "sunrise": 1642978330,
        "sunset": 1643023003
    },
    "timezone": 25200,
    "id": 1642911,
    "name": "Abuja",
    "cod": 200
}
""";

  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get current weather', () {
    const tCityName = 'Abuja';
    final tWeatherModel = WeatherModel.fromJson(json.decode(js));

    test('should return weather model when the response code is 200', () async {
      //arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
      ).thenAnswer((_) async => http.Response(js, 200));

      //act
      final result = await dataSource.getCurrentWeather(tCityName);

      //assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () {
      //arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
      ).thenAnswer((realInvocation) async => http.Response('Not found', 404));

      //act
      final call = dataSource.getCurrentWeather(tCityName);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
