class AppEndpoints{

  static String address = 'http://185.102.74.90:8060/api';

  static String login = '$address/login';
  static String registrationClient = '$address/registration/client';
  static String recoverPassword = '$address/recover-password';
  static String resetPassword = '$address/reset-password';
  static String refreshToken = '$address/refresh-token';
  static String registrationVerify = '$address/registration/client/verify';
  static String getMe = '$address/me';
  static String updateUser = '$address/users/me/update';

  static String getAuthProvider = '$address/auth-provider';


  //client
  static String clientMe = '$address/clients/me';
  static String clientDraft = '$address/clients/draft';
  static String clientSaveChanges = '$address/clients/update';

  //contract
  static String getAllContracts = '$address/contracts/get-all';
  static String createContract = '$address/contracts/create';
  static String createGraftContract = '$address/contracts/draft';
  static String getContractService = '$address/contracts/services/get-all';

  //currencies
  static String getMostRecentCurrencies = '$address/currencies/rates/get-all/most-recent';

  //file
  static String updateFiles = '$address/files/update/';
  static String createFiles = '$address/files/create';

}