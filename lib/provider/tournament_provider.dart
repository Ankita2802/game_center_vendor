// //Third Party Imports
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:playverse/models/carousel_model.dart';
// import 'package:playverse/models/participant.dart';

// //Local Imports
// import 'package:playverse/models/tournaments_model.dart';
// import 'package:playverse/repository/tournaments_repo.dart';
// import 'package:playverse/utils/enums.dart';
// import 'package:playverse/utils/toast_bar.dart';

// class TournamentsProvider extends ChangeNotifier {
//   final repo = TournamentsRepo();
//   // List<TournamentWinner>? tournamentWinner;
//   List<TournamentModel> upcomingTournaments = [];
//   List<TournamentModel> inProgressTournaments = [];
//   List<TournamentModel> completedTournaments = [];
//   List<TournamentModel> suggestedTournaments = [];
//   List<TournamentModel> userTournamentList = [];
//   List<TournamentModel> gamesTournamentList = [];
//   TournamentModel? tournamentDetail;

//   Future<List<TournamentModel>> getTournaments({
//     required int limit,
//     required int offset,
//     required Tourny type,
//     String? gameID,
//     bool mine = false,
//     String searchText = '',
//     bool favourite = false,
//   }) async {
//     try {
//       Map<String, dynamic> responseData = await repo.getTournamentList(
//           limit, offset, type, gameID, mine, searchText, favourite);
//       if (responseData['status_code'] == 200) {
//         List<TournamentModel> tempList = List<TournamentModel>.from(
//             responseData["data"].map((x) => TournamentModel.fromJson(x)));
//         return tempList;
//       } else {
//         log(responseData.toString(), name: 'getTournamentList Log');
//       }
//     } catch (e, s) {
//       log("$e", name: "getTournamentList Error", stackTrace: s);
//     }
//     return [];
//   }

//   Future<TournamentModel?> getTournamentsDetail(String tournamentId) async {
//     try {
//       Map<String, dynamic> responseData =
//           await repo.getTournamentDetail(tournamentId);
//       if (responseData['status_code'] == 200) {
//         tournamentDetail = TournamentModel.fromJson(responseData['data']);
//         notifyListeners();
//         return tournamentDetail;
//       } else {
//         log(responseData.toString(), name: 'getTournamentsDetail Log');
//       }
//     } catch (e) {
//       log("$e", name: "getTournamentsDetail Error");
//     }
//     return null;
//   }

//   Future<LeaderboardModel?> getLeaderboard(String tournamentId,
//       {bool isLadder = false}) async {
//     try {
//       Map<String, dynamic> responseData =
//           await repo.getleaderboardApi(tournamentId, isLadder);
//       if (responseData['status_code'] == 200) {
//         LeaderboardModel? leaderboardModel =
//             LeaderboardModel.fromJson(responseData["data"]);
//         notifyListeners();
//         return leaderboardModel;
//       } else {
//         log(responseData.toString(), name: 'getLeaderboard Log');
//       }
//     } catch (e, s) {
//       log("$e", name: "getLeaderboard Error", stackTrace: s);
//     }
//     return null;
//   }

//   // Future<dynamic> getGamesTournaments(int offset, String gameUUID) async {
//   //   try {
//   //     Map<String, dynamic> responseData =
//   //         await repo.getGamesTournamentList(offset, gameUUID);
//   //     if (responseData['status_code'] == 200) {
//   //       List<Tournament> tempList = List<Tournament>.from(
//   //           responseData["data"]!.map((x) => Tournament.fromJson(x)));
//   //       offset == 1
//   //           ? gamesTournamentList = tempList
//   //           : gamesTournamentList += tempList;
//   //       notifyListeners();
//   //       return tempList.length;
//   //     } else {
//   //       log(responseData.toString(), name: 'Tournaments Error Log');
//   //     }
//   //   } catch (e) {
//   //     log("$e", name: "Tournaments List Error");
//   //   }
//   // }

//   Future<bool> soloRegistration(
//       String tournamentId, Map<String, dynamic> data) async {
//     try {
//       final response =
//           await repo.soloTournamentRegistrtation(tournamentId, data);
//       if (response == 200) {
//         showCustomToast("Registration Done!");
//         return true;
//       } else if (response == 406) {
//         showCustomToast('Already Registered');
//         return false;
//       } else {
//         showCustomToast('Something went wrong');
//         return false;
//       }
//     } catch (e) {
//       showCustomToast('Something went wrong!! $e');
//     }
//     return false;
//   }

//   Future<Map<String, dynamic>?> getScore(String id) async {
//     try {
//       Map<String, dynamic> responseData = await repo.getScoreApi(id);
//       if (responseData['status_code'] == 200) {
//         if (responseData['data'] == null) {
//           return null;
//         }
//         return responseData["data"];
//       } else {
//         log(responseData.toString(), name: 'getScore Log');
//       }
//     } catch (e) {
//       log("$e", name: "Error getScore");
//     }
//     return null;
//   }

//   Future<List<Participant>> getParticipants(int offset, String id) async {
//     try {
//       Map<String, dynamic> responseData =
//           await repo.getParticipantsApi(15, offset, id);
//       if (responseData['status_code'] == 200) {
//         if (responseData['data'] == null) {
//           return [];
//         }
//         List<Participant> tempList = List<Participant>.from(
//             responseData["data"].map((x) => Participant.fromJson(x))).toList();

//         notifyListeners();
//         return tempList;
//       } else {
//         log(responseData.toString(), name: 'getParticipants Log');
//       }
//     } catch (e) {
//       log("$e", name: "Error getParticipants");
//     }
//     return [];
//   }

//   Future<List<CarouselModel>> getCarousels() async {
//     try {
//       Map<String, dynamic> responseData = await repo.getCarouselApi();
//       if (responseData['status_code'] == 200) {
//         if (responseData['data'] == null) {
//           return [];
//         }
//         List<CarouselModel> tempList = List<CarouselModel>.from(
//                 responseData["data"].map((x) => CarouselModel.fromJson(x)))
//             .toList();

//         notifyListeners();
//         return tempList;
//       } else {
//         log(responseData.toString(), name: 'getCarousels Log');
//       }
//     } catch (e) {
//       log("$e", name: "Error getCarousels");
//     }
//     return [];
//   }

//   // Future<dynamic> getUserTournaments(int offset) async {
//   //   try {
//   //     Map<String, dynamic> responseData = await repo.getUserTournaments(offset);
//   //     if (responseData['status_code'] == 200) {
//   //       List<Tournament> tempList = List<Tournament>.from(
//   //           responseData["data"]!.map((x) => Tournament.fromJson(x)));
//   //       offset == 1
//   //           ? userTournamentList = tempList
//   //           : userTournamentList += tempList;
//   //       notifyListeners();
//   //       return tempList.length;
//   //     } else {
//   //       log(responseData.toString(), name: 'User Tournaments Detail Error Log');
//   //     }
//   //   } catch (e) {
//   //     log("$e", name: "User Tournaments Detail List Error");
//   //   }
//   // }
// }
