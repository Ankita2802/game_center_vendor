//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:game_center_vendor/models/invite_user_model.dart';
import 'package:game_center_vendor/models/joined_team.dart';
import 'package:game_center_vendor/models/member_model.dart';
import 'package:game_center_vendor/models/team_invitation_model.dart';
import 'package:game_center_vendor/models/team_model.dart';
import 'package:game_center_vendor/models/tournament_model.dart';
import 'package:game_center_vendor/models/user_request.dart';
import 'package:game_center_vendor/reositry/team_repo.dart';
import 'package:game_center_vendor/utils/enum.dart';
import 'package:game_center_vendor/utils/toast_bar.dart';

//Local Imports

class TeamProvider extends ChangeNotifier {
  final repo = TeamRepo();

  String? dropDownValue;
  List<JoinedTeam> participantsList = [];
  List<JoinedTeam> resultsList = [];
  List<TournamentModel> homeTournaments = [];

  void updateDropDown(String? value) {
    dropDownValue = value;
    notifyListeners();
  }

  List<TeamModel> myTeams = [];
  List<TeamModel> teamList = [];

  List<MemberModel> membersList = [];

  TeamModel? teamModel;

  Future<bool> createTeam(String name, String gameId) async {
    try {
      final responseData = await repo.createTeamApi(name, gameId);
      if (responseData['status_code'] == 200) {
        getTeam(myTeam: true);
        showCustomToast("Team Created Successfully.");
        return true;
      } else if (responseData['status_code'] == 400) {
        showCustomToast(responseData['message']);
        return false;
      } else {
        log(responseData.toString(), name: 'createTeam Logs');
        showCustomToast("Couldn't create team");
        return false;
      }
    } catch (e, s) {
      log("$e", name: "Error in createTeam", stackTrace: s);
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<bool> updateTeam(Map<String, dynamic> data, String teamId) async {
    try {
      Map<String, dynamic> responseData = await repo.updateTeamApi(
        data,
        teamId,
      );
      if (responseData['status_code'] == 200) {
        showCustomToast("Team Updated Successfully.");
        getTeam(myTeam: true);
        getTeam(teamId: teamId);
        return true;
      } else {
        log(responseData.toString(), name: 'updateTeam Logs');
        showCustomToast(responseData['message']);
        return false;
      }
    } catch (e, s) {
      log("$e", name: "Error in updateTeam", stackTrace: s);
      showCustomToast("Something went wrong");
      return false;
    }
  }

  // Returning bool only for use in myTeam
  Future<List<TeamModel>> getTeam({
    bool myTeam = false,
    int offset = 1,
    String? searchText,
    String? gameId,
    String? teamId,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.getTeamApi(
        myTeam,
        offset,
        searchText,
        gameId,
        teamId,
      );
      log(responseData.toString(), name: 'response getTeam');
      if (responseData['status_code'] == 200) {
        List<TeamModel> tempList = List<TeamModel>.from(
          responseData["data"].map((x) => TeamModel.fromJson(x)),
        );
        if (gameId != null) {
          return tempList;
        }
        if (teamId != null) {
          teamModel = tempList[0];
        }
        if (myTeam) {
          myTeams = tempList;
        } else {
          offset == 1 ? teamList = tempList : teamList += tempList;
        }
        notifyListeners();
        return tempList;
      } else if (responseData['status_code'] == 400 && myTeam) {
        myTeams = [];
        notifyListeners();
      }
    } catch (e, s) {
      log("$e", name: "Error getTeam", stackTrace: s);
    }
    if (myTeam) myTeams.clear();
    notifyListeners();
    return [];
  }

  Future<bool> deleteTeam(String teamId) async {
    try {
      Map<String, dynamic> responseData = await repo.deleteTeamApi(teamId);
      if (responseData['status_code'] == 200) {
        showCustomToast("Team Deleted Successfully.");
        getTeam(myTeam: true);
        return true;
      } else {
        log(responseData.toString(), name: 'deleteTeam Logs');
        showCustomToast(responseData['message']);
        return false;
      }
    } catch (e) {
      log("$e", name: "Error in deleteTeam");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<bool> sendJoinRequest(String teamId, String? role) async {
    try {
      Map<String, dynamic> responseData = await repo.sendJoinRequestApi(
        teamId,
        role,
      );
      if (responseData['status_code'] == 200) {
        showCustomToast('Join Request Sent');
        return true;
      } else {
        log(responseData.toString(), name: 'sendJoinRequest Logs');
        showCustomToast(responseData['message']);
        return false;
      }
    } catch (e) {
      log("$e", name: "Error in sendJoinRequest");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<bool> invitePlayer(String userId, String teamId, String? role) async {
    try {
      Map<String, dynamic> responseData = await repo.invitePlayerApi(
        userId,
        teamId,
        role,
      );
      if (responseData['status_code'] == 200) {
        showCustomToast('Invite Sent');
        return true;
      } else {
        log(responseData.toString(), name: 'invitePlayer Logs');
        showCustomToast(responseData['message']);
        return false;
      }
    } catch (e) {
      log("$e", name: "Error in invitePlayer");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<List<UserRequest>> getUserRequests({
    int offset = 1,
    required String teamId,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.getUserRequestsApi(
        offset,
        teamId,
      );
      log(responseData.toString(), name: 'response getUserRequests');
      if (responseData['status_code'] == 200) {
        List<UserRequest> tempList = List<UserRequest>.from(
          responseData["data"].map((x) => UserRequest.fromJson(x)),
        );

        notifyListeners();
        return tempList;
      }
    } catch (e, s) {
      log("$e", name: "Error getUserRequests", stackTrace: s);
    }
    notifyListeners();
    return [];
  }

  Future<List<InvitedUserModel>> getInvitedUsers({
    int offset = 1,
    required String teamId,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.getInvitedUsersApi(
        offset,
        teamId,
      );
      log(responseData.toString(), name: 'response getInvitedUsers');
      if (responseData['status_code'] == 200) {
        List<InvitedUserModel> tempList = List<InvitedUserModel>.from(
          responseData["data"].map((x) => InvitedUserModel.fromJson(x)),
        );

        notifyListeners();
        return tempList;
      }
    } catch (e, s) {
      log("$e", name: "Error getInvitedUsers", stackTrace: s);
    }
    notifyListeners();
    return [];
  }

  Future<int> getMembers({int offset = 1, required String teamId}) async {
    try {
      Map<String, dynamic> responseData = await repo.getMembersApi(
        offset,
        teamId,
      );
      log(responseData.toString(), name: 'response getMembers');
      if (responseData['status_code'] == 200) {
        List<MemberModel> tempList = List<MemberModel>.from(
          responseData["data"].map((x) => MemberModel.fromJson(x)),
        );
        offset == 1 ? membersList = tempList : membersList += tempList;
        notifyListeners();
        return tempList.length;
      }
    } catch (e, s) {
      log("$e", name: "Error getMembers", stackTrace: s);
    }
    notifyListeners();
    return 0;
  }

  Future<List<TeamInvitationModel>> getTeamInvitaions({int offset = 1}) async {
    try {
      Map<String, dynamic> responseData = await repo.getTeamInvitationsApi(
        offset,
      );
      log(responseData.toString(), name: 'response getTeamInvitaions');
      if (responseData['status_code'] == 200) {
        List<TeamInvitationModel> tempList = List<TeamInvitationModel>.from(
          responseData["data"].map((x) => TeamInvitationModel.fromJson(x)),
        );

        notifyListeners();
        return tempList;
      }
    } catch (e, s) {
      log("$e", name: "Error getTeamInvitaions", stackTrace: s);
    }
    notifyListeners();
    return [];
  }

  Future<bool> invitationAction({
    required String teamId,
    required bool accept,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.invitaionActionApi(
        teamId,
        accept,
      );
      if (responseData['status_code'] == 200) {
        getTeam(myTeam: true);
      }
      return responseData['status_code'] == 200;
    } catch (e) {
      log("$e", name: "Error in invitationAction");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<bool> requestAction({
    required String teamId,
    required String userId,
    required bool accept,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.requestActionApi(
        userId,
        teamId,
        accept,
      );
      return responseData['status_code'] == 200;
    } catch (e) {
      log("$e", name: "Error in requestAction");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<bool> removeMember({
    required String teamId,
    required String memberId,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.removeMemberApi(
        teamId,
        memberId,
      );
      return responseData['status_code'] == 200;
    } catch (e) {
      log("$e", name: "Error in removeMember");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<List<TournamentModel>> getTeamTournaments({
    required int limit,
    required int offset,
    String searchText = '',
    String? gameId,
    required Tourny type,
    bool myTourny = false,
    bool forHome = false,
    bool favourite = false,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.getTeamTournamentList(
        limit,
        offset,
        searchText,
        gameId,
        type,
        myTourny,
        favourite,
      );
      if (responseData['status_code'] == 200) {
        List<TournamentModel> tempList = List<TournamentModel>.from(
          responseData["data"].map((x) => TournamentModel.fromJson(x)),
        );
        if (forHome) {
          homeTournaments = tempList;
          notifyListeners();
        }
        return tempList;
      } else {
        log(responseData.toString(), name: 'getTeamTournaments $type Log');
      }
    } catch (e, s) {
      log("$e", name: "getTeamTournaments $type Error", stackTrace: s);
    }
    return [];
  }

  Future<bool> joinTeamTournament({
    required String teamId,
    required String tournamentId,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.joinTeamTournament(
        teamId,
        tournamentId,
      );
      log(responseData.toString(), name: 'joinTeamTournament Log');
      showCustomToast(responseData['message']);
      return responseData['status_code'] == 200;
    } catch (e) {
      log("$e", name: "Error in joinTeamTournament");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<bool> sendPaymentSS(String imgData) async {
    try {
      Map<String, dynamic> responseData = await repo.sendPaymentSSApi(imgData);
      log(responseData.toString(), name: 'sendPaymentSS Log');
      showCustomToast(responseData['message']);
      return responseData['status_code'] == 200;
    } catch (e) {
      log("$e", name: "Error in sendPaymentSS");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<List<JoinedTeam>> getJoinedTeams({
    int offset = 1,
    required String tournamentId,
    bool forResult = false,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.getJoinedTeamsApi(
        offset,
        tournamentId,
      );
      log(responseData.toString(), name: 'response getJoinedTeams');
      if (responseData['status_code'] == 200) {
        List<JoinedTeam> tempList = List<JoinedTeam>.from(
          responseData["data"].map((x) => JoinedTeam.fromJson(x)),
        );
        if (forResult) {
          offset == 1 ? resultsList = tempList : resultsList += tempList;
        } else {
          offset == 1
              ? participantsList = tempList
              : participantsList += tempList;
        }
        notifyListeners();
        return tempList;
      }
    } catch (e, s) {
      log("$e", name: "Error getJoinedTeams", stackTrace: s);
    }
    notifyListeners();
    return [];
  }

  Future<bool> leaveTeam(String teamId) async {
    try {
      Map<String, dynamic> responseData = await repo.leaveTeamApi(teamId);
      if (responseData['status_code'] == 200) {
        showCustomToast("Team Left Successfully.");
        getTeam(myTeam: true);
        return true;
      } else {
        log(responseData.toString(), name: 'leaveTeam Logs');
        showCustomToast(responseData['message']);
        return false;
      }
    } catch (e) {
      log("$e", name: "Error in leaveTeam");
      showCustomToast("Something went wrong");
      return false;
    }
  }

  Future<TournamentModel?> getTeamTournamentDetail(String tournamentId) async {
    try {
      Map<String, dynamic> responseData = await repo.getTeamTournamentDetail(
        tournamentId,
      );
      if (responseData['status_code'] == 200) {
        final detail = TournamentModel.fromJson(responseData['data']);
        notifyListeners();
        return detail;
      } else {
        log(responseData.toString(), name: 'getTeamTournamentDetail Log');
      }
    } catch (e) {
      log("$e", name: "getTeamTournamentDetail Error");
    }
    return null;
  }

  Future<bool> likeTournament(String id, bool isFavourite) async {
    try {
      // final data = {
      //   "tournament_id": id,
      //   "is_favourite": isFavourite,
      //   "tournament_type": "TEAM"
      // };
      Map<String, dynamic> responseData = await repo.likeTournamentApi(
        id,
        isFavourite,
      );
      if (responseData['status_code'] == 200) {
        return true;
      } else {
        log(responseData.toString(), name: 'likeTournament Logs');
        return false;
      }
    } catch (e) {
      log("$e", name: "Error in likeTournament");
      showCustomToast("Something went wrong");
      return false;
    }
  }
}
