import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_state.dart';

class Skills extends StatelessWidget {
  const Skills({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(
              color: Color(0xFFCCCCCC),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Skills',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  if (appState.selectedCursus['skills'] != null &&
                      (appState.selectedCursus['skills'] as List).isNotEmpty) ...[
                    ...List.from(appState.selectedCursus['skills']).map((skill) {
                      return Card(
                        color: Color(0xFFfafafa),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: ListTile(
                          title: Text(
                            skill['name'],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Text(
                            'Level: ${skill['level']?.toStringAsFixed(2) ?? 'N/A'}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ] else ...[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'No skills found',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Positioned.fill(
    //       child: Container(
    //         decoration: BoxDecoration(
    //           color: Color(0xFFFFFFFF),
    //           border: Border.all(color: Color.fromARGB(255, 142, 142, 142), width: 0.7),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top: 0,
    //       left: 0,
    //       child: Container(
    //         child: Text('Skills'),
    //       ),
    //     ),
    //   ],
    // );
  }
}
