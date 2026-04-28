enum SocketStatus { AVAILABLE, OCCUPIED, RESERVED, FAULTY }

abstract class IObserver {
  void update(String message);
}

abstract class IPaymentStrategy {
  bool processPayment(double amount);
}