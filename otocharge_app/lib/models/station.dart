import '../core/constants.dart';
import '../states/station_state.dart';
import '../states/available_state.dart';

class Station {
  int id;
  String name;
  double latitude;
  double longitude;
  IStationState state;
  List<IObserver> observers = [];

  Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    IStationState? initialState,
  }) : state = initialState ?? AvailableState();

  void addObserver(IObserver observer) {
    observers.add(observer);
  }

  void changeState(IStationState newState) {
    state = newState;
    state.handleStatus(this);
    notifyObservers("İstasyon durumu güncellendi: ${newState.runtimeType}");
  }

  void notifyObservers(String msg) {
    for (var observer in observers) {
      observer.update(msg);
    }
  }
}