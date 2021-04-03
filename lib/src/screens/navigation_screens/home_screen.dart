import 'package:flutter/material.dart';
import 'package:realcallerapp/models/call_log.dart';

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
    // TODO: implement initState
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
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff1f1f1),
                      offset: Offset(0, 3),
                      blurRadius: 5)
                ]),
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
                        color: Color(0xff0d0d0d),
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
                        border: InputBorder.none, hintText: "Search"),
                    style: TextStyle(fontSize: 16, color: Color(0xff0d0d0d)),
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
                      color: Color(0xff0d0d0d),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
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
                  color: Color(0xff00ca78)),
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
          children: navCallLogList.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  itemCount: item.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      NetworkImage(item[index].profileImageUrl),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  children: [
                                    Text(item[index].username),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(item[index].logType)
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.phone,
                              size: 24,
                              color: Color(0xffa1a1a1),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }).toList(),
        )),
      ],
    );
  }
}
