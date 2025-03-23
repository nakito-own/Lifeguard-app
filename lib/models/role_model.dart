class RoleModel {
  final int ownersCount;
  final int rankId;
  final String rankName;

  RoleModel({required this.ownersCount, required this.rankId, required this.rankName});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      ownersCount: json['owners_count'],
      rankId: json['rank_id'],
      rankName: json['rank_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owners_count': ownersCount,
      'rank_id': rankId,
      'rank_name': rankName,
    };
  }

  RoleModel copyWith({
    int? ownersCount,
    int? rankId,
    String? rankName,
  }) {
    return RoleModel(
      ownersCount: ownersCount ?? this.ownersCount,
      rankId: rankId ?? this.rankId,
      rankName: rankName ?? this.rankName,
    );
  }
}
