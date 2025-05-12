import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/models/games_model.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_booking.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_card.dart';
import 'package:game_center_vendor/screens/game_center_vendor/tabs/facilities_tab.dart';
import 'package:game_center_vendor/screens/game_center_vendor/tabs/games_avilable_tab.dart';
import 'package:game_center_vendor/screens/game_center_vendor/tabs/specs_tab.dart';
import 'package:game_center_vendor/screens/game_center_vendor/tabs/tournament_tab.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';
import 'package:game_center_vendor/widgets/profile_edit_bottomsheet.dart';
import 'package:game_center_vendor/widgets/tab_chip.dart';
import 'package:game_center_vendor/widgets/team_textfield.dart';

class GameCenterDetail extends StatefulWidget {
  const GameCenterDetail({super.key});

  @override
  State<GameCenterDetail> createState() => _GameCenterDetailState();
}

class _GameCenterDetailState extends State<GameCenterDetail> {
  ValueNotifier<bool> atTopNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF0A0A0A),
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          atTopNotifier.value = innerBoxIsScrolled;
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://s3-alpha-sig.figma.com/img/8c57/bd22/45762d97a39deb2729eecde5c5a6aacd?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=j-MCdqw4kJqeZxAG~plj3MOAzHnVqrWJ0aqhbs6WVuoGNI1K66rt79fCb~FsxN1ivkven9-8zbEQphorYu72G-8gmWt~RkwXuun~D6SBkgGI3i-dRHAuZiNmLFHrRvgykFxzPOF8gUpvCx~xytjYWHoFVbjdxcIegFCcy7WG2HX~LwSPAybI4pkX~4IrRxB1unSWQRCNief5iukVAF1y6zl1toSVGoEpfhhILnGF~6oa96e9QMdvOflZFG4N1Ny090oEGjqpOoM9k27P~H4CfkqmDhggpWRp0RzOSN00CCDOXZspElfHHvceCaFYm3TGj2QFZT4LGPcMX~xkjAQ64Q__",
                        height: 500,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget:
                            (context, url, error) => Container(
                              color: Colors.grey,
                              height: 500,
                              width: double.infinity,
                              child: Icon(Icons.info_outline),
                            ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xCC0A0A0A),
                                Color(0x000A0A0A),
                                Color(0x330A0A0A),
                                Color(0xFF0A0A0A),
                              ],
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GameX Gaming Zone',
                              style: orbitronFonts.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  SvgIcons.location,
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Vastrapur, Ahmedabad',
                                  style: onestFonts.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    '₹199',
                                    style: onestFonts.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    '₹599',
                                    style: onestFonts.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                      color: Color(0xFFBCB8B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AuthButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameCenterBooking(),
                                  ),
                                );
                                // showModalBottomSheet(
                                //   backgroundColor: Colors.transparent,
                                //   context: context,
                                //   isScrollControlled: true,
                                //   shape: BeveledRectangleBorder(),
                                //   useSafeArea: true,
                                //   builder: (BuildContext context) {
                                //     return BookSelectGameSheet();
                                //   },
                                // ).then((v) {
                                //   if (v is! Games) return;
                                //   showModalBottomSheet(
                                //     backgroundColor: Colors.transparent,
                                //     context: context,
                                //     isScrollControlled: true,
                                //     shape: BeveledRectangleBorder(),
                                //     useSafeArea: true,
                                //     builder: (BuildContext context) {
                                //       return BookSheet();
                                //     },
                                //   );
                                // });
                              },
                              text: 'Bookings',
                              fontSize: 12,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF050101),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 0.2,
                                    color: Color(0xFF726C6C),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      GameCenterImgs.calendar,
                                      height: 24,
                                      width: 24,
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '10AM - 10PM',
                                          style: onestFonts.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 1),
                                        Text(
                                          "Today's Timings",
                                          style: onestFonts.copyWith(
                                            color: Color(0xFF898384),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: ScrollingAnimation(
                                list: [
                                  TempModel(
                                    title: "Today's Slots",
                                    icon: GameCenterImgs.package,
                                    count: '13',
                                  ),
                                  TempModel(
                                    title: "Live Events",
                                    icon: GameCenterImgs.live,
                                    count: '2',
                                  ),
                                  TempModel(
                                    title: "PC Games",
                                    icon: GameCenterImgs.computer,
                                    count: '14+',
                                  ),
                                  TempModel(
                                    title: "Tournament",
                                    icon: GameCenterImgs.sword,
                                    count: '5',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: DefaultTabController(
          length: 4,
          child: ValueListenableBuilder(
            valueListenable: atTopNotifier,
            builder: (context, notify, child) {
              return SafeArea(
                top: notify,
                child: Column(
                  children: [
                    TabBar(
                      physics: NeverScrollableScrollPhysics(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      indicator: ShapeDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x00622483), Color(0xFFAE40E9)],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      unselectedLabelStyle: onestFonts.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFBCB8B8),
                      ),
                      labelStyle: onestFonts.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFE8C0FD),
                      ),
                      tabs: [
                        Tab(text: '     Specs     '),
                        Tab(text: 'Games Available'),
                        Tab(text: '  Tournaments  '),
                        Tab(text: '  Facilities  '),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0x00FFFFFF),
                            Colors.white,
                            Color(0x00FFFFFF),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SpecsTab(),
                          GamesAvailableTab(),
                          TournamentsTab(),
                          FacilitiesTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BookSelectGameSheet extends StatefulWidget {
  const BookSelectGameSheet({super.key});

  @override
  State<BookSelectGameSheet> createState() => _BookSelectGameSheetState();
}

class _BookSelectGameSheetState extends State<BookSelectGameSheet> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          color: Color(0xFF151314),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0x00FFFFFF),
                      Colors.white,
                      Color(0x00FFFFFF),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Game and Format',
                      style: onestFonts.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 29),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TabChip(
                            icon: Image.asset(
                              GameCenterImgs.computer,
                              height: 24,
                              width: 24,
                              color:
                                  _index == 0
                                      ? Color(0xFFE8C0FD)
                                      : Color(0xFFBCB8B8),
                            ),
                            label: 'PC Games',
                            onTap: () {
                              _index = 0;
                              if (mounted) setState(() {});
                            },
                            selected: _index == 0,
                          ),
                          TabChip(
                            icon: SvgPicture.asset(
                              GameCenterImgs.gameController,
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                _index == 1
                                    ? Color(0xFFE8C0FD)
                                    : Color(0xFFBCB8B8),
                                BlendMode.srcIn,
                              ),
                            ),
                            label: 'Console Games',
                            onTap: () {
                              _index = 1;
                              if (mounted) setState(() {});
                            },
                            selected: _index == 1,
                          ),
                          TabChip(
                            icon: SvgPicture.asset(
                              GameCenterImgs.vrGlasses,
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                _index == 2
                                    ? Color(0xFFE8C0FD)
                                    : Color(0xFFBCB8B8),
                                BlendMode.srcIn,
                              ),
                            ),
                            label: 'AR/VR',
                            onTap: () {
                              _index = 2;
                              if (mounted) setState(() {});
                            },
                            selected: _index == 2,
                          ),
                          TabChip(
                            icon: Image.asset(
                              GameCenterImgs.simulator,
                              height: 24,
                              width: 24,
                              color:
                                  _index == 0
                                      ? Color(0xFFE8C0FD)
                                      : Color(0xFFBCB8B8),
                            ),
                            label: 'Simulator',
                            onTap: () {
                              _index = 3;
                              if (mounted) setState(() {});
                            },
                            selected: _index == 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    [
                      GamesCardList(
                        key: ValueKey(0),
                        onTap: (value) => Navigator.pop(context, value),
                      ),
                      GamesCardList(
                        key: ValueKey(1),
                        onTap: (value) => Navigator.pop(context, value),
                      ),
                      GamesCardList(
                        key: ValueKey(2),
                        onTap: (value) => Navigator.pop(context, value),
                      ),
                      GamesCardList(
                        key: ValueKey(3),
                        onTap: (value) => Navigator.pop(context, value),
                      ),
                    ][_index],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookSheet extends StatefulWidget {
  const BookSheet({super.key});

  @override
  State<BookSheet> createState() => _BookSheetState();
}

class _BookSheetState extends State<BookSheet> {
  final dateController = TextEditingController();
  final timeSlotController = TextEditingController();
  final availSlotController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          color: Color(0xFF151314),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0x00FFFFFF),
                      Colors.white,
                      Color(0x00FFFFFF),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Time & Slot',
                      style: onestFonts.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 29),
                    TeamTextfield(
                      readOnly: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(GameCenterImgs.calenderIcon),
                      ),
                      controller: dateController,
                      labelText: 'Select Date',
                      hintText: 'Select Date',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:
                              (context) => ProfileEditBottomSheet(
                                title: 'Select Date',
                                controller: dateController,
                                labelText: 'Select Date',
                                datePicker: true,
                              ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    TeamTextfield(
                      readOnly: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(GameCenterImgs.edit),
                      ),
                      controller: timeSlotController,
                      labelText: 'Select Time Slot',
                      hintText: 'Select Time Slot',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:
                              (context) => ProfileEditBottomSheet(
                                title: 'Select Time Slot',
                                controller: timeSlotController,
                                labelText: 'Select Time Slot',
                                city: true,
                                cityList: [
                                  '08:44 PM   TO   12:55 PM',
                                  '09:44 PM   TO   01:55 PM',
                                  '10:44 PM   TO   02:55 PM',
                                  '11:44 PM   TO   03:55 PM',
                                ],
                              ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    TeamTextfield(
                      readOnly: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(GameCenterImgs.edit),
                      ),
                      controller: availSlotController,
                      labelText: 'Select Available Slot',
                      hintText: 'Select Available Slot',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:
                              (context) => ProfileEditBottomSheet(
                                title: 'Select Available Slot',
                                controller: availSlotController,
                                labelText: 'Select Available Slot',
                                city: true,
                                cityList: [
                                  '90 Hz Display, 32 GB RAM',
                                  '60 Hz Display, 32 GB RAM',
                                  '120 Hz Display, 64 GB RAM',
                                ],
                              ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    TeamTextfield(
                      controller: noteController,
                      minLines: 4,
                      maxLines: null,
                      labelText: 'Enter Notes',
                      hintText: 'Enter Notes',
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0x00FFFFFF),
                      Colors.white,
                      Color(0x00FFFFFF),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(20),
                color: Color(0xFF151314),
                child: Row(
                  children: [
                    Text(
                      '₹199',
                      style: orbitronFonts.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Color(0xFFF0F0F0),
                      ),
                    ),
                    Spacer(),
                    AuthButton(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => GameCenterCheckout(),
                        //   ),
                        // );
                      },
                      text: 'Book Slot',
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollingAnimation extends StatefulWidget {
  const ScrollingAnimation({super.key, required this.list});
  final List<TempModel> list;
  @override
  State<ScrollingAnimation> createState() => _ScrollingAnimationState();
}

class _ScrollingAnimationState extends State<ScrollingAnimation> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _itemKey = GlobalKey();
  late Timer _timer;
  int _currentIndex = 0;
  double? _itemHeight;

  @override
  void initState() {
    super.initState();

    // Delay timer until height is measured
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureItemHeight();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _currentIndex++;

      if (_currentIndex >= widget.list.length) {
        _currentIndex = 0;
        _scrollController.jumpTo(0);
      } else {
        _scrollController.animateTo(
          _currentIndex * _itemHeight!,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _measureItemHeight() {
    final context = _itemKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      setState(() {
        _itemHeight = box.size.height;
        _startTimer();
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _itemHeight ?? 60, // Temporary height before measuring
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF050101),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.2, color: Color(0xFF726C6C)),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: List.generate(
            widget.list.length,
            (index) => Center(
              key: index == 0 ? _itemKey : null, // Only measure first item
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Image.asset(widget.list[index].icon, height: 24, width: 24),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list[index].count,
                          style: onestFonts.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          widget.list[index].title,
                          style: onestFonts.copyWith(
                            color: Color(0xFF898384),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TempModel {
  final String title;
  final String icon;
  final String count;

  TempModel({required this.title, required this.icon, required this.count});
}
