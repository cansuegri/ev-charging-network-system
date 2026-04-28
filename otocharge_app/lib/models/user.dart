import '../core/constants.dart';
import 'vehicle.dart';

class User implements IObserver {
  int id;
  String name;
  String email;
  final double _balance; // Kapsülleme: Private değişken

  User(this.id, this.name, this.email, this._balance);

  // Bakiye kontrolü için bir getter
  double get balance => _balance;

  void register() => print("$name sisteme kaydedildi.");
  
  bool login() {
    print("$email ile giriş yapıldı.");
    return true;
  }

  void addVehicle(Vehicle vehicle) {
    print("${vehicle.plateNumber} plakalı araç kullanıcıya eklendi.");
  }

  @override
  void update(String message) {
    print("BİLDİRİM ($name): $message");
  }
}