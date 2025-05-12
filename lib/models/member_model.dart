class MemberModel {
  final String memberId;
  final String userId;
  final String? profileImage;
  final String userName;
  final String teamId;
  final String? designation;
  final DateTime updatedAt;

  MemberModel({
    required this.memberId,
    required this.userId,
    required this.profileImage,
    required this.userName,
    required this.teamId,
    required this.designation,
    required this.updatedAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    memberId: json["member_id"],
    userId: json["user_id"],
    profileImage: json["profile_image"],
    userName: json["user_name"],
    teamId: json["team_id"],
    designation: json["designation"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
