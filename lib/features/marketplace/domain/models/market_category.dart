class MarketCategory {
  final String id;
  final String nomcategorie;
  final String imagecategorie;
  final GroupeInfo groupe;

  MarketCategory({
    required this.id,
    required this.nomcategorie,
    required this.imagecategorie,
    required this.groupe,
  });

  factory MarketCategory.fromJson(Map<String, dynamic> json) {
    final groupeData = json['groupe'];
    GroupeInfo groupe;
    
    if (groupeData is String) {
      // Handle case where groupe is just an ID string
      groupe = GroupeInfo(id: groupeData, nomgroupe: '');
    } else if (groupeData is Map<String, dynamic>) {
      // Handle case where groupe is a full object
      groupe = GroupeInfo.fromJson(groupeData);
    } else {
      throw FormatException('Invalid groupe format in MarketCategory');
    }

    return MarketCategory(
      id: json['_id'],
      nomcategorie: json['nomcategorie'],
      imagecategorie: json['imagecategorie'],
      groupe: groupe,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nomcategorie': nomcategorie,
      'imagecategorie': imagecategorie,
      'groupe': groupe.toJson(),
    };
  }
}

class GroupeInfo {
  final String id;
  final String nomgroupe;

  GroupeInfo({
    required this.id,
    required this.nomgroupe,
  });

  factory GroupeInfo.fromJson(Map<String, dynamic> json) {
    return GroupeInfo(
      id: json['_id'],
      nomgroupe: json['nomgroupe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nomgroupe': nomgroupe,
    };
  }
}

class MarketSubcategory {
  final String id;
  final String name;

  const MarketSubcategory({
    required this.id,
    required this.name,
  });
}
