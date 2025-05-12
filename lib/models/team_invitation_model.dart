class TeamInvitationModel {
  final String teamId;
  final String teamName;
  final String? description;
  final String? location;
  final String? gameId;
  final String? logo;
  final String invitedBy;
  final bool isAccepted;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamInvitationModel({
    required this.teamId,
    required this.teamName,
    required this.description,
    required this.location,
    required this.gameId,
    required this.logo,
    required this.invitedBy,
    required this.isAccepted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeamInvitationModel.fromJson(Map<String, dynamic> json) =>
      TeamInvitationModel(
        teamId: json["team_id"],
        teamName: json["team_name"],
        description: json["description"],
        location: json["location"],
        gameId: json["game_id"],
        logo: json["logo"],
        invitedBy: json["invited_by"],
        isAccepted: json["is_accepted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
