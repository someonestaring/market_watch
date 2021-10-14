import 'package:market_watch/screens/auth/ext/home.dart';
import 'package:market_watch/state/app_state.dart';
import 'package:flutter/material.dart';

class Utility extends StatelessWidget {
  const Utility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Utility');
    PageController _pageCont = AppStateScope.of(context).pageCont;
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageCont,
          children: const [
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
