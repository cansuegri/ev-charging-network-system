class ChargingSession {
  int id;
  DateTime? startTime;
  DateTime? endTime;
  double energyConsumed = 0.0;
  double currentVolts = 220.0;
  double currentAmps = 0.0;
  double totalCost = 0.0;

  ChargingSession({required this.id});

  void startCharge() {
    startTime = DateTime.now();
    print("Şarj işlemi saat $startTime itibariyle başladı.");
  }

  void stopCharge() {
    endTime = DateTime.now();
    print("Şarj işlemi durduruldu.");
  }

  double calculateProgress() {
    // Şarj yüzdesi hesaplama simülasyonu
    return (energyConsumed / 100) * 100; 
  }

  double calculateCost(double unitPrice) {
    totalCost = energyConsumed * unitPrice;
    return totalCost;
  }
}