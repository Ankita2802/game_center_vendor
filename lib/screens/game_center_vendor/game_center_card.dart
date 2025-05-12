import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:game_center_vendor/models/games_model.dart';
import 'package:game_center_vendor/provider/games_provider.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:provider/provider.dart';

class GamesCardList extends StatefulWidget {
  const GamesCardList({super.key, this.onTap});
  final ValueChanged<Games>? onTap;
  @override
  State<GamesCardList> createState() => _GamesCardListState();
}

class _GamesCardListState extends State<GamesCardList> {
  late GamesListProvider provider;
  bool loading = true;
  List<Games> games = [];
  @override
  void initState() {
    super.initState();
    provider = Provider.of<GamesListProvider>(context, listen: false);
    provider.getGamesList(1, limit: 100).then((value) {
      games = value;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : games.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 14),
              Image.asset(
                HomeImages.trophy,
                height: 100,
                color: Color(0xFF0A0A0A),
                colorBlendMode: BlendMode.color,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 14),
              Text(
                'No Games Found',
                style: onestFonts.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 14),
              Text(
                "There are no games available",
                textAlign: TextAlign.center,
                style: onestFonts.copyWith(
                  fontSize: 14,
                  color: Color(0xFFBCB8B8),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        )
        : MasonryGridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 20),
          itemCount: games.length,
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 7,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: index == 1 ? 20 : 5),
              child: GestureDetector(
                onTap: () {
                  if (widget.onTap != null) widget.onTap!(games[index]);
                },
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            games[index].profile ?? games[index].logo ?? "",
                        fit: BoxFit.cover,
                        height: 194,
                        width: double.infinity,
                        errorWidget:
                            (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}
