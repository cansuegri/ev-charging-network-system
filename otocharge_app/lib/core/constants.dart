enum SocketStatus { avaible, occupied, reserves, faulty }

abstract class IObserver {
  void update(String message);
}

abstract class IPaymentStrategy {
  bool processPayment(double amount);
}