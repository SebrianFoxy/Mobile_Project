import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cognitivyskills/components/navigation_provider.dart';
import 'listgame.dart';
import 'CenterHelp.dart';
import 'profilemenu.dart';
import 'statistic.dart';

class navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final currentPageIndex = navigationProvider.currentPageIndex;

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: BottomAppBar(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      navigationProvider.setCurrentPageIndex(0); // Обновляем индекс текущей страницы
                      try {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ListGame()),
                          (route) => false,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(
                      Icons.gamepad,
                      color: currentPageIndex == 0 ? Colors.black : Colors.grey, // Подсветка активной иконки
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigationProvider.setCurrentPageIndex(1); // Обновляем индекс текущей страницы
                      try {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => statistic()),
                          (route) => false,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(
                      Icons.stacked_bar_chart,
                      color: currentPageIndex == 1 ? Colors.black : Colors.grey, // Подсветка активной иконки
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigationProvider.setCurrentPageIndex(2); // Обновляем индекс текущей страницы
                      try {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => profilemenu()),
                          (route) => false,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(
                      Icons.account_box,
                      color: currentPageIndex == 2 ? Colors.black : Colors.grey, // Подсветка активной иконки
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
