import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/new_header.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';

class AddGameCenterSpecs extends StatefulWidget {
  const AddGameCenterSpecs({super.key});

  @override
  State<AddGameCenterSpecs> createState() => _AddGameCenterSpecsState();
}

class _AddGameCenterSpecsState extends State<AddGameCenterSpecs> {
  final _formKey = GlobalKey<FormState>();
  final pcSlotsController = TextEditingController();
  final pcSpecsController = TextEditingController();
  final pcPriceController = TextEditingController();
  final consoleSlotsController = TextEditingController();
  final consoleSpecsController = TextEditingController();
  final consolePriceController = TextEditingController();
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
          'Game Center Specs',
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
                headingRow('PC Specs', () {}, GameCenterImgs.computer),
                SizedBox(height: 24),
                ProfileTextfield(
                  controller: pcSlotsController,
                  labelText: 'Number of PC Slots',
                  hintText: 'Enter Number of PC Slots',
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                ProfileTextfield(
                  controller: pcSpecsController,
                  labelText: 'PC Specs',
                  hintText: 'Enter PC Specs',
                  suffixIcon: Image.asset(
                    ProfileGameImages.editMessageIcon,
                    cacheHeight: 25,
                    cacheWidth: 25,
                  ),
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                ProfileTextfield(
                  controller: pcPriceController,
                  labelText: 'PC Price / h',
                  hintText: 'Enter PC Price / h',
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 24),
                headingRow(
                  'Console Specs',
                  () {},
                  GameCenterImgs.gameController,
                ),
                SizedBox(height: 24),
                ProfileTextfield(
                  controller: consoleSlotsController,
                  labelText: 'Number of Console Slots',
                  hintText: 'Enter Number of Console Slots',
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                ProfileTextfield(
                  controller: consoleSpecsController,
                  labelText: 'Console Specs',
                  hintText: 'Enter Console Specs',
                  isLabel: true,
                  suffixIcon: Image.asset(
                    ProfileGameImages.editMessageIcon,
                    cacheHeight: 25,
                    cacheWidth: 25,
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                ProfileTextfield(
                  controller: consolePriceController,
                  labelText: 'Console Price / h',
                  hintText: 'Enter Console Price / h',
                  isLabel: true,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 24),
                AuthButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddGameCenterSpecs(),
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

Widget headingRow(String text, VoidCallback onTap, String gameAsset) {
  return Row(
    children: [
      SvgPicture.asset(gameAsset, height: 24, width: 24),
      SizedBox(width: 10),
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
