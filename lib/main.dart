import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'cubit/coordinate_cubit.dart';
import 'cubit/weather_cubit.dart';
import 'data/remote_data_sources.dart';
import 'data/remote_data_sources_impl.dart';
import 'pages/home_page.dart';
import 'repositories/repositories.dart';
import 'repositories/repositories_impl.dart';

late final RemoteDataSources<Response> remoteDataSources;
late final Repositories repositories;

void main() {
  remoteDataSources = RemoteDataSourcesImpl(httpClient: Client());
  repositories = RepositoriesImpl(remoteDataSources: remoteDataSources);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CoordinateCubit()),
        BlocProvider(
            create: (context) => WeatherCubit(repositories: repositories)),
      ],
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        title: 'Weather App',
      ),
    );
  }
}
