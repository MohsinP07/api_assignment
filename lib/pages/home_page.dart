import 'package:api_assignment/pages/tabs/fav_tab.dart';
import 'package:api_assignment/pages/tabs/news_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  bool firstLoad = true;
  var tabs = [
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Tab(
        icon: Icon(Icons.list),
        text: 'News',
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Tab(
        icon: Icon(
          FontAwesomeIcons.heart,
          color: Colors.red.shade300,
        ),
        text: 'Favourite',
      ),
    ),
  ];

  List<Widget> screens = const [
    NewsTab(),
    FavsTab(),
  ];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (firstLoad) {
      _tabController = TabController(length: tabs.length, vsync: this);

      firstLoad = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TabBar(
                  labelStyle: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  controller: _tabController,
                  labelColor: Colors.blue.shade500,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabs.map((tab) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: tab,
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              Container(
                width: double.infinity,
                height: deviceSize.height * 0.91,
                child:
                    TabBarView(controller: _tabController, children: screens),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
