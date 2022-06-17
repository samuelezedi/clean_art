import 'package:clean_art/data/failure.dart';
import 'package:clean_art/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
