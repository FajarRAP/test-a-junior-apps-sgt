import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? Color(0x80FFFFFF) : Color(0x33FFFFFF),
          ),
          borderRadius: BorderRadius.circular(35),
          color: isActive ? Color(0xFF48319D) : Color(0x3348319D),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        width: 70,
        child: Column(
          children: <Widget>[
            Text(
              '12 AM',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Icon(
              Icons.cloud,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            Text(
              '19°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
