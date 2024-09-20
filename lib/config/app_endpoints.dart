class AppEndpoints{

  static String address = 'http://185.102.74.90:8060';

  static String login = '/api/login';
  static String registrationClient = '/api/registration/client';
  static String recoverPassword = '/api/recover-password';
  static String resetPassword = '/api/reset-password';
  static String refreshToken = '/api/refresh-token';
  static String registrationVerify = '/api/registration/client/verify';
  static String getMe = '/api/me';
  static String updateUser = '/api/users/me/update';

  static String getAuthProvider = '/api/auth-provider';


  //client
  static String clientMe = '/api/clients/me';
  static String clientDraft = '/api/clients/draft';
  static String clientSaveChanges = '/api/clients/update';

  //contract
  static String getAllContracts = '/api/contracts/get-all';
  static String createContract = '/api/contracts/create';

  //currencies
  static String getMostRecentCurrencies = '/api/currencies/rates/get-all/most-recent';

  //file
  static String updateFiles = '/api/files/update/';
  static String createFiles = '/api/files/create';

}