class CategorieModel {
  final String id;
  final String nomcategorie;
  final String imagecategorie;
  final String groupeId;

  CategorieModel({
    required this.id,
    required this.nomcategorie,
    required this.imagecategorie,
    required this.groupeId,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
      id: json['_id'],
      nomcategorie: json['nomcategorie'],
      imagecategorie: json['imagecategorie'],
      groupeId: json['groupe'],
    );
  }
}
