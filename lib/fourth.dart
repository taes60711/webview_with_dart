import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SendToJs {
  SendToJs(this.webViewController, this.i);

  final InAppWebViewController webViewController;

  final int i;

  /// Flutterから呼び出すJavaScriptの処理を登録
  void sendData() {
    webViewController.evaluateJavascript(source: 'sendData($i);');
  }
}

class Fourth extends StatefulWidget {
  const Fourth({super.key});

  @override
  State<Fourth> createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  late InAppWebViewController inAppWebViewController;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  /// JavaScriptからデータを受け取ってアプリ側の画面にセット
  void _sendData(List<dynamic> args) {
    setState(() {
      List<dynamic> list = args.first;
      List<int> intList = list.cast<int>();
      _counter = intList.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'カウント: $_counter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                  ),
                  onPressed: _incrementCounter,
                  color: Colors.blue,
                ),
                const SizedBox(width: 30),
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                  onPressed: _decrement,
                  color: Colors.blue,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                SendToJs(inAppWebViewController, _counter).sendData();
              },
              child: const Text(
                'Javascriptにデータを送信',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: InAppWebView(
                initialFile: 'assets/www/web.html',
                onWebViewCreated: (InAppWebViewController webViewController) {
                  inAppWebViewController = webViewController;
                  // Javascriptから呼び出すFlutterの処理を登録
                  webViewController.addJavaScriptHandler(
                      handlerName: 'sendData', callback: _sendData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ChromeSafariWebView extends StatelessWidget {
  const ChromeSafariWebView({super.key});

  @override
  Widget build(BuildContext context) {
    ChromeSafariBrowser browser = ChromeSafariBrowser();

    return Center(
      child: ElevatedButton(
        onPressed: () {
          browser.addMenuItem(ChromeSafariBrowserMenuItem(
              id: 1,
              label: 'Custom item menu 1',
              action: (url, title) {
                print('Custom item menu 1 clicked!');
              }));
          browser.open(
            url: Uri.parse("https://forum.gamer.com.tw/"),
            options: ChromeSafariBrowserClassOptions(
              android: AndroidChromeCustomTabsOptions(
                  shareState: CustomTabsShareState.SHARE_STATE_OFF),
              ios: IOSSafariOptions(barCollapsingEnabled: true),
            ),
          );
        },
        child: const Text('Open'),
      ),
    );
  }
}

class AppWebView extends StatelessWidget {
  const AppWebView({super.key});

  @override
  Widget build(BuildContext context) {
    double _progress = 0;
    late InAppWebViewController inAppWebViewController;
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse("https://forum.gamer.com.tw/"),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            inAppWebViewController = controller;
          },
          onProgressChanged: (controller, progress) {
            _progress = progress / 100;
          },
        ),
        Positioned(
          bottom: 10,
          child: ButtonBar(
            children: [
              MyCustomButton(
                onPressed: () {
                  inAppWebViewController.goBack();
                },
                child: const Icon(Icons.arrow_back),
              ),
              MyCustomButton(
                onPressed: () {
                  inAppWebViewController.goForward();
                },
                child: const Icon(Icons.arrow_forward),
              ),
              MyCustomButton(
                onPressed: () {
                  inAppWebViewController.reload();
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MyCustomButton extends ElevatedButton {
  MyCustomButton({super.key, required super.onPressed, required super.child})
      : super(
            style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 68, 86, 147),
          elevation: 0,
        ));
}
