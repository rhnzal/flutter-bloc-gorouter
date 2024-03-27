enum HTTPResponseStatus { success, failed, timeout, error, noInternet }

class HTTPResponse<T> {
  HTTPResponse({
    required this.status,
    this.data,
    this.statusCode,
    this.additionalData,
    required this.userMessage,
    required this.errorCode
  });

  final HTTPResponseStatus status;
  final T? data;
  final int? statusCode;
  final dynamic additionalData;
  final String userMessage;
  final String errorCode;

  get isSuccess => status == HTTPResponseStatus.success;
}