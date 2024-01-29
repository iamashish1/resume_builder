import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:resume_builder/features/home/home_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {




  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
   HomeView(),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //     backgroundColor: Colors.white,
      //     onPressed: () {},
      //     label: Row(
      //       children: [
      //         Icon(LineIcons.plus),
      //         Text('Create New Resume'),
      //       ],
      //     )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.draft2Digital,
                  text: 'My Designs',
                ),
                GButton(
                  icon: LineIcons.download,
                  text: 'Downloads',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/remove.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,
              ),
              Text('Resume Maker'),
            ],
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a/ACg8ocKYGU6CTxn2ZW5cKYxDx6IhyhtIr_qw8HknjVSiRi5B8W0=s96-c'),
                  ),
                  Text(
                    'Ash Ish',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}


//HOme ma sabai designs dekhaune //create resume lai disable suruma //home bata click garexi enable gardine
//Love ma favorite gareko dekhaune 
//downloads ma downloaded
//Recent dekhaune 3rd ma or your designs 