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
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFfafafa),
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
          ],
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
