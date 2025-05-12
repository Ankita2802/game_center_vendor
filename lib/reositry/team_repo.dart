//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:game_center_vendor/reositry/base_repo.dart';
import 'package:game_center_vendor/utils/app_urls.dart';
import 'package:game_center_vendor/utils/enum.dart';
import 'package:game_center_vendor/utils/my_sharepreference.dart';

class TeamRepo extends BaseRepository {
  Future createTeamApi(String name, String gameId) async {
    final userId = await MySharedPreferences.instance.getStringValue("user_id");
    Map<String, dynamic> data = {"name": name, "game": gameId};
    if (userId != null) data["user_id"] = userId;

    final response = await postHttp(
      data: data,
      api: ApiUrls.userUrl + TeamUrl.teams,
      token: true,
    );
    log(response.body, name: "response createTeamApi");
    return json.decode(response.body);
  }

  Future updateTeamApi(Map<String, dynamic> data, String teamId) async {
    final userId = await MySharedPreferences.instance.getStringValue("user_id");
    if (userId != null) data["user_id"] = userId;
    final param = "?team_id=$teamId";
    final response = await putHttp(
      data: data,
      api: ApiUrls.userUrl + TeamUrl.teams + param,
      token: true,
    );
    log(response.body, name: "response updateTeamApi");
    return json.decode(response.body);
  }

  Future getTeamApi(
    bool myTeam,
    int offset,
    String? searchText,
    String? gameId,
    String? teamId,
  ) async {
    final userId = await MySharedPreferences.instance.getStringValue("user_id");
    final param =
        teamId != null
            ? "?team_id=$teamId"
            : gameId != null
            ? "?game_id=$gameId&user_id=$userId"
            : myTeam
            ? "?user_id=$userId"
            : "?limit=15&offset=$offset${searchText == null || searchText.isEmpty ? '' : "&search_text=$searchText"}";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.teams + param,
      token: true,
    );
    log(response.body, name: 'response getTeamApi');
    return json.decode(response.body);
  }

  Future deleteTeamApi(String teamId) async {
    final param = "?team_id=$teamId";
    final response = await deleteHttp(
      api: ApiUrls.userUrl + TeamUrl.teams + param,
      token: true,
    );
    log(response.body, name: 'response deleteTeamApi');
    return json.decode(response.body);
  }

  Future sendJoinRequestApi(String teamId, String? role) async {
    final param = "?team_id=$teamId${role == null ? '' : '&designation=$role'}";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.sendJoinRequest + param,
      token: true,
    );
    log(response.body, name: 'response sendJoinRequestApi');
    return json.decode(response.body);
  }

  Future invitePlayerApi(String userId, String teamId, String? role) async {
    final param =
        "?user_id=$userId&team_id=$teamId${role == null ? '' : '&designation=$role'}";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.inviteUser + param,
      token: true,
    );
    log(response.body, name: 'response invitePlayerApi');
    return json.decode(response.body);
  }

  Future getUserRequestsApi(int offset, String teamId) async {
    final param = "?limit=15&offset=$offset&team_id=$teamId";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.getUserRequests + param,
      token: true,
    );
    log(response.body, name: 'response getUserRequestsApi');
    return json.decode(response.body);
  }

  Future getInvitedUsersApi(int offset, String teamId) async {
    final param = "?limit=15&offset=$offset&team_id=$teamId";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.getInvitedUsers + param,
      token: true,
    );
    log(response.body, name: 'response getUserRequestsApi');
    return json.decode(response.body);
  }

  Future getMembersApi(int offset, String teamId) async {
    final param = "?limit=15&offset=$offset&team_id=$teamId";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.getMembers + param,
      token: true,
    );
    log(response.body, name: 'response getMembersApi');
    return json.decode(response.body);
  }

  Future getTeamInvitationsApi(int offset) async {
    final param = "?limit=15&offset=$offset";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.getTeamInvitaions + param,
      token: true,
    );
    log(response.body, name: 'response getTeamInvitationsApi');
    return json.decode(response.body);
  }

  Future invitaionActionApi(String teamId, bool accept) async {
    final param = "?team_id=$teamId&is_accepted=$accept";
    final response = await postHttp(
      api: ApiUrls.userUrl + TeamUrl.invitationAction + param,
      data: {},
      token: true,
    );
    log(response.body, name: 'response invitaionActionApi');
    return json.decode(response.body);
  }

  Future requestActionApi(String userId, String teamId, bool accept) async {
    final param = "?user_id=$userId&team_id=$teamId&is_accepted=$accept";
    final response = await getHttp(
      api: ApiUrls.userUrl + TeamUrl.requestAction + param,
      token: true,
    );
    log(response.body, name: 'response requestActionApi');
    return json.decode(response.body);
  }

  Future removeMemberApi(String teamId, String memberId) async {
    final param = "?team_id=$teamId&member_id=$memberId";
    final response = await postHttp(
      api: ApiUrls.userUrl + TeamUrl.removeMember + param,
      data: {},
      token: true,
    );
    log(response.body, name: 'response removeMemberApi');
    return json.decode(response.body);
  }

  Future getTeamTournamentList(
    int limit,
    int offset,
    String searchText,
    String? gameId,
    Tourny type,
    bool mine,
    bool favourite,
  ) async {
    final param =
        "?limit=$limit&offset=$offset&tournament_status=${type.value}${gameId == null ? '' : '&games=$gameId'}${mine ? '&logged_in_user=True' : ''}${favourite ? '&favourite=true' : ''}${searchText == '' ? '' : '&search_text=$searchText'}";
    final response = await getHttp(
      api: ApiUrls.tournamentUrl + TeamUrl.getTournaments + param,
      token: true,
    );
    log(response.body, name: 'response getTeamTournamentList');
    return json.decode(response.body);
  }

  Future joinTeamTournament(String teamId, String tournamentId) async {
    final param = "?team_id=$teamId&tournament_id=$tournamentId";
    final response = await postHttp(
      api: ApiUrls.tournamentUrl + TeamUrl.joinTournament + param,
      data: {},
      token: true,
    );
    log(response.body, name: 'response joinTeamTournament');
    return json.decode(response.body);
  }

  Future sendPaymentSSApi(String imgData) async {
    final data = {"img_data": imgData};
    final response = await postHttp(
      api: ApiUrls.userUrl + TeamUrl.sendPaymentSS,
      data: data,
      token: true,
    );
    log(response.body, name: 'response sendPaymentSSApi');
    return json.decode(response.body);
  }

  Future getJoinedTeamsApi(int offset, String tournamentId) async {
    // final param = "?limit=15&offset=$offset&tournament_id=$tournamentId";
    // TODO: confirm from navin if limit offset is necessary here
    final param = "?tournament_id=$tournamentId";
    final response = await getHttp(
      api: ApiUrls.tournamentUrl + TeamUrl.getJoinedTeams + param,
      token: true,
    );
    log(response.body, name: 'response getJoinedTeams');
    return json.decode(response.body);
  }

  Future leaveTeamApi(String teamId) async {
    final param = "?team_id=$teamId";
    final response = await postHttp(
      api: ApiUrls.userUrl + TeamUrl.leaveTeam + param,
      data: {},
      token: true,
    );
    log(response.body, name: 'response leaveTeamApi');
    return json.decode(response.body);
  }

  Future getTeamTournamentDetail(String tournamentId) async {
    final param = "?tournament_id=$tournamentId";
    final response = await getHttp(
      api: ApiUrls.tournamentUrl + TeamUrl.getTournaments + param,
      token: true,
    );
    log(response.body, name: 'response getTeamTournamentDetail');
    return json.decode(response.body);
  }

  Future getFavTournamentList(int limit, int offset, String searchText) async {
    final param =
        "?limit=$limit&offset=$offset${searchText == '' ? '' : '&search_text=$searchText'}";
    final response = await getHttp(
      api: ApiUrls.tournamentUrl + TeamUrl.getFavTournaments + param,
      token: true,
    );
    log(response.body, name: 'response getFavTournamentList');
    return json.decode(response.body);
  }

  Future likeTournamentApi(String id, bool isFavourite) async {
    final param = "?tournament_id=$id&favourite=$isFavourite";
    final response = await postHttp(
      api: ApiUrls.tournamentUrl + TeamUrl.likeTournament + param,
      data: {},
      token: true,
    );
    log(response.body, name: 'response likeTournamentApi');
    return json.decode(response.body);
  }
}
