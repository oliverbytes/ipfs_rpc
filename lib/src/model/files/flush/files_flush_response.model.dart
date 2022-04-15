class FilesFlushResponse {
  final String? cid;

  FilesFlushResponse({
    this.cid,
  });

  factory FilesFlushResponse.fromJson(Map<String, dynamic> json) =>
      FilesFlushResponse(
        cid: json["Cid"],
      );

  Map<String, dynamic> toJson() => {
        "Cid": cid,
      };
}
