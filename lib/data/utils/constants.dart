import './sensitive.dart';

class Constants {
  // APIs
  static const String baseUrl = 'https://$baseUrlNoPrefix/v1';
  static const String usersRoute = '$baseUrl/users';

  static const String loginRoute = '$baseUrl/login/';
  static const String forgotPasswordRoute = '$baseUrl/forgot-password';
  static const String registerRoute = '$baseUrl/register';
  static const String userRoute = '$baseUrl/user';

  // APIs no prefix
  static const String baseUrlNoPrefix = 'cart-upon-api.herokuapp.com';
  static const String forgotPasswordPath = '/forgot-password';
  // Local Storage
  static const String tokenKey = 'authentication_token';
  static const String userKey = 'user_key';
  static const String isAuthenticatedKey = 'isUserAuthenticated';

  static var sliders = '$baseUrl/sliderreadapi';

  // Google API
}

class Strings {
  static const String registrationFormIncomplete = 'Form must be filled out.';
  static const String tosNotAccepted =
      'Please accept the Terms of Service to register.';
  static const String registrationSuccessful = 'Registration Successful!';
  static const String forgotEmailSent =
      'Check your email for reset instructions.';
  static const String forgotPwInstructions =
      'Enter the email address associated with the forgotten account. Further instructions will be sent the account email.';

  static String loginFormIncomplete = "Form must be filled out";
}
