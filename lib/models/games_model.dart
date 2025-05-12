class Games {
  final String? gameId;
  final String? name;
  final String? logo;
  final String? genre;
  final String? gameType;
  final String? thumbnail;
  String? inGameName;
  final String? info;
  final String? profile;
  final String? charImage;
  // final bool? added;
  // final bool? isActive;

  Games({
    this.gameId,
    this.info,
    this.name,
    this.logo,
    this.genre,
    this.gameType,
    this.thumbnail,
    this.inGameName,
    this.profile,
    this.charImage,
    // this.added,
    // this.isActive,
  });

  factory Games.fromJson(Map<String, dynamic> json) => Games(
    gameId: json["game_id"],
    name: json["name"],
    logo: json["logo"],
    genre: json["genre"],
    gameType: json["game_type"],
    thumbnail: json["thumbnail"],
    inGameName: json["in_game_name"],
    info: json["extra"] == null ? null : json["extra"]["info"],
    profile: json["extra"] == null ? null : json["extra"]["profile"],
    charImage: json["extra"] == null ? null : json["extra"]["char_image"],
    // added: json['added'],
    // isActive: json['is_active'],
  );
}
