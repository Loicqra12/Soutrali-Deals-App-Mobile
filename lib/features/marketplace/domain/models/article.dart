import 'market_category.dart';

class Article {
  final String id;
  final String nomArticle;
  final String prixArticle;
  final int quantiteArticle;
  final String photoArticle;
  final MarketCategory categorie;

  Article({
    required this.id,
    required this.nomArticle,
    required this.prixArticle,
    required this.quantiteArticle,
    required this.photoArticle,
    required this.categorie,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['_id'],
      nomArticle: json['nomArticle'],
      prixArticle: json['prixArticle'],
      quantiteArticle: json['quantiteArticle'],
      photoArticle: json['photoArticle'],
      categorie: MarketCategory.fromJson(json['categorie']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nomArticle': nomArticle,
      'prixArticle': prixArticle,
      'quantiteArticle': quantiteArticle,
      'photoArticle': photoArticle,
      'categorie': categorie.toJson(),
    };
  }
}
