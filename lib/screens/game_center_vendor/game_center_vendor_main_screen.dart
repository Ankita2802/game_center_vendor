import 'package:flutter/material.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_list.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/game_center_card.dart';
import 'package:game_center_vendor/widgets/new_header.dart';

class GameCenterVendorMainScreen extends StatefulWidget {
  const GameCenterVendorMainScreen({super.key});

  @override
  State<GameCenterVendorMainScreen> createState() =>
      _GameCenterVendorMainScreenState();
}

class _GameCenterVendorMainScreenState
    extends State<GameCenterVendorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Color(0XFF0A0A0A),
        title: Image.asset(GameCenterVendor.playverse, width: 100),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(GameCenterVendor.profile),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
          child: Column(
            children: [
              NewHeader(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameCenterList()),
                  );
                },
                title: 'My Game Centers',
                buttonLabel: 'Add',
                headerStyle: oxaniumFonts.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListView.separated(
                padding: EdgeInsets.all(20),
                separatorBuilder: (context, index) => SizedBox(height: 24),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GameCenterCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
