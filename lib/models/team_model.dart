class TeamModel {
  final String teamId;
  final String name;
  final String userId;
  final String? description;
  final String? location;
  final String? gameId;
  final String? gameName;
  final Extra? extra;
  final String? logo;
  final String? thumbnail;
  final int memberCount;
  final DateTime createdAt;

  TeamModel({
    required this.teamId,
    required this.memberCount,
    required this.name,
    required this.userId,
    required this.description,
    required this.location,
    required this.gameId,
    required this.gameName,
    required this.extra,
    required this.logo,
    required this.thumbnail,
    required this.createdAt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    teamId: json["team_id"],
    memberCount: json["member_count"] ?? 0,
    name: json["name"],
    userId: json["user_id"],
    description: json["description"],
    location: json["location"],
    gameId: json["game"],
    gameName: json["game_name"],
    extra:
        json["extra"] == null
            ? null
            : json["extra"].isEmpty
            ? null
            : Extra.fromJson(json["extra"]),
    logo: json["logo"],
    thumbnail: json["thumbnail"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Extra {
  final String? instaURL;
  final String? fbURL;
  final String? ytURL;
  final String? twURL;
  Extra({
    required this.instaURL,
    required this.fbURL,
    required this.ytURL,
    required this.twURL,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    fbURL: json['fb_link'],
    instaURL: json['insta_link'],
    twURL: json['twitch_link'],
    ytURL: json['yt_link'],
  );
}
