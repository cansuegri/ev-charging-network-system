import 'station_state.dart';
import '../models/station.dart';

class AvailableState implements IStationState {
  @override
  void handleStatus(Station station) {
    print("DURUM: ${station.name} şu an MÜSAİT.");
  }
}