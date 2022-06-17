import 'package:clean_art/domain/entities/weather.dart';
import 'package:clean_art/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'Abuja',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tCityName = 'Abuja';

  test('should get current weather detail from the repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(tCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    //act
    final result = await usecase.execute(tCityName);

    //assert
    expect(result, equals(const Right(testWeatherDetail)));
  });
}
