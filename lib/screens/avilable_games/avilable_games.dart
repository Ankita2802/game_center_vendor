import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/screens/avilable_games/game_type_bottomsheet.dart';
import 'package:game_center_vendor/screens/game_center_facilities/game_center_facilites.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/new_header.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';

class AvilableGames extends StatefulWidget {
  const AvilableGames({super.key});

  @override
  State<AvilableGames> createState() => _AvilableGamesState();
}

class _AvilableGamesState extends State<AvilableGames> {
  final _formKey = GlobalKey<FormState>();
  final gameTypeController = TextEditingController();
  final gamesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000502),
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(SvgIcons.appbarBack),
          ),
        ),
        title: Text(
          'Available Games',
          style: onestFonts.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [SvgPicture.asset(SvgIcons.moreMenu), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                headingRow('Game Type', () {}),
                SizedBox(height: 24),
                ProfileTextfield(
                  controller: gameTypeController,
                  labelText: 'Game Type',
                  hintText: 'Enter Game Type',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder:
                          (context) => GameTypeBottomsheet(
                            title: 'Game Type',
                            controller: gameTypeController,
                            labelText: 'Game Type',
                            gamesType: ['PC Games', 'Console Games'],
                          ),
                    );
                  },
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                  suffixIcon: Image.asset(
                    ProfileGameImages.editMessageIcon,
                    cacheHeight: 25,
                    cacheWidth: 25,
                  ),
                ),
                const SizedBox(height: 24),
                ProfileTextfield(
                  controller: gamesController,
                  labelText: 'Games',
                  hintText: 'Enter Games',
                  suffixIcon: Image.asset(
                    ProfileGameImages.editMessageIcon,
                    cacheHeight: 25,
                    cacheWidth: 25,
                  ),
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 24),
                AuthButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameCenterFacilities(),
                      ),
                    );
                    // });
                  },
                  text: 'Next',
                  arrow: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget headingRow(String text, VoidCallback onTap) {
  return Row(
    children: [
      Text(
        text,
        style: onestFonts.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Spacer(),
      NewHeader(
        onTap: onTap,
        title: '',
        buttonLabel: 'Add',
        headerStyle: oxaniumFonts.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
