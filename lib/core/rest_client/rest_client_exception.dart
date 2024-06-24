import 'package:cuidapet/core/rest_client/rest_client_response.dart';

class RestClientException implements Exception {
  
  String? message;
  int? statuCode;
  dynamic error;
  RestClientResponse response;

  
  RestClientException({
    this.message,
    this.statuCode,
    required this.error,
    required this.response,
  });


  @override
  String toString() {
    return 'RestClientException(message: $message, statuCode: $statuCode, error: $error, response: $response)';
  }
}
