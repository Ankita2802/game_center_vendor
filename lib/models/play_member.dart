class PlayMember {
  final String? userId;
  final String? profileImage;
  final String? userName;
  final String? name;

  PlayMember({
    required this.userId,
    required this.profileImage,
    required this.userName,
    required this.name,
  });

  factory PlayMember.fromJson(Map<String, dynamic> json) => PlayMember(
    name: json["name"],
    userId: json["user_id"],
    profileImage: json["profile_image"],
    userName: json["user_name"],
  );
}
