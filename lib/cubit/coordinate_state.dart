part of 'coordinate_cubit.dart';

@immutable
sealed class CoordinateState {}

final class CoordinateInitial extends CoordinateState {}

class CoordinateLoading extends CoordinateState {}

class CoordinateLoaded extends CoordinateState {
  final Coordinate coordinate;

  CoordinateLoaded(this.coordinate);
}

class CoordinateError extends CoordinateState {
  final String message;

  CoordinateError(this.message);
}

class LocationServiceOff extends CoordinateError {
  LocationServiceOff(super.message);
}

class LocationPermissionDenied extends CoordinateError {
  LocationPermissionDenied(super.message);
}

class LocationPermanentlyDenied extends CoordinateError {
  LocationPermanentlyDenied(super.message);
}