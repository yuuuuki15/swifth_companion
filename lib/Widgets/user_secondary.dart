import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_state.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class user_secondary extends StatelessWidget {
  const user_secondary({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromARGB(255, 142, 142, 142), width: 0.7),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/phone.svg',
                          width: 15,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(appState.userData['phone']),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/mail.svg',
                          width: 15,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(appState.userData['email']),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/pin.svg',
                          width: 15,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(appState.userData['campus'][1]['name']),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/ghost.svg',
                          width: 15,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          appState.userData['data_erasure_date'] != null
                              ? DateFormat('dd/MM/yyyy').format(DateTime.parse(appState.userData['data_erasure_date']))
                              : 'N/A',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ],
    );
  }
}
