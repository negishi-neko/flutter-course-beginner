import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 変数が宣言時ではなく使われるタイミングで初期化される
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // loadRequestの結果ではなく、カスケード演算子前のオブジェクトが返される
    // 以下と同義
    // controller = WebViewController();
    // controller.loadRequest(Uri.parse('https://nzigen.com'));
    controller = WebViewController()
      ..loadRequest(Uri.parse('https://www.kuzirawkmgifu.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WebViewWidget(controller: controller),
    )
        // Center(
        //   child: Image.network(
        //     'https://ogre.natalie.mu/artist/106738/20180810/KUZIRA_art201805.jpg?imwidth=400&imdensity=1',
        //     width: 400,
        //     height: 400,
        //   ),
        // ),
        );
  }
}
