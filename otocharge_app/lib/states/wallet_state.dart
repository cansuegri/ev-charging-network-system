import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

enum PaymentMethod {
  wallet,
  visa,
}

class WalletState extends ChangeNotifier {
  double balance = 0.0;
  PaymentMethod selectedMethod = PaymentMethod.wallet;
  
  StreamSubscription<DocumentSnapshot>? _balanceSubscription;

  WalletState() {
    print("🛠️ LOG: WalletState Başlatıldı!");
    
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        print("👤 LOG: Kullanıcı Giriş Yaptı! UID: ${user.uid}");
        _listenToFirebaseBalance(user.uid);
      } else {
        print("🚪 LOG: Kullanıcı Çıkış Yaptı.");
        _balanceSubscription?.cancel();
        balance = 0.0;
        notifyListeners();
      }
    });
  }

  void _listenToFirebaseBalance(String uid) {
    print("📡 LOG: Firestore dinleyicisi başlatılıyor... Hedef UID: $uid");
    _balanceSubscription?.cancel();

    _balanceSubscription = FirebaseFirestore.instance
        .collection('Users') 
        .doc(uid)
        .snapshots()
        .listen((snapshot) {
      print("📥 LOG: Firestore'dan cevap geldi! Belge var mı?: ${snapshot.exists}");
      
      if (snapshot.exists) {
        print("📄 LOG: Belgenin İçeriği: ${snapshot.data()}");
        
        if (snapshot.data()!.containsKey('balance')) {
          final rawBalance = snapshot.data()!['balance'];
          balance = double.tryParse(rawBalance.toString()) ?? 0.0;
          print("💰 LOG: Yeni Bakiye Ekrana Gönderiliyor: $balance");
          notifyListeners(); 
        } else {
          print("❌ LOG HATA: Belge bulundu ama içinde 'balance' alanı YOK!");
        }
      } else {
        print("❌ LOG HATA: Firestore'da 'Users' koleksiyonunda '$uid' adında bir belge BULUNAMADI!");
      }
    }, onError: (error) {
      print("💥 LOG HATA: Firestore dinleme izni verilmedi veya bağlantı koptu: $error");
    });
  }

  void selectPaymentMethod(PaymentMethod method) {
    selectedMethod = method;
    notifyListeners();
  }

  Future<bool> pay(double amount) async {
    if (selectedMethod == PaymentMethod.wallet && balance < amount) {
      return false; // Bakiye yetersizse işlemi durdur
    }

    if (selectedMethod == PaymentMethod.wallet) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // 1. Bakiyeyi düşür
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .update({
            'balance': FieldValue.increment(-amount),
          });

          // 2. SİHİRLİ DOKUNUŞ: Firebase'e işlemi (fişi) kaydet!
          await FirebaseFirestore.instance.collection('Sessions').add({
            'userId': user.uid, // Bu işlem kime ait? (Yabancı Anahtar)
            'stationName': 'North Star Hub', // Şarj istasyonu adı
            'amount': amount,
            'date': FieldValue.serverTimestamp(), // Firebase sunucusunun anlık saati
            'status': 'PAID', // İşlem durumu
            'isIncome': false, // Gider olduğu için false
          });

          return true; 
        }
      } catch (e) {
        print("Ödeme sırasında Firebase Hatası: $e");
        return false;
      }
    }
    return true; 
  }
  
  @override
  void dispose() {
    _balanceSubscription?.cancel();
    super.dispose();
  }
}

final walletState = WalletState();