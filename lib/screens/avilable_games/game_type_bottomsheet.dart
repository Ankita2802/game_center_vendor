import 'package:flutter/material.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';

class GameTypeBottomsheet extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final List<String>? gamesType;
  final String labelText;
  const GameTypeBottomsheet({
    super.key,
    required this.title,
    this.controller,
    this.gamesType,
    required this.labelText,
  });

  @override
  State<GameTypeBottomsheet> createState() => _GameTypeBottomsheetState();
}

class _GameTypeBottomsheetState extends State<GameTypeBottomsheet> {
  int selectedIndex = 0; // Set initial selected index

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0XFF151314)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top gradient line
          Container(
            height: 1,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0XFF151314), Colors.white, Color(0XFF151314)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ProfileTextfield(
              controller: widget.controller!,
              labelText: widget.labelText,
              isLabel: false,
              onTap: () {},
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.120),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 180,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 60,
                  diameterRatio: 1.5,
                  perspective: 0.005,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                      widget.controller?.text = widget.gamesType?[index] ?? '';
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.gamesType?.length ?? 0,
                    builder: (context, index) {
                      if (index < 0 || index >= widget.gamesType!.length) {
                        return null;
                      }

                      final games = widget.gamesType![index];
                      final isSelected = index == selectedIndex;

                      return Center(
                        child: Text(
                          games,
                          style: poppinsFonts.copyWith(
                            fontSize: 20,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w400,
                            color:
                                isSelected ? Color(0xFF6C5CE7) : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Top divider
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.white, blurRadius: 8)],
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF151314),
                        Colors.white,
                        Color(0xFF151314),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),

              // Bottom divider
              Positioned(
                bottom: 120,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.white, blurRadius: 8)],
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF151314),
                        Colors.white,
                        Color(0xFF151314),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.120),
          // Confirm button
          Container(
            height: 1,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0XFF151314), Colors.white, Color(0XFF151314)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: AuthButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Confirm',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
