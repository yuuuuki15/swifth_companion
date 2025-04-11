import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

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
  int	selectedIndex = 0;
  String	username = '';
  Map<String, dynamic>	userData = {};
  bool	isLoading = false;
  String?	error;

  final ApiService	apiService = ApiService();

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> searchUser(String name) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      userData = await apiService.getUser(name);
      username = name;
      selectedIndex = 1;
    } catch (e) {
      error = e.toString();
      print('Error: $e');
    }

    isLoading = false;
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
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = InfoPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: page,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    String username = '';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bkgrnd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (appState.error != null)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    appState.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                        hintText: "Enter your username",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        username = value;
                      },
                      onFieldSubmitted: (_) {
                        if (username.isNotEmpty) {
                          appState.searchUser(username);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    if (appState.isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (username.isNotEmpty) {
                            appState.searchUser(username);
                          }
                        },
                        child: Text("search")
                      ),
                  ],
                ),
              ),
            ],
          ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (appState.userData.isNotEmpty) ...[
                  if (appState.userData['image_url'] != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(appState.userData['image_url']),
                    ),
                  SizedBox(height: 20),

                  Text(
                    'Login: ${appState.userData['login']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Email: ${appState.userData['email'] ?? 'Not available'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),

                  if (appState.userData['cursus_users'] != null) ...[
                    Text(
                      'Cursus Information',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...List.from(appState.userData['cursus_users']).map((cursus) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Cursus: ${cursus['cursus']['name']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Level: ${cursus['level']?.toStringAsFixed(2) ?? 'N/A'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 20),

                  if (appState.userData['projects_users'] != null) ...[
                    Text(
                      'Projects',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...List.from(appState.userData['projects_users'])
                      .where((project) => project['status'] == 'finished')
                      .map((project) {
                        final bool isPassed = project['validated?'] ?? false;
                        return Card(
                          child: ListTile(
                            title: Text(project['project']['name']),
                            subtitle: Text('Final mark: ${project['final_mark'] ?? 'N/A'}'),
                            trailing: Icon(
                              isPassed ? Icons.check_circle : Icons.cancel,
                              color: isPassed ? Colors.green : Colors.red,
                            ),
                          ),
                        );
                      }).toList(),
                  ],
                  SizedBox(height: 20),

                  if (appState.userData['cursus_users'] != null &&
                      appState.userData['cursus_users'].isNotEmpty &&
                      appState.userData['cursus_users'][0]['skills'] != null) ...[
                    Text(
                      'Skills',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ...List.from(appState.userData['cursus_users'][0]['skills']).map((skill) {
                      return Card(
                        child: ListTile(
                          title: Text(skill['name']),
                          trailing: Text('Level: ${skill['level']?.toStringAsFixed(2) ?? 'N/A'}'),
                        ),
                      );
                    }).toList(),
                  ],
                ],

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    appState.setSelectedIndex(0);
                  },
                  child: Text("Back to Search")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
