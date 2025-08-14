import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'data/remote_data_sources.dart';
import 'data/remote_data_sources_impl.dart';
import 'pages/home_page.dart';
import 'repositories/repositories.dart';
import 'repositories/repositories_impl.dart';

late final RemoteDataSources<Response> remoteDataSources;
late final Repositories repositories;

void main() {
  // remoteDataSources = RemoteDataSourcesMock();
  remoteDataSources = RemoteDataSourcesImpl(httpClient: Client());
  repositories = RepositoriesImpl(remoteDataSources: remoteDataSources);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      title: 'Weather App',
    );
  }
}
