import 'dart:ui';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MySliverAppBarDelegate.dart';

class NestedScrollViewDemo extends StatefulWidget {
  const NestedScrollViewDemo({super.key});

  @override
  State<NestedScrollViewDemo> createState() => _DemoState();
}

class _DemoState extends State<NestedScrollViewDemo>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();

  final tabList = ["分类1", "分类2", "分类3", "分类4", "分类5", "分类6"];
  late TabController tabController =
      TabController(length: tabList.length, vsync: this)..addListener(() {});

  Widget _tabWidget(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Material(
        child: ButtonsTabBar(
          backgroundColor: Colors.transparent,
          unselectedBackgroundColor: Colors.transparent,
          unselectedBorderColor: Colors.transparent,
          borderWidth: 1,
          borderColor: Colors.transparent,
          labelStyle: DefaultTextStyle.of(context)
              .style
              .copyWith(color: CupertinoTheme.of(context).primaryColor),
          unselectedLabelStyle: DefaultTextStyle.of(context).style.copyWith(
              color: CupertinoColors.secondaryLabel.resolveFrom(context)),
          buttonMargin:
              const EdgeInsets.only(top: 2, bottom: 2, left: 16, right: 8),
          radius: 20,
          elevation: 0,
          controller: tabController,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          tabs: tabList.map<Widget>((item) => Tab(text: item)).toList(),
        ),
      ),
    );
  }

  Widget _tabSliverWidget(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MySliverAppBarDelegate(
        minHeight: 60,
        maxHeight: 60,
        child: _tabWidget(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light, // 暗色
        scaffoldBackgroundColor: Colors.white,
        barBackgroundColor: Colors.white,
      ),
      home: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const CupertinoSliverNavigationBar(
                stretch: true,
                middle: null,
                border: null,
                // backgroundColor:  CupertinoTheme.of(context).barBackgroundColor,
                largeTitle: Text("App"),
              ),
              _tabSliverWidget(context),
            ];
          },
          body: PageView.builder(
            controller: pageController,
            itemCount: tabList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 50,
                            width: 50,
                            child: Placeholder(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "这是标题",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "这是描述",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.download),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: 100);
            },
          ),
        ),
      ),
    );
  }
}
