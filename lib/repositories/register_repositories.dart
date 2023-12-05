
import 'package:connection/services/api_services.dart';

class RegisterRepository {
  final ApiService api = ApiService();
  Future<int> register(String email, String username, String password) async {
    int result = 2;
    final response = await api.registerUser(email, username, password);
    if (response != null && response.statusCode == 201) {
      if (response.data['reqires_email_confirmation'] == true) {
        result = 3;
      } else {
        result = 4;
      }
    }
    return result;
  }
}
