import 'package:flutter/material.dart';
import 'package:game_center_vendor/screens/game_center_add/custom_switch.dart';
import 'package:game_center_vendor/themes/app_font.dart';

class TimeSlotBottomSheet extends StatelessWidget {
  final Function(TimeOfDay from, TimeOfDay to) onTimeSelected;

  const TimeSlotBottomSheet({super.key, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    TimeOfDay? fromTime;
    TimeOfDay? toTime;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Time Slot',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              fromTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
            },
            child: const Text('Select Start Time'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              toTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
            },
            child: const Text('Select End Time'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (fromTime != null && toTime != null) {
                onTimeSelected(fromTime!, toTime!);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add Slot'),
          ),
        ],
      ),
    );
  }
}

class SelectTimingsScreen extends StatefulWidget {
  const SelectTimingsScreen({super.key});

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
      context: context,
      builder: (context) {
        return TimeSlotBottomSheet(
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
        children: [
          ListTile(
            leading: Icon(Icons.keyboard_arrow_down),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Slot ${i + 1}: ${timeSlots[day]![i]['from']} to ${timeSlots[day]![i]['to']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => _showAddTimeSlotBottomSheet(day),
                child: const Text('+ Add Time Slot'),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Confirm button logic
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Confirm'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
