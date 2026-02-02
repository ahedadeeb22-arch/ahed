import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart'; // إضافة مكتبة GetX

void main() {
  runApp(const MyApp());
}

/* ===========================
  إدارة الحالة (Controller)
=========================== */
class AppController extends GetxController {
  // متغير لمتابعة الصفحة الحالية في BottomNavigationBar
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}

/* ===========================
  APP ROOT
=========================== */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // تغيير MaterialApp إلى GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Facebook UI Clone',
      home: const SplashScreen(),
    );
  }
}

/* ===========================
  SPLASH SCREEN
=========================== */
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      // استخدام GetX للانتقال بدلاً من Navigator التقليدي
      Get.off(() => const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.facebook, size: 90, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Facebook ',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===========================
  LOGIN PAGE
=========================== */
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.facebook, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'تسجيل الدخول',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // استخدام GetX للانتقال لصفحة الـ Home
                  Get.offAll(() => const HomePage());
                },
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===========================
  HOME PAGE + BOTTOM NAV
=========================== */
class HomePage extends StatelessWidget {
  // تحويلها لـ StatelessWidget لأن GetX يدير الحالة
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء الكنترولر
    final AppController controller = Get.put(AppController());

    final pages = const [
      HomeContent(),
      Center(child: Text('الأصدقاء', style: TextStyle(fontSize: 22))),
      Center(child: Text('Marketplace', style: TextStyle(fontSize: 22))),
      Center(child: Text('الملف الشخصي', style: TextStyle(fontSize: 22))),
      MenuPage(),
    ];

    return Scaffold(
      // استخدام Obx لمراقبة التغيير في الصفحة
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.changePage(i),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'الأصدقاء',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Marketplace',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'القائمة'),
          ],
        ),
      ),
    );
  }
}

/* ===========================
  HOME CONTENT
=========================== */
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'facebook',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ),
          ),
          postCard(),
          postCard(),
        ],
      ),
    );
  }

  Widget postCard() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: const [
          ListTile(
            leading: CircleAvatar(),
            title: Text('احمد خالد'),
            subtitle: Text('منذ ساعة'),
          ),
          Padding(padding: EdgeInsets.all(12), child: Text('العنوان')),
        ],
      ),
    );
  }
}

/* ===========================
  MENU PAGE
=========================== */
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القائمة')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
              const Expanded(child: Text("القائمة", textAlign: TextAlign.end)),
            ],
          ),
          here(),
          const SizedBox(height: 10),
          const Text("اختصاراتك", textAlign: TextAlign.end),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              continar_icon_and_title("البنك", Icons.park_rounded),
              const SizedBox(width: 5),
              continar_icon_and_title("الشتـــــاء", Icons.ac_unit_rounded),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  expanded("الذكريات ", Icons.history),
                  const SizedBox(width: 10),
                  expanded("العناصر المحفوظة", Icons.bookmark),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  expanded(" المجموعات", Icons.groups),
                  const SizedBox(width: 10),
                  expanded("ريلز", Icons.video_library),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  expanded("Marketplace", Icons.storefront),
                  const SizedBox(width: 10),
                  expanded("الاصدقاء", Icons.people),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  expanded("المناسبات", Icons.event),
                  const SizedBox(width: 10),
                  expanded("الاخبار", Icons.newspaper),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ===========================
  دوال مساعدة (Helper Widgets)
=========================== */
Expanded expanded(String title, IconData icon) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: const Color.fromARGB(255, 114, 109, 100),
        ),
        color: const Color.fromARGB(255, 248, 247, 246),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      alignment: Alignment.centerRight,
      child: Column(children: [Icon(icon), Text(title)]),
    ),
  );
}

Container continar_icon_and_title(String title, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: Colors.black54, width: 1),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      children: [
        Icon(icon, size: 40),
        Text(title, style: const TextStyle(fontSize: 20)),
      ],
    ),
  );
}

Container here() {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 188, 184, 183),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.keyboard_arrow_down),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("عاهد اديب عبدالله ابواصبع"),
                const SizedBox(width: 8),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/SS.JPG"),
                  radius: 30,
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text("انشاء صفحه علئ فيسبوك"),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 25,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const MenuItem(this.icon, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
