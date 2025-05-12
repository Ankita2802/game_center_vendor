import 'package:game_center_vendor/models/play_member.dart';
import 'package:game_center_vendor/models/team_member.dart';

class TournamentModel {
  final String? tournamentId;
  final String? title;
  final Map? prizePool;
  final double? registrationFee;
  final double? platfromFee;
  final int? maxPlayers;
  final int? playerLeft;
  final DateTime? registrationOpens;
  final DateTime? registrationClose;
  final DateTime? tournamentDate;
  final String? pointSystemFileLink;
  final String? gameRulesLink;
  final String? thumbnail;
  final String? gameId;
  final String? gameName;
  final String? logo;
  final String? invitationCode;
  final Map? extra;
  final String? status;
  final bool? isRegistrationOpen;
  final String? registrationId;
  bool? isFavourite;
  final String? description;
  final List<TeamMember> teamMembers;
  final List<PlayMember> playMembers;
  final GameExtra? gameExtra;

  TournamentModel({
    this.pointSystemFileLink,
    this.platfromFee,
    this.gameRulesLink,
    this.tournamentId,
    this.status,
    this.title,
    this.prizePool,
    this.registrationFee,
    this.maxPlayers,
    this.playerLeft,
    this.registrationOpens,
    this.registrationClose,
    this.extra,
    this.tournamentDate,
    this.thumbnail,
    this.gameName,
    this.gameId,
    this.description,
    this.logo,
    this.invitationCode,
    this.isRegistrationOpen,
    this.registrationId,
    this.isFavourite,
    this.teamMembers = const [],
    this.playMembers = const [],
    this.gameExtra,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      TournamentModel(
        tournamentId: json["tournament_id"],
        title: json["title"],
        status: json["status"],

        prizePool:
            json["prize_pool"] == null
                ? {'1st': "0"}
                : json["prize_pool"].isEmpty
                ? {'1st': "0"}
                : json["prize_pool"],

        registrationFee: (json["registration_fee"] ?? 0).toDouble(),
        platfromFee: (json["platform_charge"] ?? 0).toDouble(),
        maxPlayers: json["max_players"],
        playerLeft: json["player_left"] ?? json["team_left"],
        registrationOpens:
            json["registration_opens"] == null
                ? null
                : DateTime.parse(json["registration_opens"]).toLocal(),
        registrationClose:
            json["registration_close"] == null
                ? null
                : DateTime.parse(json["registration_close"]).toLocal(),
        tournamentDate:
            json["tournament_date"] == null
                ? null
                : DateTime.parse(json["tournament_date"]).toLocal(),
        thumbnail: json["thumbnail"],
        // registrationType: json["registration_type"],
        gameName: json["game_name"],
        gameId: json["game_id"] ?? json["game"],
        logo: json["logo"],
        invitationCode: json["invitation_code"],
        isRegistrationOpen: json["is_registration_open"] ?? false,
        registrationId: json["registration_id"],
        extra: json["extra"] ?? {},
        description: json["description"],
        pointSystemFileLink: json["point_system_file_link"],
        gameRulesLink: json["game_rules"],
        isFavourite: json["is_favourite"] ?? true,
        teamMembers:
            json["members"] == null
                ? []
                : json["members"].isEmpty
                ? []
                : List<TeamMember>.from(
                  json["members"].map((x) => TeamMember.fromJson(x)),
                ),
        playMembers:
            json["members"] == null
                ? []
                : json["members"].isEmpty
                ? []
                : List<PlayMember>.from(
                  json["members"].map((x) => PlayMember.fromJson(x)),
                ),
        gameExtra:
            json["game_extra"] == null
                ? null
                : GameExtra.fromJson(json["game_extra"]),
      );
}

class PrizePool {
  final String? the1St;
  final String? the2nd;
  final String? the3rd;

  PrizePool({this.the1St, this.the2nd, this.the3rd});

  factory PrizePool.fromJson(Map<String, dynamic> json) =>
      PrizePool(the1St: json["1st"], the2nd: json["2nd"], the3rd: json["3rd"]);
}

class GameExtra {
  final String? url;
  final String info;
  final String genre;
  final String theme;
  final String igdbid;
  final bool ladder;
  final String profile;
  final String gameMode;
  final String playerPrepective;

  GameExtra({
    required this.url,
    required this.info,
    required this.genre,
    required this.theme,
    required this.igdbid,
    required this.ladder,
    required this.profile,
    required this.gameMode,
    required this.playerPrepective,
  });

  factory GameExtra.fromJson(Map<String, dynamic> json) => GameExtra(
    url: json["url"],
    info: json["info"] ?? "",
    genre: json["Genre"] ?? "",
    theme: json["Theme"] ?? "",
    igdbid: json["IGDBID"] ?? "",
    ladder: json["ladder"] ?? false,
    profile: json["profile"] ?? "",
    gameMode: json["Game Mode"] ?? "",
    playerPrepective: json["Player Prepective"] ?? "",
  );
}

class LeaderboardModel {
  final String tournamentId;
  final String title;
  final String? thumbnail;
  final String? streamUrl;
  final String? gameRules;
  final String? pointSystemFileLink;
  final List<TournamentMember> tournamentMember;

  LeaderboardModel({
    required this.tournamentId,
    required this.title,
    required this.thumbnail,
    required this.tournamentMember,
    required this.streamUrl,
    required this.gameRules,
    required this.pointSystemFileLink,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardModel(
        tournamentId: json["tournament_id"],
        streamUrl: json["stream_url"],
        gameRules: json["game_rules"],
        pointSystemFileLink: json["point_system_file_link"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        tournamentMember: List<TournamentMember>.from(
          json["tournament_member"].map((x) => TournamentMember.fromJson(x)),
        ),
      );
}

class TournamentMember {
  final String userId;
  final String? profileImage;
  final String userName;
  final String? name;
  final int position;
  final dynamic pointSystemFileLink;
  final int totalScore;
  final dynamic timeline;
  final dynamic winningScreenshot;
  final Map<String, dynamic>? extra;

  TournamentMember({
    required this.userId,
    required this.profileImage,
    required this.userName,
    required this.name,
    required this.position,
    required this.pointSystemFileLink,
    required this.totalScore,
    required this.timeline,
    required this.winningScreenshot,
    required this.extra,
  });

  factory TournamentMember.fromJson(Map<String, dynamic> json) =>
      TournamentMember(
        userId: json["user_id"] ?? '',
        profileImage: json["profile_image"],
        userName: json["user_name"] ?? '',
        name: json["name"],
        position: json["position"] ?? '',
        pointSystemFileLink: json["point_system_file_link"] ?? '',
        totalScore: json["total_score"] ?? '',
        timeline: json["timeline"] ?? '',
        winningScreenshot: json["winning_screenshot"] ?? '',
        extra: json["extra"] ?? '',
      );
}
