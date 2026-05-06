import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  // Key yang dipakai untuk menyimpan data di SharedPreferences
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyLoggedInUser = 'logged_in_user';

  // ── REGISTER ────────────────────────────────────────────────────
  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Cek apakah username sudah ada
    final savedUsername = prefs.getString(_keyUsername);
    if (savedUsername == username) return false;

    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyPassword, password);
    return true;
  }

  // ── LOGIN ────────────────────────────────────────────────────────
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final savedUsername = prefs.getString(_keyUsername);
    final savedPassword = prefs.getString(_keyPassword);

    if (savedUsername == username && savedPassword == password) {
      // Simpan sesi aktif
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyLoggedInUser, username);
      return true;
    }
    return false;
  }

  // ── LOGOUT ───────────────────────────────────────────────────────
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyLoggedInUser);
  }

  // ── CEK STATUS SESI ──────────────────────────────────────────────
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<String?> getLoggedInUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLoggedInUser);
  }
}