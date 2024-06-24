class RestClientResponse<T> {
  RestClientResponse({
    this.data,
    this.statuCode,
    this.statuMessage
  });
 T? data;
 int? statuCode;
 String? statuMessage;
}