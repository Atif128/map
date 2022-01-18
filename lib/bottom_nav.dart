import 'package:flutter/material.dart';
import 'package:map/employee.dart';
import 'package:map/main.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              child: Center(
                child: _getPage(currentPage),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.green,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: currentPage,
              onTap: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  label: ('Clothes'),
                  icon: Icon(Icons.notes_outlined),
                ),
                BottomNavigationBarItem(
                  label: ('Employees'),
                  icon: Icon(Icons.add_chart_outlined),
                ),
              ],
            ),
          );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const TestClass();
      case 1:
        return const EmployeeClass();
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text('TabBar Index Error'),
          ],
        );
    }
  }
}
