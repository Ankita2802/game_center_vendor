class TeamMember {
  final String? logo;
  final String? thumbnail;
  final String? userName;
  final String? name;
  final String? designation;

  TeamMember({
    required this.logo,
    required this.thumbnail,
    required this.userName,
    required this.name,
    required this.designation,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    name: json["name"],
    logo: json["logo"],
    thumbnail: json["thumbnail"],
    userName: json["user_name"],
    designation: json["designation"],
  );
}
