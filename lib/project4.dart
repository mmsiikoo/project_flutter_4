import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//клас кольорів
abstract class AppColors {
  static const Color primaryColor = Color(0xFF673AB7); //основний фіолетовий
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color appBarBackground = Color(0xFFD1C4E9); //світлий фон шапки
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primaryColor, //основний фіолетовий
      ),
      home: const MainScreen(),
    );
  }
}

//головний екран
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0; //змінна для перемикання вкладок

  //список сторінок (Hero тільки на першій)
  final List<Widget> _pages = [
    const HomeHeroTab(),
    const Center(child: Text("Повідомлення")),
    const Center(child: Text("Профіль")),
  ];

  void onTabChange(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //завдання 1: віджет
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitten Profile"),
        backgroundColor: AppColors.appBarBackground,
      ),

      //завдання 1: бокове меню
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryColor),
              child: Text(
                "Меню котика",
                style: TextStyle(color: AppColors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Головна"),
              onTap: () {
                Navigator.pop(context); //закрити меню
                onTabChange(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Налаштування"),
              onTap: () {
                Navigator.pop(context); //закрити меню
              },
            ),
          ],
        ),
      ),

      //основа програми (змінюється при натисканні кнопок внизу)
      body: SafeArea(child: _pages[_currentTab]),

      //завдання 1: кнопка дії
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Кнопку натиснуто!");
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: AppColors.white),
      ),

      //завдання 1-2: навігація + анімація
      //вбудована анімація: при кліку збільшується іконка і з'являється текст
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: onTabChange,
        selectedItemColor: AppColors.primaryColor, //активний колір
        unselectedItemColor: AppColors.grey, //неактивний колір
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Головна'),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Повідомлення',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профіль'),
        ],
      ),
    );
  }
}

//hero віджет
class HomeHeroTab extends StatelessWidget {
  const HomeHeroTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Тапни на котика"),
          const SizedBox(height: 20),

          //завдання 3: анімований hero віджет
          Material(
            color: Colors.transparent,
            //для кліку
            child: InkWell(
              onTap: () {
                //перехід на екран деталей
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailScreen()),
                );
              },
              customBorder: const CircleBorder(),
              child: Hero(
                tag: 'my-cat-tag', //тег зв'язує дві картинки
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://static.vecteezy.com/system/resources/thumbnails/051/778/475/small/an-orange-kitten-sitting-on-a-blanket-photo.jpeg',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//другий екран для hero
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Деталі")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //кінець анімації hero
            Hero(
              tag: 'my-cat-tag', //тег співпадає
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/051/778/475/small/an-orange-kitten-sitting-on-a-blanket-photo.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Моє ім'я Пухнастик!",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "У мене м'якенька руда шубка.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
