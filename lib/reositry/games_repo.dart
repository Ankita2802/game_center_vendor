//Third Party Imports
import 'dart:convert';
import 'dart:developer';

import 'package:game_center_vendor/reositry/base_repo.dart';
import 'package:game_center_vendor/utils/app_urls.dart';
//Local Imports

class GamesRepo extends BaseRepository {
  Future gamesListApi(int offset, int limit) async {
    String params = "?limit=$limit&offset=$offset";
    final response = await getHttp(
      api: ApiUrls.userUrl + GamesUrls.gamesList + params,
      token: true,
    );
    log(response.body, name: 'response gamesListApi');
    return json.decode(response.body);
  }

  Future getSpecificGame(String gameId) async {
    String params = "?game_id=$gameId";
    final response = await getHttp(
      api: ApiUrls.userUrl + GamesUrls.gamesList + params,
      token: true,
    );
    log(response.body, name: 'response getSpecificGame');
    return json.decode(response.body);
  }

  Future addGames(Map<String, dynamic> data) async {
    final response = await postHttp(
      api: ApiUrls.userUrl + GamesUrls.addGames,
      data: data,
      token: true,
    );
    log(response.body, name: 'response addGames');
    return json.decode(response.body);
  }

  Future userGamesApi(int offset, String? userId) async {
    String params =
        "?your_games=true&limit=15&offset=$offset${userId == null ? '' : "&another_user_id=$userId"}";
    final response = await getHttp(
      api: ApiUrls.userUrl + GamesUrls.userGames + params,
      token: true,
    );
    log(response.body, name: 'response userGamesApi $params');
    return json.decode(response.body);
  }

  Future deleteGames(String gameID) async {
    String params = "?game_id=$gameID";
    final response = await deleteHttp(
      api: ApiUrls.userUrl + GamesUrls.deleteGames + params,
      token: true,
    );
    log(response.body, name: 'response deleteGames');
    return json.decode(response.body);
  }
}
