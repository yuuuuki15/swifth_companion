import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifty Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class AppState extends ChangeNotifier {
  int selectedIndex = 0;
  String username = '';

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setUsername(String name) {
    username = name;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    int selectedIndex = appState.selectedIndex;

    Widget page;
    String title;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        title = "Home";
        break;
      case 1:
        page = InfoPage();
        title = "User info";
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: page,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.read<AppState>();
    String username = '';

    void searchUser() {
      appState.setUsername(username);
      appState.setIndex(1);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                    hintText: "Enter your username",
                ),
                onChanged: (value) {
                  username = value;
                },
                onFieldSubmitted: (_) {
                  searchUser();
                },
                validator: (value) {
                    if (value == null || value.isEmpty) {
                    return 'Enter your username';
                    }
                    return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: searchUser,
              child: Text("search")
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Username: ${appState.username}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.setIndex(0);
              },
              child: Text("back")
            ),
          ],
        ),
      ),
    );
  }
}
