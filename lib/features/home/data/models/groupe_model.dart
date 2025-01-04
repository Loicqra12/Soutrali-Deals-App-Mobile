class GroupeModel {
  final String id;
  final String nomgroupe;

  GroupeModel({
    required this.id,
    required this.nomgroupe,
  });

  factory GroupeModel.fromJson(Map<String, dynamic> json) {
    return GroupeModel(
      id: json['_id'],
      nomgroupe: json['nomgroupe'],
    );
  }
}
