
import 'package:flutter/material.dart';
import 'package:fruit_hub/core/widgets/custom_material_button.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:gap/gap.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:buildAppBar(title: 'حسابي'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          // الجزء الخاص بالبروفايل
          const UserData(),
          const SizedBox(height: 30),

          // قسم عام
          const Text('عام', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildListTile(Icons.person_outline, 'الملف الشخصي', hasNavigation: true),
          _buildListTile(Icons.inventory_2_outlined, 'طلباتي', hasNavigation: true),
          _buildListTile(Icons.account_balance_wallet_outlined, 'المدفوعات', hasNavigation: true),
          _buildListTile(Icons.favorite_border, 'المفضلة', hasNavigation: true),
          _buildSwitchTile(Icons.notifications_none, 'الاشعارات', true),
          _buildListTile(Icons.language, 'اللغة', trailingText: 'العربية', hasNavigation: true),
          _buildSwitchTile(Icons.edit_road_outlined, 'الوضع', false), // أيقونة تقريبية للوضع

          const SizedBox(height: 20),

          // قسم المساعدة
          const Text('المساعده', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildListTile(Icons.info_outline, 'من نحن', hasNavigation: true),

          const SizedBox(height: 30),

         CustomMaterialButton(buttonName: 'تسجيل الخروج', onPressed: () {},
         ),
          Gap(50),
        ],
      ),
    );
  }

  // Widget مساعد للسطور العادية
  Widget _buildListTile(IconData icon, String title, {bool hasNavigation = false, String? trailingText}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null) Text(trailingText, style: const TextStyle(color: Colors.grey)),
          if (hasNavigation) const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      trailing: Switch(
        value: value,
        onChanged: (val) {},
        activeColor: Colors.green,
      ),
    );
  }
}

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // حط صورتك هنا
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt_outlined, size: 18, color: Colors.green[700]),
            ),
          ],
        ),
        Gap(10),
        Column(
          children: [
            const Text(
              'أحمد ياسر',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'mail@mail.com',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}
