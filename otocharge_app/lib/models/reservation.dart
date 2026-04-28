class Reservation {
  int id;
  DateTime startTime;
  DateTime endTime;
  String verificationCode;

  Reservation({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.verificationCode,
  });

  bool createReservation() {
    print("Rezervasyon oluşturuldu: $startTime");
    return true;
  }

  bool verifyCode(String inputCode) {
    return inputCode == verificationCode;
  }

  void cancel() {
    print("Rezervasyon iptal edildi.");
  }
}