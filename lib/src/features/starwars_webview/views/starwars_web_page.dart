import 'package:flutter/cupertino.dart';
import 'package:starwars/src/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StarwarsWebPage extends StatelessWidget {
  const StarwarsWebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: StarwarsColors.backgroundDark,
        middle: Text(
          'Star Wars - web',
          style: TextStyle(color: StarwarsColors.white),
        ),
      ),
      child: const WebView(
        initialUrl: 'https://www.starwars.com/community',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
