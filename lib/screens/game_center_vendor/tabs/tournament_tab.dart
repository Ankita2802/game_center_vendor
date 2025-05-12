import 'package:flutter/material.dart';
import 'package:game_center_vendor/screens/game_center_vendor/tournamnet/tournament_list_widget.dart';
import 'package:game_center_vendor/utils/enum.dart';

class TournamentsTab extends StatelessWidget {
  const TournamentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TournamentListWidget(
      tournyType: TournyType.solo,
      type: Tourny.upcoming,
    );
  }
}
