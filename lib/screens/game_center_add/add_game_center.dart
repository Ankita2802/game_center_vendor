import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/screens/game_center_add/time_slot_bottomsheet.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';
import 'package:game_center_vendor/widgets/team_textfield.dart';
import 'package:image_picker/image_picker.dart';

class AddEditGameScreen extends StatefulWidget {
  const AddEditGameScreen({super.key});
  @override
  State<AddEditGameScreen> createState() => _AddEditGameScreenState();
}

class _AddEditGameScreenState extends State<AddEditGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final gameNameController = TextEditingController();
  final timingController = TextEditingController();
  final addressController = TextEditingController();
  final nearByController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();

  bool loading = false;
  String? selectedGame;

  final teamTypes = ['Duo', 'Trio', 'Squad', 'Quintet(5)'];

  int _selectedType = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    gameNameController.dispose();

    super.dispose();
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
          'Game Center Details',
          style: onestFonts.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [SvgPicture.asset(SvgIcons.moreMenu), SizedBox(width: 10)],
      ),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 32,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileTextfield(
                          controller: gameNameController,
                          labelText: 'Game Center Name',
                          hintText: 'Game Center Name',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 24),
                        _uploadImg(),
                        const SizedBox(height: 24),
                        ProfileTextfield(
                          controller: timingController,
                          labelText: 'Timings',
                          hintText: 'Enter Timings',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return SelectTimingsScreen();
                              },
                            );
                          },
                          suffixIcon: Image.asset(
                            ProfileGameImages.editMessageIcon,
                            cacheHeight: 25,
                            cacheWidth: 25,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ProfileTextfield(
                          controller: addressController,
                          labelText: 'Address',
                          hintText: 'Enter Address',
                        ),
                        const SizedBox(height: 24),
                        ProfileTextfield(
                          controller: nearByController,
                          labelText: 'Nearby (optional) ',
                          hintText: 'Enter Nearby',
                        ),
                        const SizedBox(height: 24),
                        ProfileTextfield(
                          controller: areaController,
                          labelText: 'Area',
                          hintText: 'Enter Area',
                        ),
                        const SizedBox(height: 24),
                        ProfileTextfield(
                          controller: cityController,
                          labelText: 'City',
                          hintText: 'Enter City',
                          suffixIcon: Image.asset(
                            ProfileGameImages.editMessageIcon,
                            cacheHeight: 25,
                            cacheWidth: 25,
                          ),
                        ),
                        const SizedBox(height: 85),
                        AuthButton(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => TeamCreatedScreen(),
                            //   ),
                            // );
                            // if (!_formKey.currentState!.validate()) return;
                            // provider
                            //     .createTeam(teamNameController.text.trim(),
                            //         selectedGame!)
                            //     .then((value) {
                            //   if (!value) return;
                            //   Navigator.pop(context, true);
                            //   // Navigator.push(
                            //   //   context,
                            //   //   MaterialPageRoute(
                            //   //     builder: (context) => const YourTeamScreen(),
                            //   //   ),
                            //   // );
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
                        'Upload Game Center Images',
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

  Widget _radioField(int value, String label) {
    return GestureDetector(
      onTap: () {
        _selectedType = value;
        setState(() {});
      },
      child: Row(
        children: [
          _selectedType == value
              ? SvgPicture.asset(SvgIcons.radioFilledCircle)
              : SvgPicture.asset(SvgIcons.radioEmptyCircle),
          SizedBox(width: 3.5),
          Text(
            label,
            style: onestFonts.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (value < teamTypes.length - 1) SizedBox(width: 29),
        ],
      ),
    );
  }
}
