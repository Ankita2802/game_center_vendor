import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/game_center_card.dart';

class GameCenterList extends StatefulWidget {
  const GameCenterList({super.key});

  @override
  State<GameCenterList> createState() => _GameCenterListState();
}

class _GameCenterListState extends State<GameCenterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(SvgIcons.appbarBack),
          ),
        ),
        centerTitle: true,
        title: Text('Game Centers', style: onestFonts.copyWith(fontSize: 18)),
        actions: [
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(SvgIcons.search),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20),
        separatorBuilder: (context, index) => SizedBox(height: 24),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GameCenterCard();
        },
      ),
    );
  }
}
