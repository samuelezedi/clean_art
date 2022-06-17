import 'dart:io';

import 'package:clean_art/data/datasources/remote_data_sources.dart';
import 'package:clean_art/data/exception.dart';
import 'package:clean_art/data/failure.dart';
import 'package:clean_art/domain/entities/weather.dart';
import 'package:clean_art/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
