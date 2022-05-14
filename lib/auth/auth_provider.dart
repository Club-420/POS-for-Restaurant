import 'auth_user.dart';

//create an abstract class to provide with method to acess auth user
abstract class AuthProvider {
  //initialize firebase app
  Future<void> initialize();
  AuthUser? get currentUser;

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
}
