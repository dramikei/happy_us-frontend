class BaseResponse {
  late final dynamic data;
  late final Map<String, dynamic> tokens;
  late final String message;
  late final String path;
  late final String status;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    tokens = json['tokens'] ?? {};
    message = json['message'];
    path = json['path'];
    status = json['status'];
  }
}
