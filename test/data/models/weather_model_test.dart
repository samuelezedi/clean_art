import 'dart:convert';

import 'package:clean_art/data/models/weather_model.dart';
import 'package:clean_art/domain/entities/weather.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

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

  const tWeatherModel = WeatherModel(
    cityName: 'Abuja',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeather = Weather(
    cityName: 'Abuja',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('to entity', () {
    test('shuold be a subclass of weather entity', () async {
      //assert
      final result = tWeatherModel.toEntity();
      expect(result, equals(tWeather));
    });
  });

  group('from json', () {
    test('should return valid model from json', () async {
      // final String file = await rootBundle
      // .loadString('test/helpers/dummy_data/dummy_weather_response.json');
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(js);

      //act
      final result = WeatherModel.fromJson(jsonMap);

      //assert
      expect(result, equals(tWeatherModel));
    });

    group('to json', () {
      test('should return a json map containing proper data', () async {
        //act
        final result = tWeatherModel.toJson();

        //assert
        final expectedJsonMap = {
          'weather': [
            {
              'main': 'Clouds',
              'description': 'few clouds',
              'icon': '02d',
            }
          ],
          'main': {
            'temp': 302.28,
            'pressure': 1009,
            'humidity': 70,
          },
          'name': 'Abuja',
        };
        expect(result, equals(expectedJsonMap));
      });
    });
  });
}
