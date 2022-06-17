import 'package:clean_art/data/failure.dart';
import 'package:clean_art/domain/entities/weather.dart';
import 'package:clean_art/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
