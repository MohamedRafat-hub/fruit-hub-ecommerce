import 'package:flutter/material.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/shopping_button.dart';
import 'package:svg_image_provider/svg_image_provider.dart' show SvgImageProvider;

class HomeFeaturedItem extends StatelessWidget {
  const HomeFeaturedItem({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: AspectRatio(
        aspectRatio: 342 / 158,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                bottom: 0,
                top: 0,
                right: MediaQuery.sizeOf(context).width * .4,
                child: Image.asset('assets/images/watermelon.png',
                    fit: BoxFit.fill)),
            Container(
              width: MediaQuery.sizeOf(context).width * .5,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: SvgImageProvider(
                    'assets/images/featured_item_background.svg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.80,
                    child: Text(
                      'عروض العيد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        height: 1.60,
                      ),
                    ),
                  ),
                  Text(
                    'خصم 25%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ShoppingButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}