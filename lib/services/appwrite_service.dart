import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();

  static AppwriteService get instance => _instance;

  late Client _client;

  AppwriteService._internal() {
    _client = Client();
    _client
        .setEndpoint('https://test.pingping.host/v1') // Your API Endpoint
        .setProject('646de30fc78fac0c6388'); // Your project ID
  }

  Future<void> createSession(String email, String password) async {
    final account = Account(_client);
    final response = await account.createEmailSession(
      email: email,
      password: password,
    );
    if (response.current != true) {
      throw Exception('Failed to create session');
    }
  }
}
