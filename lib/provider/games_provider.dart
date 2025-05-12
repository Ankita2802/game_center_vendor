//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:game_center_vendor/models/games_model.dart';
import 'package:game_center_vendor/reositry/games_repo.dart';
import 'package:game_center_vendor/utils/toast_bar.dart';

class GamesListProvider extends ChangeNotifier {
  final repo = GamesRepo();
  List<Games> gameList = [];
  List<Games> filteredGameList = [];
  List<Games> userGameList = [];
  List<Games> otherUserGameList = [];

  List<Games> mainGameList = [];

  // Games for edit team screen
  List<Games> teamGameList = [];

  Future<List<Games>> getGamesList(
    int offset, {
    bool forTeam = false,
    bool mainScreen = false,
    int limit = 15,
  }) async {
    try {
      Map<String, dynamic> responseData = await repo.gamesListApi(
        offset,
        limit,
      );
      if (responseData['status_code'] == 200) {
        List<Games> tempList = List<Games>.from(
          responseData["data"].map((x) => Games.fromJson(x)),
        );

        if (forTeam) {
          teamGameList = tempList;
        } else if (mainScreen) {
          offset == 1 ? mainGameList = tempList : mainGameList += tempList;
        } else {
          offset == 1 ? gameList = tempList : gameList += tempList;
        }
        notifyListeners();
        return tempList;
      } else {
        log(responseData.toString(), name: 'getGamesList Log');
      }
    } catch (e) {
      log("$e", name: "Error getGamesList");
    }
    return [];
  }

  void searchGames(String query) {
    if (query.isEmpty) {
      filteredGameList = gameList;
    } else {
      filteredGameList =
          gameList
              .where(
                (game) =>
                    game.name!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  Future<Games?> getSpecificGame(String gameID) async {
    try {
      Map<String, dynamic> responseData = await repo.getSpecificGame(gameID);
      if (responseData['status_code'] == 200) {
        final gameData = Games.fromJson(responseData['data']);
        notifyListeners();
        return gameData;
      } else {
        log(responseData.toString(), name: 'Game List Log');
      }
    } catch (e) {
      log("$e", name: "Error in Games");
    }
    return null;
  }

  Future<bool> addGames(String gameID, [String? inGameName]) async {
    try {
      Map<String, dynamic> data = {'game_id': gameID};
      if (inGameName != null) {
        data["in_game_name"] = inGameName;
      }
      final responseData = await repo.addGames(data);
      if (responseData['status_code'] == 200) {
        showCustomToast(responseData['message']);
        return true;
      } else {
        showCustomToast(responseData['message']);
        log(responseData.toString(), name: 'addGames Log');
      }
    } catch (e) {
      showCustomToast('Something went wrong');
      log("$e", name: "Error addGames");
    }
    return false;
  }

  Future<int> userGames(int offset, String? userId) async {
    try {
      Map<String, dynamic> responseData = await repo.userGamesApi(
        offset,
        userId,
      );
      if (responseData['status_code'] == 200) {
        List<Games> tempList = List<Games>.from(
          responseData["data"].map((x) => Games.fromJson(x)),
        );
        if (userId == null) {
          offset == 1 ? userGameList = tempList : userGameList += tempList;
        } else {
          offset == 1
              ? otherUserGameList = tempList
              : otherUserGameList += tempList;
        }
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'userGames Log');
      }
    } catch (e) {
      log("$e", name: "Error userGames");
    }
    return 0;
  }

  Future<dynamic> deleteGames(String gameID) async {
    try {
      Map<String, dynamic> responseData = await repo.deleteGames(gameID);
      if (responseData['status_code'] == 200) {
        showCustomToast(responseData['message']);
        return true;
      } else {
        log(responseData.toString(), name: 'Game delete Log');
      }
    } catch (e) {
      log("$e", name: "Error in Games delete");
    }
  }
}
