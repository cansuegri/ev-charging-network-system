import '../models/station.dart';

abstract class IStationState {
  void handleStatus(Station station);
}