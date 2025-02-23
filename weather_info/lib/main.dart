import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ブックマーク'),
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
  final TextEditingController _controller = TextEditingController();
  String areaName = '';
  String weather = '';
  double temperature = 0;
  int humidity = 0;
  double temperatureMax = 0;
  double temperatureMin = 0;
  String apiKey = '225fb800d42d604c47aa30114d11c702';

  Future<void> loadWeather(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&lang=ja&units=metric&q=$query'),
    );
    if (response.statusCode != 200) {
      // 失敗
      return;
    }
    // 成功
    print(response.body);
    final body = json.decode(response.body) as Map<String, dynamic>;
    final main = (body['main'] ?? {}) as Map<String, dynamic>;
    setState(() {
      areaName = body['name'];
      weather = (body['weather']?[0]?['description'] ?? '') as String;
      humidity = (main['humidity'] ?? 0) as int;
      temperatureMax = (main['temp_max'] ?? 0) as double;
      temperatureMin = (main['temp_min'] ?? 0) as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                loadWeather(value);
              }
            },
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('地域'),
              subtitle: Text(areaName),
            ),
            ListTile(
              title: Text('天気'),
              subtitle: Text(weather),
            ),
            ListTile(
              title: Text('温度'),
              subtitle: Text(temperature.toString()),
            ),
            ListTile(
              title: Text('最高気温'),
              subtitle: Text(temperatureMax.toString()),
            ),
            ListTile(
              title: Text('最低気温'),
              subtitle: Text(temperatureMin.toString()),
            ),
            ListTile(
              title: Text('湿度'),
              subtitle: Text(humidity.toString()),
            ),
          ],
        ));
  }
}
