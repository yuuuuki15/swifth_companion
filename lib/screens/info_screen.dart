import 'package:flutter/material.dart';
import '../models/app_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xFF5a7a2f),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF333333),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 300,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFF333333),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color.fromARGB(255, 142, 142, 142), width: 0.3),
                        ),
                        child: Text(
                          'unavailable',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/bkgrnd.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Color(0xFF35c47f), width: 2),
                            ),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Yuki Kawakita',
                            style: GoogleFonts.gothicA1(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'ykawakit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '11',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Special Gothic Expanded One',
                                  letterSpacing: -1,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '21%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          'Transcender at 42cursus',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: 10,
                                              width: constraints.maxWidth,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                              height: 10,
                                              width: constraints.maxWidth * 0.21,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                                color: Color(0xFF35c47f),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    color: Colors.indigo,
                    height: 100,
                ),
                Container(
                    color: Colors.yellowAccent,
                    height: 100,
                ),
              ],
            ),
          ),
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
