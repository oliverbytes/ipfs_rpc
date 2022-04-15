class IpfsErrorResponse {
  final String message;
  final int code;
  final String type;

  IpfsErrorResponse({
    this.message = '',
    this.code = 0,
    this.type = '',
  });

  factory IpfsErrorResponse.fromJson(Map<String, dynamic> json) =>
      IpfsErrorResponse(
        message: json["Message"],
        code: json["Code"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Code": code,
        "Type": type,
      };
}
