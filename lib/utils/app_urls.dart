class ApiUrls {
  // TODO: PRODUCTION
  // static String userUrl = "http://user-prod.playverse.live/";
  // static String tournamentUrl = "http://tournament-prod.playverse.live/";

  // TODO: STAGING
  static String userUrl = "https://api-stage.playverse.live/";
  static String tournamentUrl = "https://api-stage.playverse.live/tournament/";
}

class UserUrls {
  static String refreshToken = 'v1/refresh_token';
}

class TeamUrl {
  static String teams = "v1/teams";
  static String inviteUser = "v1/teams/invite";
  static String acceptUser = "v1/teams/accept";
  static String getTeamInvitaions = "v1/teams/list_user_teams";
  static String sendJoinRequest = "v1/teams/send_request";
  static String getUserRequests = "v1/teams/get_team_join_requests";
  static String getInvitedUsers = "v1/teams/list_invited_people";
  static String getMembers = "v1/teams/members_list";
  static String invitationAction = "v1/teams/team_action";
  static String requestAction = "v1/teams/accept";
  static String removeMember = "v1/teams/remove_member";
  static String leaveTeam = "v1/teams/leave_team";

  // Team Tournaments
  // static String getTournaments = "v1/teams/get_tournaments";
  static String getTournaments = "v1/teams";
  static String joinTournament = "v1/teams/join";
  // static String getJoinedTeams = "v1/teams/get_tournaments_team_join";
  static String getJoinedTeams = "v1/teams/participants";
  static String getFavTournaments = "v1/teams/get_tournament_favorite";
  // static String likeTournament = "v1/teams/add_tournament_favorite";
  static String likeTournament = "v1/teams/favourite";

  // Payment to join tournament
  static String sendPaymentSS = "v1/upload-payment";
}

class GamesUrls {
  static String gamesList = 'v1/games';
  static String deleteGames = 'v1/games/';
  static String addGames = 'v1/games/add_to_favorite';
  static String userGames = "v1/games";
}
