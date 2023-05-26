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

  Future<void> sendMessage(String message) async {
    // Here, you need to implement the logic to send the message to the server.
    // This usually involves making a HTTP request to your server's API.
    // Since I don't know the details of your server's API, I can't provide a detailed implementation here.
  }

  void subscribeToMessages(Function callback) {
    final Realtime _realtime = Realtime(_client);
    _realtime.subscribe(['messages']).stream.listen((response) {
          callback(response);
        });
  }

  Future<void> registerUser(
      String userId, String email, String password, String name) async {
    final account = Account(_client);
    final response = await account.create(
        userId: userId, email: email, password: password, name: name);
    if (response.$id == false) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> loginUser(String email, String password) async {
    final account = Account(_client);
    final response =
        await account.createEmailSession(email: email, password: password);
    if (response.current != true) {
      throw Exception('Failed to login user');
    }
  }
}
