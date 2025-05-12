import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_details_screen.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';

class GameCenterCard extends StatelessWidget {
  const GameCenterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.25),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Color(0x00999999), Colors.white],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF151314),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 260,
          width: 266,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      GameCenterImgs.addGameCenterImg,
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // CachedNetworkImage(
                    //   imageUrl:
                    //       "https://s3-alpha-sig.figma.com/img/8c57/bd22/45762d97a39deb2729eecde5c5a6aacd?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=j-MCdqw4kJqeZxAG~plj3MOAzHnVqrWJ0aqhbs6WVuoGNI1K66rt79fCb~FsxN1ivkven9-8zbEQphorYu72G-8gmWt~RkwXuun~D6SBkgGI3i-dRHAuZiNmLFHrRvgykFxzPOF8gUpvCx~xytjYWHoFVbjdxcIegFCcy7WG2HX~LwSPAybI4pkX~4IrRxB1unSWQRCNief5iukVAF1y6zl1toSVGoEpfhhILnGF~6oa96e9QMdvOflZFG4N1Ny090oEGjqpOoM9k27P~H4CfkqmDhggpWRp0RzOSN00CCDOXZspElfHHvceCaFYm3TGj2QFZT4LGPcMX~xkjAQ64Q__",
                    //   height: 190,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    //   errorWidget:
                    //       (context, url, error) => Container(
                    //         color: Colors.grey,
                    //         width: double.infinity,
                    //         height: 190,
                    //         child: Icon(Icons.info_outline),
                    //       ),
                    // ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0x00999999), Color(0x99FFFFFF)],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      bottom: 10,
                      child: Column(
                        children: [
                          Text(
                            'GameX Gaming Zone',
                            style: onestFonts.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(SvgIcons.location),
                              SizedBox(width: 6),
                              Text(
                                'Vastrapur, Ahmedabad',
                                style: onestFonts.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Color(0x0D000000),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '₹199',
                              style: onestFonts.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              '₹599',
                              style: onestFonts.copyWith(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Color(0xFF726C6C),
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
                              builder: (context) => GameCenterDetail(),
                            ),
                          );
                        },
                        arrow: true,
                        text: 'Show Details',
                        fontSize: 12,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
