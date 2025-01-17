

class Constants {
  Constants._();
  
   static String get logo => 'assets/images/logo.png';
   static String get tableName => 'address';

   static const ENVIREMONT_BASE_URL ='BASE_URL';
   static const REST_CLIENT_CONNECT_TIMEOUT ='rest_client_connect_timeout';
   static const REST_CLIENT_RECEIVE_TIMEOUT ='rest_cliet_receive_timeout';

   static const LOCAL_STORAGE_ACCESS_TOKEN_KEY = '/LOCAL_STORAGE_ACCESS_TOKE_KEY/';
   static const LOCAL_STORAGE_REFRESH_TOKEN_KEY = '/LOCAL_STORAGE_REFRESH_TOKE_KEY/';
   
   static const LOCAL_STORAGE_USER_DATA_LOGGED = '/LOCAL_STORAGE_USER_DATA_LOGGED/';
   static const LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY = '/LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY/';

   static const REST_CLINT_AUTH_REQUIRED_KEY ='auth_required';
}