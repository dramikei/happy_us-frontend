class BaseResponse<T> {
  late final T? data;
  late final Map<String, dynamic> tokens;
  late final String message;
  late final String path;
  late final bool success;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] is List ? <T>[] : json['data'];
    tokens = json['tokens'] ?? {};
    message = json['message'];
    path = json['path'];
    success = json['status'];
  }
}
