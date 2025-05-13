import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/new_header.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';
import 'package:image_picker/image_picker.dart';

class GameCenterFacilities extends StatefulWidget {
  const GameCenterFacilities({super.key});

  @override
  State<GameCenterFacilities> createState() => _GameCenterFacilitiesState();
}

class _GameCenterFacilitiesState extends State<GameCenterFacilities> {
  final _formKey = GlobalKey<FormState>();
  final facilityController = TextEditingController();
  final gamesController = TextEditingController();
  File? _teamImage;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _teamImage = File(image.path);
      });
    }
  }

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
                headingRow('Facilities', () {}),
                SizedBox(height: 24),
                ProfileTextfield(
                  controller: facilityController,
                  labelText: 'Facility',
                  hintText: 'Enter Facility',
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
                        builder: (context) => const GameCenterFacilities(),
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
  Widget _uploadImg() {
  return _teamImage != null
      ? Stack(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _teamImage!,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF000502),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Icon(Icons.edit),
              ),
            ),
          ),
        ],
      )
      : SizedBox(
        width: double.infinity,
        height: 109,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              dashPattern: [10, 10],
              color: Color(0XFF544B4B),
              child: GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ProfileGameImages.uploadImageIcon,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ensure your image is under 1MB in size',
                        style: onestFonts.copyWith(
                          fontSize: 10,
                          color: Color(0xFF827A7A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: -8,
              child: Container(
                color: Color(0xFF000502),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'Upload Facility Images',
                      style: onestFonts.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF827A7A),
                      ),
                    ),
                    SizedBox(width: 11),
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Color(0XFF827A7A),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

