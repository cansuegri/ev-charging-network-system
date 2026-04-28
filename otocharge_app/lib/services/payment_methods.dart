import '../core/constants.dart';

class WalletPayment implements IPaymentStrategy {
  @override
  bool processPayment(double amount) {
    print("$amount TL cüzdandan çekildi.");
    return true;
  }
}

class CreditCardPayment implements IPaymentStrategy {
  @override
  bool processPayment(double amount) {
    print("$amount TL kredi kartından çekildi.");
    return true;
  }
}