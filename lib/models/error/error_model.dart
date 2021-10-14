class ErrorModel {
  String code;
  String message;
  String errorType;

  // todo check code everywhere for int and string
  ErrorModel({this.code, this.message, this.errorType});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      code: json['code'],
      message: json['message'],
      errorType: json['errorType'] != null ? json['errorType'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code.toString();
    data['message'] = this.message;
    data['errorType'] = this.errorType != null ? this.errorType : null;
    return data;
  }
}

class NetworkError extends Error {
  String message;
  NetworkError(this.message);
}

