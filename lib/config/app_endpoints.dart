class AppEndpoints{

  static String address = 'https://integration.oquway.kz/api';

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
  static String getAllCurrencies = '$address/currencies/get-all';

  //file
  static String updateFiles = '$address/files/update/';
  static String createFiles = '$address/files/create';

  //metrics
  static String getMetrics = '$address/metrics/get-all';

  //documents
  static String getInvoices = '$address/invoices/get-all';
  static String getElectronicInvoices = '$address/electronic-invoices/get-all';
  static String getCompletionActs = '$address/completion-acts/get-all';

  //bank
  static String getBanks = '$address/banks/get-all';

  //position
  static String getAllPosition = '$address/positions/get-all';

  //transaction
  static String getAllTransactions = '$address/transactions/get-all';

  //service
  static String getAllService = '$address/services/get-all';
}