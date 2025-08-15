import 'package:geolocator/geolocator.dart';

import '../constants/constants.dart';

Future<Position> determinePosition() async {
  LocationPermission permission;

  final serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error(locationOff);
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(locationDenied);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(locationPermanentlyDenied);
  }

  return await Geolocator.getCurrentPosition();
}
