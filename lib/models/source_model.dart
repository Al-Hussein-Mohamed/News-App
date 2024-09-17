class SourceModel {
  final String status;
  final List<Source> sourcesList;

  SourceModel({
    required this.status,
    required this.sourcesList,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        status: json["status"],
        sourcesList: (json["sources"] as List)
            .map(
              (e) => Source.fromJson(e),
            )
            .toList(),
      );
}

class Source {
  final String id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );
}
