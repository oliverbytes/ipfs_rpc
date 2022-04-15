class FilesLsEntry {
  final String name;
  final FilesLsEntryType type;
  final int size;
  final String hash;

  FilesLsEntry({
    this.name = '',
    this.type = FilesLsEntryType.file,
    this.size = 0,
    this.hash = '',
  });

  factory FilesLsEntry.fromJson(Map<String, dynamic> json) => FilesLsEntry(
        name: json["Name"],
        type: typeToEnum(json["Type"]),
        size: json["Size"],
        hash: json["Hash"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Type": type.index,
        "Size": size,
        "Hash": hash,
      };

  static FilesLsEntryType typeToEnum(int _type) {
    return _type == FilesLsEntryType.file.index
        ? FilesLsEntryType.file
        : FilesLsEntryType.directory;
  }
}

enum FilesLsEntryType {
  file,
  directory,
}
