import '../core/constants.dart';

class Payment {
  int id;
  double amount;
  IPaymentStrategy strategy;

  Payment({required this.id, required this.amount, required this.strategy});

  void execute() {
    strategy.processPayment(amount);
  }
}