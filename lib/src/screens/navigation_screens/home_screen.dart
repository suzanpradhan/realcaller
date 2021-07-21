import 'package:flutter/material.dart';
import 'package:realcallerapp/src/screens/home_tab_screens.dart/all_call_log_screen.dart';
import 'package:realcallerapp/src/screens/home_tab_screens.dart/business_call_log_screen.dart';
import 'package:realcallerapp/src/screens/home_tab_screens.dart/spam_call_log_screen.dart';
import 'package:realcallerapp/src/screens/home_tab_screens.dart/starred_call_log_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _homeNavigationTabController;

  List<Icon> _tabs = <Icon>[
    Icon(Icons.people),
    Icon(Icons.star),
    Icon(Icons.work),
    Icon(Icons.privacy_tip),
  ];

  @override
  void initState() {
    super.initState();
    _homeNavigationTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Icon(
                        Icons.menu,
                        size: 20,
                        color: IconTheme.of(context).color,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.caption!.color)),
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: TabBar(
              controller: _homeNavigationTabController,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              unselectedLabelColor: Color(0xffbfbfbf),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.purpleLightFaded),
              // indicatorSize: TabBarIndicatorSize.label,
              physics: BouncingScrollPhysics(),
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              tabs: _tabs.map((element) => element).toList()),
        ),
        Expanded(
            child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _homeNavigationTabController,
                children: [
              AllCallLogScreen(),
              StarredCallLog(),
              BusinessCallLog(),
              SpamCallLog()
            ])),
      ],
    );
  }
}
