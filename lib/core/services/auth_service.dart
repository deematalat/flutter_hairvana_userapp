class AuthService {
  // Simulated in-memory users store (replace with real backend in production)
  final Map<String, String> _users = {};

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate latency

    if (_users.containsKey(email) && _users[email] == password) {
      return true;
    }

    return false;
  }

  Future<bool> signUp(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate latency

    if (_users.containsKey(email)) {
      return false; // User already exists
    }

    _users[email] = password;
    return true;
  }
}
