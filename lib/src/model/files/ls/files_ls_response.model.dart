import 'files_ls_entry.model.dart';

class FilesLsResponse {
  final List<FilesLsEntry> entries;

  FilesLsResponse({
    this.entries = const [],
  });

  factory FilesLsResponse.fromJson(Map<String, dynamic> json) =>
      FilesLsResponse(
        entries: json["Entries"] == null
            ? []
            : List<FilesLsEntry>.from(
                json["Entries"].map((x) => FilesLsEntry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Entries": List<dynamic>.from(entries.map((x) => x.toJson())),
      };
}
