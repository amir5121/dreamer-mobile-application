import 'package:dreamer/common/constants.dart';
import 'package:dreamer/screens/home.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:dreamer/widgets/dreamer_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Landing extends StatefulWidget {
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
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
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
    super.initState();
    postViewModel.loadDeeperPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return postViewModel;
        }),
      ],
      child: DreamerScaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
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
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Journal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Statics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Notifications',
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
