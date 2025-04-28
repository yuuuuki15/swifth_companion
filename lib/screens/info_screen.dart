import 'package:flutter/material.dart';
import '../models/app_state.dart';
import 'package:provider/provider.dart';
import '../Widgets/user_primary.dart';
import '../Widgets/user_secondary.dart';
import '../Widgets/skills.dart';
import '../Widgets/projects.dart';
class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    print('2: login: ${appState.userData['login']}');

    return Scaffold(
      body: MyWidget(appState: appState),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bkgrnd.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          if (appState.userData.isNotEmpty) ...[
                            user_primary(appState: appState),
                            SizedBox(height: 20),
                            user_secondary(appState: appState),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Skills(appState: appState),
                  Projects(appState: appState),
                  // SampleWidget(appState: appState),
                ],
              );
            } else {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bkgrnd.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (appState.userData.isNotEmpty) ...[
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(maxHeight: 312),
                                child: user_primary(appState: appState),
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(maxHeight: 312),
                                child: user_secondary(appState: appState),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Skills(appState: appState),
                  Projects(appState: appState),
                  // SampleWidget(appState: appState),
                ],
              );
            }

          },
        ),
      ),
    );
  }
}

class SampleWidget extends StatelessWidget {
  const SampleWidget({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
