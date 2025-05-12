//Thrid Party Imports
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_center_vendor/models/tournament_model.dart';
import 'package:game_center_vendor/provider/team_provider.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/utils/enum.dart';
import 'package:game_center_vendor/utils/helper_utills.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/favourites_chip.dart';

import 'package:provider/provider.dart';
//Local Imports

class TournamentListWidget extends StatefulWidget {
  final Tourny type;
  final TournyType tournyType;
  final String? gameId;
  final int limit;
  final bool pagination;
  final bool favouriteTourny;
  final bool scrollable;
  final bool myTourney;
  // final bool redirectLeaderBoaurd;
  final String searchText;
  const TournamentListWidget({
    super.key,
    required this.type,
    required this.tournyType,
    this.gameId,
    this.limit = 10,
    this.pagination = true,
    this.favouriteTourny = false,
    this.scrollable = true,
    this.myTourney = false,
    // this.redirectLeaderBoaurd = false,
    this.searchText = '',
  });

  @override
  State<TournamentListWidget> createState() => _TournamentListWidgetState();
}

class _TournamentListWidgetState extends State<TournamentListWidget> {
  late TeamProvider provider;
  // late TournamentsProvider tournamentsProvider;
  List<TournamentModel> tournamentList = [];
  bool isLoading = true;
  bool loader = false, paginate = true;
  int offset = 1;
  Future<void> paginationTournaments() async {
    if (!paginate) return;
    setState(() {
      loader = true;
    });
    await fetch().then((value) {
      if (value.length < 10) paginate = false;
      loader = false;
      offset == 1 ? tournamentList = value : tournamentList += value;
      offset += 10;
      isLoading = false;
      if (mounted) setState(() {});
    });
  }

  Future<List<TournamentModel>> fetch() {
    if (widget.tournyType == TournyType.solo) {
      return provider.getTeamTournaments(
        limit: widget.limit,
        offset: offset,
        type: widget.type,
        gameId: widget.gameId,
        searchText: widget.searchText,
        favourite: widget.favouriteTourny,
      );
      // return tournamentsProvider.getTournaments(
      //   limit: widget.limit,
      //   offset: offset,
      //   type: widget.type,
      //   gameID: widget.gameId,
      //   searchText: widget.searchText,
      //   favourite: widget.favouriteTourny,
      // );
    } else {
      return provider.getTeamTournaments(
        limit: widget.limit,
        offset: offset,
        type: widget.type,
        gameId: widget.gameId,
        searchText: widget.searchText,
        favourite: widget.favouriteTourny,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // searchText = widget.searchText;
    provider = Provider.of<TeamProvider>(context, listen: false);
    // tournamentsProvider = Provider.of<TournamentsProvider>(
    //   context,
    //   listen: false,
    // );
    if (widget.pagination) {
      paginationTournaments();
    } else {
      if (widget.tournyType == TournyType.solo) {
        provider
            .getTeamTournaments(
              limit: widget.limit,
              offset: offset,
              type: widget.type,
            )
            .then((value) {
              tournamentList = value;
              isLoading = false;
              if (mounted) setState(() {});
            });
      } else {
        provider
            .getTeamTournaments(
              limit: widget.limit,
              offset: offset,
              type: widget.type,
            )
            .then((value) {
              tournamentList = value;
              isLoading = false;
              if (mounted) setState(() {});
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [widget.pagination ? Expanded(child: mainList()) : mainList()],
    );
  }

  Widget mainList() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : tournamentList.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 14),
              Image.asset(
                HomeImages.trophy,
                height: 100,
                color: Color(0xFF0A0A0A),
                colorBlendMode: BlendMode.color,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 14),
              Text(
                'No ${widget.tournyType.value} Found',
                style: onestFonts.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 14),
              Text(
                "There are no ${widget.tournyType.value} available of\nthis type",
                textAlign: TextAlign.center,
                style: onestFonts.copyWith(
                  fontSize: 14,
                  color: Color(0xFFBCB8B8),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        )
        : NotificationListener(
          onNotification:
              (notification) =>
                  Utils.scrollNotifier(notification, paginationTournaments),
          child: ListView.builder(
            physics:
                widget.scrollable ? null : const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            shrinkWrap: true,
            itemCount: tournamentList.length,
            itemBuilder: (BuildContext context, int index) {
              return MyTournamentCard(
                onLike: () {
                  if (tournamentList[index].isFavourite == null) return;
                  // tournamentList[index].isFavourite =
                  //     !(tournamentList[index].isFavourite!);
                  // if (mounted) setState(() {});
                  provider
                      .likeTournament(
                        tournamentList[index].tournamentId ?? '',
                        !(tournamentList[index].isFavourite!),
                      )
                      .then((value) {
                        if (!value) return;
                        tournamentList.removeAt(index);
                        if (mounted) setState(() {});
                      });
                },
                model: tournamentList[index],
                type: widget.type,
                favourite: widget.favouriteTourny,
                tournyType: widget.tournyType,
              );
            },
          ),
        );
  }
}

class MyTournamentCard extends StatelessWidget {
  final TournamentModel model;
  final Tourny type;
  final bool favourite;
  final VoidCallback onLike;
  final TournyType tournyType;
  const MyTournamentCard({
    super.key,
    required this.model,
    required this.type,
    required this.favourite,
    required this.onLike,
    required this.tournyType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Color(0XFF151314),
            Color(0XFF151314),
            Color(0XFF151314),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(left: 0, child: Image.asset(StreamsImages.union)),
          // Background Image
          ClipPath(
            clipper: NotchedClipper(),
            child: Container(
              height: 187,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x00FFFFFF), Color(0xFFBB8AD5)],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      ClipPath(
                        clipper: NotchedClipper(),
                        child: CachedNetworkImage(
                          imageUrl: model.thumbnail ?? "",
                          height: 186,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorWidget:
                              (context, url, error) => Container(
                                color: Colors.grey,
                                height: 186,
                                width: double.infinity,
                                child: Icon(Icons.info_outline),
                              ),
                        ),
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 16,
                    right: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            model.title ?? "",
                            maxLines: 2,
                            style: onestFonts.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          children: [
                            Text(
                              (model.gameName ?? '(GAME NAME)').toUpperCase(),
                              // .toUpperCase()
                              // .abbriviate(8),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: pressStart2pFonts.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                        // Image.network(
                        //   model.logo ?? "",
                        //   height: 40,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Container(
                      height: 1,
                      width: 107,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xFF636363),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        border: Border.all(
                          width: 1, // Border width
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        type == Tourny.completed
                            ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF7E2828),
                                    Color(0xFFE44949),
                                  ],
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(1),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFFE31C1C),
                                      Color(0xFF7E0202),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "TOURNAMENT ENDED",
                                  style: onestFonts.copyWith(
                                    fontSize: 12,
                                    color: Color(0xFFF9D2D2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PRIZE POOL",
                                  style: onestFonts.copyWith(
                                    fontSize: 10,
                                    color: Color(0xFFBCB8B8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  (model.prizePool?.entries.first.value
                                                  .toString() ??
                                              '')
                                          .contains('GEMS')
                                      ? (model.prizePool?.entries.first.value
                                              .toString() ??
                                          '0 GEMS')
                                      : ('₹ ${model.prizePool?.entries.first.value.toString() ?? '0'}'),
                                  style: orbitronFonts,
                                ),
                              ],
                            ),
                        AuthButton(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder:
                            //         (context) => TournamentDetailScreen(
                            //           type: type,
                            //           tournamentID: model.tournamentId ?? '',
                            //           tournyType: tournyType,
                            //         ),
                            //   ),
                            // );
                          },
                          text:
                              'Register @ ${(model.registrationFee?.toInt() ?? 0) == 0 ? 'Free' : '₹${(model.registrationFee?.toInt() ?? 0)}'}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 15,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "SLOT LEFT ",
                      style: onestFonts.copyWith(
                        fontSize: 10,
                        color: Color(0xFFDEECF4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${((model.maxPlayers ?? 0) - (model.playerLeft ?? 0))}/${model.maxPlayers}",
                      style: onestFonts.copyWith(
                        fontSize: 10,
                        color: Color(0xFFDEECF4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  height: 6,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Color(0x66000000),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 6,
                        width:
                            90 *
                            ((((model.maxPlayers ?? 0) -
                                    (model.playerLeft ?? 0))) /
                                (model.maxPlayers ?? 0)),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF054C41), Color(0xFF2ACBB3)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (favourite)
            Positioned(
              left: 5,
              top: 146,
              child: FavouriteChip(
                isFavourite: model.isFavourite ?? false,
                onTap: onLike,
              ),
            ),
          if (model.extra!["Format"] != null)
            Positioned(
              top: 15,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFFE4A634), Color(0xFFB86914)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: Text(
                  'Format: ${model.extra!["Format"]}',
                  style: onestFonts.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NotchedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 12; // For rounded corners
    const double notchWidth = 140;
    const double notchHeight = 15;

    Path path = Path();

    // Top-left corner
    path.moveTo(0 + radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Right side down
    path.lineTo(size.width, size.height - notchHeight - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - notchHeight,
      size.width - radius,
      size.height - notchHeight,
    );

    // Bottom-right notch
    path.lineTo(size.width - notchWidth + radius, size.height - notchHeight);
    // path.arcToPoint(
    //     Offset(size.width - notchWidth - radius - radius,
    //         size.height - notchWidth + radius),
    //     radius: Radius.circular(10),
    //     clockwise: false);
    path.lineTo(size.width - notchWidth - radius, size.height);
    // path.quadraticBezierTo(
    //     size.width - notchWidth ,
    //     size.height,
    //     size.width - notchWidth - 5,
    //     size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // Left side up
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
