import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';
import 'package:intl/intl.dart';

class ProfileEditBottomSheet extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final String labelText;
  final List<int>? years;
  final List<int>? months;
  final bool? experience;
  final bool? datePicker;
  final bool? country;
  final bool? state;
  final bool? city;
  final List? countryList;
  final List? stateList;
  final List? cityList;

  const ProfileEditBottomSheet({
    super.key,
    required this.title,
    required this.controller,
    required this.labelText,
    this.years,
    this.months,
    this.experience = false,
    this.datePicker = false,
    this.country = false,
    this.state = false,
    this.city = false,
    this.countryList,
    this.stateList,
    this.cityList,
  });

  @override
  State<ProfileEditBottomSheet> createState() => _ProfileEditBottomSheetState();
}

class _ProfileEditBottomSheetState extends State<ProfileEditBottomSheet> {
  late int selectedYear;
  late int selectedMonth;
  late List<int> filteredMonths;
  DateTime _selectedDate = DateTime(2004, 5, 2);
  @override
  void initState() {
    super.initState();
    selectedYear = widget.years?.first ?? 0;
    _updateMonths();

    // Restore previous selection if available
    if (widget.controller?.text.isNotEmpty == true) {
      List<String> splitText = widget.controller!.text.split(" ");
      if (splitText.length >= 4) {
        selectedYear = int.tryParse(splitText[0]) ?? widget.years?.first ?? 0;
        selectedMonth = int.tryParse(splitText[2]) ?? filteredMonths.first;
      }
    }
    if (widget.countryList != null && widget.countryList!.isNotEmpty) {
      if (widget.controller?.text.isEmpty ?? true) {
        widget.controller?.text = widget.countryList![0].country ?? '';
        selectedIndex = 0;
      } else {
        final index = widget.countryList!.indexWhere(
          (element) => element.country == widget.controller?.text,
        );
        if (index != -1) {
          selectedIndex = index;
        }
      }
    }
  }

  void _updateMonths() {
    setState(() {
      if (selectedYear == 10) {
        filteredMonths = List.generate(
          7,
          (index) => index + 1,
        ); // 1 to 7 months
      } else {
        filteredMonths = List.generate(
          12,
          (index) => index + 1,
        ); // 1 to 12 months
      }
      selectedMonth = filteredMonths.first;
    });
  }

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
          // Experience text field with rounded border
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ProfileTextfield(
              controller: widget.controller!,
              labelText: widget.labelText,
              onTap: () {},
            ),
          ),
          const SizedBox(height: 77),
          //Picker Date
          if (widget.datePicker!)
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      CupertinoTheme(
                        data: CupertinoThemeData(
                          brightness: Brightness.dark,
                          primaryColor: CupertinoColors.systemBackground
                              .resolveFrom(context),
                          textTheme: const CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        child: CupertinoDatePicker(
                          backgroundColor: Colors.transparent,
                          itemExtent: 60,
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: _selectedDate,
                          minimumYear: 2000,
                          maximumYear: 2025,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              _selectedDate = newDate;
                              widget.controller?.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(newDate);
                            });
                          },
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                spreadRadius: 0.2,
                                blurRadius: 10,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color(0XFF151314),
                                Colors.white,
                                Color(0XFF151314),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color(0XFF151314),
                                Colors.white,
                                Color(0XFF151314),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          // Picker area
          if (widget.experience!)
            Column(
              children: [
                SizedBox(
                  height: 180, // Increased height to show more items
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Year Picker
                      Expanded(child: _buildPicker(widget.years ?? [], true)),
                      // Month Picker
                      Expanded(child: _buildPicker(filteredMonths, false)),
                    ],
                  ),
                ),
              ],
            ),
          if (widget.country!)
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 60,
                    diameterRatio: 2.5,
                    perspective: 0.005,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                        widget.controller?.text =
                            widget.countryList?[index].country ?? '';
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: widget.countryList?.length ?? 0,
                      builder: (context, index) {
                        if (index < 0 || index >= widget.countryList!.length) {
                          return null;
                        }

                        final country = widget.countryList![index];
                        final isSelected = index == selectedIndex;

                        return Center(
                          child: Text(
                            country.country ?? '',
                            style: poppinsFonts.copyWith(
                              fontSize: 20,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w400,
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
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 8),
                      ],
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
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 8),
                      ],
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

          if (widget.state!)
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 60,
                    diameterRatio: 2.5,
                    perspective: 0.005,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                        widget.controller?.text =
                            widget.stateList?[index] ?? '';
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: widget.stateList?.length ?? 0,
                      builder: (context, index) {
                        if (index < 0 || index >= widget.stateList!.length) {
                          return null;
                        }
                        bool isSelected = index == selectedIndex;

                        return Center(
                          child: Text(
                            widget.stateList?[index] ?? '',
                            style: poppinsFonts.copyWith(
                              fontSize: 20,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w400,
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
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 8),
                      ],
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
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 8),
                      ],
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
          if (widget.city!)
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 60,
                    diameterRatio: 2.5,
                    perspective: 0.005,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                        widget.controller?.text = widget.cityList?[index] ?? '';
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: widget.cityList?.length ?? 0,
                      builder: (context, index) {
                        if (index < 0 || index >= widget.cityList!.length) {
                          return null;
                        }
                        bool isSelected = index == selectedIndex;

                        return Center(
                          child: Text(
                            widget.cityList?[index] ?? '',
                            style: poppinsFonts.copyWith(
                              fontSize: 20,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w400,
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
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 8),
                      ],
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
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 8),
                      ],
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

          const SizedBox(height: 117),
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
          const SizedBox(height: 70),
        ],
      ),
    );
  }

  Widget _buildPicker(List<int> list, bool isYear) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Center selected item highlight
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(color: Colors.grey.shade700, width: 1),
              bottom: BorderSide(color: Colors.grey.shade700, width: 1),
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 60,
            diameterRatio: 2.5, // Adjusted to show more items
            perspective:
                0.005, // Reduced perspective to make items more visible
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                if (isYear) {
                  selectedYear = list[index];
                  _updateMonths();
                } else {
                  selectedMonth = list[index];
                }
                final newValue = "$selectedYear Years $selectedMonth Months";

                // ✅ Only update controller if value is different
                if (widget.controller?.text != newValue) {
                  widget.controller?.text = newValue;
                }
              });
            },
            // Add padding to ensure we can see enough items
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index >= list.length) {
                  return Container();
                }

                int value = list[index];
                bool isSelected =
                    (isYear ? selectedYear : selectedMonth) == value;

                return Center(
                  child: Text(
                    "$value ${isYear ? "Years" : "Months"}",
                    style: poppinsFonts.copyWith(
                      fontSize: 20,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w300,
                      color:
                          isSelected
                              ? Colors.white
                              : Color(0xFF6C5CE7).withValues(
                                alpha: 0.7,
                              ), // Purple color like in the image
                    ),
                  ),
                );
              },
              childCount: list.length,
            ),
          ),
        ),
      ],
    );
  }
}
