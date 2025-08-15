import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../core/constants/constants.dart';
import '../core/helpers/helpers.dart';
import '../entities/coordinate.dart';

part 'coordinate_state.dart';

class CoordinateCubit extends Cubit<CoordinateState> {
  CoordinateCubit() : super(CoordinateInitial());

  late Coordinate coordinate;

  Future<void> getPosition() async {
    emit(CoordinateLoading());

    try {
      final position = await determinePosition();

      coordinate = Coordinate(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      emit(CoordinateLoaded(coordinate));
    } catch (e) {
      switch ('$e') {
        case locationOff:
          emit(LocationServiceOff('Location services are turned off.'));
          break;
        case locationDenied:
          emit(LocationPermissionDenied('Location permissions are denied.'));
          break;
        case locationPermanentlyDenied:
          emit(LocationPermanentlyDenied(
              'Location permissions are permanently denied.'));
        default:
          emit(CoordinateError('$e'));
      }
    }
  }
}
