import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. KAYIT OL (REGISTER)
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Kayıt olurken hata oluştu: $e");
      return null;
    }
  }

  // 2. GİRİŞ YAP (LOGIN)
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Giriş yaparken hata oluştu: $e");
      return null;
    }
  }

  // 3. ÇIKIŞ YAP (SIGN OUT)
  Future<void> signOut() async {
    await _auth.signOut();
  }
}