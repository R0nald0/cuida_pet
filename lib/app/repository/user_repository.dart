
abstract class UserRepository {
   Future<void> register(String login,String password);
   Future<String> login(String email, String password);
      
}