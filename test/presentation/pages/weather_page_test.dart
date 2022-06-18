import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_art/domain/entities/weather.dart';
import 'package:clean_art/presentation/bloc/weather_bloc.dart';
import 'package:clean_art/presentation/bloc/weather_event.dart';
import 'package:clean_art/presentation/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class FakeWeatherState extends Fake implements WeatherState {}

class FakeWeatherEvent extends Fake implements WeatherEvent {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeWeatherState());
    registerFallbackValue(FakeWeatherEvent());

    final di = GetIt.instance;
    di.registerFactory(() => mockWeatherBloc);
  });

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  const tWeather = Weather(
    cityName: 'Abuja',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>.value(
      value: mockWeatherBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('test field should trigger state change from empty to loading',
      (WidgetTester tester) async {
    //arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

    //act
    await tester.pumpWidget(_makeTestableWidget(WeatherPage()));
  });
}
