import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_test/models/user.dart';
import 'package:suitmedia_test/screens/third_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  State<SecondScreen> createState() {
    return _SecondScreenState();
  }
}

class _SecondScreenState extends State<SecondScreen> {
  User? currUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Color.fromRGBO(85, 74, 240, 1),
          ),
          iconSize: 30,
        ),
        title: Text(
          'Second Screen',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ).fontFamily,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 15,
          right: 20,
          bottom: 30,
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                    ).fontFamily,
                    fontSize: 12,
                  ),
                ),
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ).fontFamily,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                currUser == null
                    ? "Selected User Name"
                    : "${currUser!.firstName} ${currUser!.lastName}",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ).fontFamily,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  User? selectedUser = await Navigator.push<User>(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const ThirdScreen();
                      },
                    ),
                  );

                  setState(() {
                    currUser = selectedUser;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Choose a User',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ).fontFamily,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
