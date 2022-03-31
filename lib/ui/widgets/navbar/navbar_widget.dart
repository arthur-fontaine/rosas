import 'package:flutter/material.dart';

import 'package:heroicons/heroicons.dart';

import 'package:rosas/utils/utils_barrel.dart';

enum NavbarTabs {
  home,
  search,
  bell,
  // cog,
}

extension NavbarTabsIcon on NavbarTabs {
  HeroIcons get icon {
    switch (this) {
      case NavbarTabs.home:
        return HeroIcons.home;
      case NavbarTabs.search:
        return HeroIcons.search;
      case NavbarTabs.bell:
        return HeroIcons.bell;
      // case NavbarTabs.cog:
      //   return HeroIcons.cog;
    }
  }
}

class Navbar extends StatefulWidget {
  final Function(NavbarTabs p1) onTabTapped;

  const Navbar({Key? key, required this.onTabTapped}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    widget.onTabTapped(NavbarTabs.values[index]);
  }

  List<BottomNavigationBarItem> _generateNavbarItems(List<HeroIcons> icons) {
    List<BottomNavigationBarItem> navbarItems = [];

    icons.asMap().forEach((index, icon) {
      navbarItems.add(BottomNavigationBarItem(
        icon: HeroIcon(icon, solid: _currentIndex == index, size: 24),
        label: icon.name.capitalize(),
      ));
    });

    return navbarItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: _generateNavbarItems(
              NavbarTabs.values.map((navbarTab) => navbarTab.icon).toList()),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
