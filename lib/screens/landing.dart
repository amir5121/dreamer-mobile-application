import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/widgets/svg_icon.dart';
import 'package:dreamer/screens/home/home.dart';
import 'package:dreamer/screens/statics/statics.dart';
import 'package:dreamer/view_models/dreams_view_model.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'journal/journal.dart';

class Landing extends StatefulWidget {
  static final int home = 0;
  static final int journal = 1;

  final int selectedIndex;

  const Landing({Key key, this.selectedIndex}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;
  PostViewModel postViewModel = PostViewModel();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Journal(),
    Statics(),
    Text(
      'Index 3: Bitch please',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    postViewModel.loadDeeperPosts();
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return postViewModel;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return DreamViewModel();
          },
        ),
      ],
      child: DreamerScaffold(
        showAppBar: _selectedIndex != 1,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/story');
          },
          child: Icon(
            Icons.add,
            color: Constants.tertiaryColor,
          ),
          backgroundColor: Constants.secondaryColor,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Constants.accentColor),
            ),
          ),
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SVGIcon(
                  color: Constants.accentColor,
                  assetAddress: 'assets/images/explore.svg',
                ),
                activeIcon: SVGIcon(
                  color: Constants.tertiaryColor,
                  assetAddress: 'assets/images/explore_b.svg',
                ),
                label: 'Home',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SVGIcon(
                  color: Constants.accentColor,
                  assetAddress: 'assets/images/journal.svg',
                ),
                activeIcon: SVGIcon(
                  color: Constants.tertiaryColor,
                  assetAddress: 'assets/images/journal_b.svg',
                ),
                label: 'Journal',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SVGIcon(
                  color: Constants.accentColor,
                  assetAddress: 'assets/images/statics.svg',
                ),
                activeIcon: SVGIcon(
                  color: Constants.tertiaryColor,
                  assetAddress: 'assets/images/statics_b.svg',
                ),
                label: 'Statics',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: SVGIcon(
                  color: Constants.accentColor,
                  assetAddress: 'assets/images/notification.svg',
                ),
                activeIcon: SVGIcon(
                  color: Constants.tertiaryColor,
                  assetAddress: 'assets/images/notification_b.svg',
                ),
                label: 'Notifications',
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
