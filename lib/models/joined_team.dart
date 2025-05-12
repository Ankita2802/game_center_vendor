import 'package:game_center_vendor/models/team_member.dart';

class JoinedTeam {
  final String teamId;
  final String teamName;
  final String name;
  final String userName;
  final String? profileImage;
  final String? location;
  final String? game;
  final String? logo;
  final String? thumbnail;
  final int? totalScore;
  final String tournamentId;
  final List<TeamMember> members;

  JoinedTeam({
    required this.teamId,
    required this.teamName,
    required this.name,
    required this.userName,
    required this.profileImage,
    required this.location,
    required this.game,
    required this.logo,
    required this.thumbnail,
    required this.tournamentId,
    required this.members,
    required this.totalScore,
  });

  factory JoinedTeam.fromJson(Map<String, dynamic> json) => JoinedTeam(
    teamId: json["team_id"],
    teamName: json["team_name"],
    location: json["location"],
    game: json["game"],
    logo: json["logo"],
    thumbnail: json["thumbnail"],
    tournamentId: json["tournament_id"],
    name: json["name"],
    userName: json["user_name"],
    profileImage: json["profile_image"],
    totalScore: json["total_score"],
    members:
        json["members"].isEmpty
            ? []
            : List<TeamMember>.from(
              json["members"].map((x) => TeamMember.fromJson(x)),
            ),
  );
}
