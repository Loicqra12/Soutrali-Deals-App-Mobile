class ServiceModel {
  final String id;
  final String nomservice;
  final String imageservice;
  final String categorieId;
  final String groupeId;

  ServiceModel({
    required this.id,
    required this.nomservice,
    required this.imageservice,
    required this.categorieId,
    required this.groupeId,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'],
      nomservice: json['nomservice'],
      imageservice: json['imageservice'],
      categorieId: json['categorie'],
      groupeId: json['nomgroupe'],
    );
  }
}
