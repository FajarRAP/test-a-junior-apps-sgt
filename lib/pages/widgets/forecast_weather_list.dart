import 'package:flutter/material.dart';

class ForecastWeatherList extends StatelessWidget {
  const ForecastWeatherList({
    super.key,
    required this.future,
    required this.child,
  });

  final Future future;
  final Widget Function(AsyncSnapshot<dynamic> snapshot) child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error : ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('No data available'),
          );
        }

        return child(snapshot);
      },
    );
  }
}
