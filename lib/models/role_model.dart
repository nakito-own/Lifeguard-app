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
}
