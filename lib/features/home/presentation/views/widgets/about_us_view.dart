import 'package:flutter/material.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const routeName = 'About Us View';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'من نحن', context: context, hasLeading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 12),
        child: AboutUsViewBody(),
      ),
    );
  }
}

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Text(
            'تطبيق فروت هاب هو وجهتك المثالية لشراء الفواكه الطازجة واللذيذة عبر الإنترنت. نحن نؤمن بأهمية تقديم منتجات عالية الجودة وخدمة عملاء ممتازة، مما يجعل تجربة التسوق الخاصة بك سهلة وممتعة. في فروت هاب، نلتزم بتوفير مجموعة واسعة من الفواكه الطازجة والموسمية، مع ضمان التوصيل السريع والموثوق به إلى باب منزلك. هدفنا هو أن نكون الخيار الأول لكل من يبحث عن فواكه طازجة ولذيذة، مع توفير تجربة تسوق مريحة وآمنة عبر الإنترنت. شكراً لاختيارك فروت هاب، ونحن نتطلع إلى خدمتك وتلبية احتياجاتك من الفواكه الطازجة!',
            style: TextStyle(
              color: const Color(0xFF0C0D0D) /* Grayscale-950 */,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              height: 1.40,
            )),
      ),
    );
  }
}
