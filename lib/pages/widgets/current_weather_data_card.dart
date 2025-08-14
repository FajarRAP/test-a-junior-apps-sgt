import 'package:flutter/material.dart';

class CurrentWeatherDataCard extends StatelessWidget {
  const CurrentWeatherDataCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0x80FFFFFF),
        ),
        borderRadius: BorderRadius.circular(24),
        color: Color(0xFF312B5B),
      ),
      padding: const EdgeInsets.all(16),
      height: 40,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF9593A9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
