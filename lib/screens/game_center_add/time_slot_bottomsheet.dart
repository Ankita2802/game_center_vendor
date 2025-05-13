import 'package:flutter/material.dart';
import 'package:game_center_vendor/screens/game_center_add/custom_switch.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/profile_textfield.dart';

class TimeSlotBottomSheet extends StatefulWidget {
  final TextEditingController timeSlotController;
  final Function(TimeOfDay from, TimeOfDay to) onTimeSelected;

  const TimeSlotBottomSheet({
    super.key,
    required this.onTimeSelected,
    required this.timeSlotController,
  });

  @override
  State<TimeSlotBottomSheet> createState() => _TimeSlotBottomSheetState();
}

class _TimeSlotBottomSheetState extends State<TimeSlotBottomSheet> {
  int startHour = 8, startMinute = 44;
  int endHour = 23, endMinute = 55;
  final List<int> hours = List.generate(24, (index) => index); // 0-23
  final List<int> minutes = List.generate(60, (index) => index); // 0-59
  int selectedIndex = 0;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;

  @override
  void initState() {
    super.initState();
    _updateTimeSlotController(); // Set initial time
  }

  void _updateTimeSlotController() {
    String formatTime(int hour, int minute) {
      final hour12 = hour % 12 == 0 ? 12 : hour % 12;
      final period = hour >= 12 ? 'PM' : 'AM';
      final minuteStr = minute.toString().padLeft(2, '0');
      return '$hour12:$minuteStr $period';
    }

    _fromTime = TimeOfDay(hour: startHour, minute: startMinute);
    _toTime = TimeOfDay(hour: endHour, minute: endMinute);

    final fromFormatted = formatTime(startHour, startMinute);
    final toFormatted = formatTime(endHour, endMinute);
    widget.timeSlotController.text = '$fromFormatted TO $toFormatted';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0XFF000502)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Add Time Slot',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ProfileTextfield(
                controller: widget.timeSlotController,
                hintText: 'Enter Time Slot',
                labelText: 'Select Time Slot',
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimePicker(startHour, startMinute, selectedIndex, (
                  hour,
                  minute,
                ) {
                  setState(() {
                    startHour = hour;
                    startMinute = minute;
                    _updateTimeSlotController();
                  });
                }),
                const Text(
                  ' TO ',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                _buildTimePicker(endHour, endMinute, selectedIndex, (
                  hour,
                  minute,
                ) {
                  setState(() {
                    endHour = hour;
                    endMinute = minute;
                    _updateTimeSlotController();
                  });
                }),
              ],
            ),
            SizedBox(height: 150),
            Container(
              color: Color(0XFF151314),
              child: Column(
                children: [
                  // Top gradient line
                  Container(
                    height: 1,
                    width: double.infinity,
                    decoration: const BoxDecoration(
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AuthButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          onTap: () {
                            if (_fromTime != null && _toTime != null) {
                              widget.onTimeSelected(_fromTime!, _toTime!);
                              Navigator.pop(context); // Close the bottom sheet
                            }
                          },

                          text: 'Confirm',
                          arrow: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(
    int selectedHour,
    int selectedMinute,
    int selectedIndex,
    Function(int hour, int minute) onTimeSelected,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildWheelPicker(
          selectedHour,
          hours,
          selectedIndex,
          (selectedValue) => onTimeSelected(selectedValue, selectedMinute),
        ),
        const Text(':', style: TextStyle(color: Colors.white, fontSize: 40)),
        _buildWheelPicker(
          selectedMinute,
          minutes,
          selectedIndex,
          (selectedValue) => onTimeSelected(selectedHour, selectedValue),
        ),
      ],
    );
  }

  Widget _buildWheelPicker(
    int selectedValue,
    List<int> values,
    int selectedIndex,
    Function(int selectedValue) onValueChanged,
  ) {
    return SizedBox(
      width: 80,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListWheelScrollView.useDelegate(
            itemExtent: 60,
            diameterRatio: 1.5,
            perspective: 0.005,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onValueChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              // builder: (_, index) {
              //   final value = values[index % values.length];
              childCount: values.length,
              builder: (context, index) {
                if (index < 0 || index >= values.length) {
                  return null;
                }

                final time = values[index];
                final isSelected = index == selectedIndex;

                return Center(
                  child: Text(
                    time.toString(),
                    style: poppinsFonts.copyWith(
                      fontSize: 20,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w400,
                      color: isSelected ? Color(0xFF6C5CE7) : Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
          // Top divider
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.white, blurRadius: 8)],
                gradient: LinearGradient(
                  colors: [Color(0xFF151314), Colors.white, Color(0xFF151314)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
          // Bottom divider
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.white, blurRadius: 8)],
                gradient: LinearGradient(
                  colors: [Color(0xFF151314), Colors.white, Color(0xFF151314)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectTimingsScreen extends StatefulWidget {
  final TextEditingController timeController;
  const SelectTimingsScreen({super.key, required this.timeController});

  @override
  State<SelectTimingsScreen> createState() => _SelectTimingsScreenState();
}

class _SelectTimingsScreenState extends State<SelectTimingsScreen> {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final Map<String, bool> isOpen = {};
  final Map<String, List<Map<String, String>>> timeSlots = {};
  final Map<String, bool> isExpanded = {};

  @override
  void initState() {
    super.initState();
    for (var day in days) {
      isOpen[day] = true;
      isExpanded[day] = false;
      timeSlots[day] = [];
    }
  }

  void _showAddTimeSlotBottomSheet(String day) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TimeSlotBottomSheet(
          timeSlotController: widget.timeController,
          onTimeSelected: (from, to) {
            setState(() {
              timeSlots[day]?.add({
                'from': from.format(context),
                'to': to.format(context),
              });
            });
          },
        );
      },
    );
  }

  Widget buildDayCard(String day) {
    return Card(
      color: Color(0XFF151518),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(
              isExpanded[day]!
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            title: Text(
              day,
              style: onestFonts.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isOpen[day]! ? 'Open' : 'Close',
                  style: onestFonts.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 20),
                CustomSwitch(
                  value: isOpen[day]!,
                  onChanged: (value) {
                    setState(() {
                      isOpen[day] = value;
                      if (!value) timeSlots[day]?.clear();
                    });
                  },
                ),
              ],
            ),
            onTap: () {
              if (isOpen[day]!) {
                setState(() {
                  isExpanded[day] = !isExpanded[day]!;
                });
              }
            },
          ),
          if (isOpen[day]! && isExpanded[day]!) ...[
            for (int i = 0; i < timeSlots[day]!.length; i++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slot ${i + 1}',
                      style: onestFonts.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF575757),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${timeSlots[day]![i]['from']} to ${timeSlots[day]![i]['to']}",
                      style: onestFonts.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => _showAddTimeSlotBottomSheet(day),
                child: Text(
                  '+  Add Time Slot',
                  style: onestFonts.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0XFF000502)),
      child: SingleChildScrollView(
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
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Timings',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                ...days.map(buildDayCard).toList(),
                const SizedBox(height: 34),
                Container(
                  color: Color(0XFF151314),
                  child: Column(
                    children: [
                      // Top gradient line
                      Container(
                        height: 1,
                        width: double.infinity,
                        decoration: const BoxDecoration(
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: AuthButton(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              text: 'Confirm',
                              arrow: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
