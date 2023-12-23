import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_test/screens/second_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  bool isPalindrome(String text) {
    String cleanedText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = cleanedText.split('').reversed.join();

    return cleanedText == reversedText;
  }

  @override
  Widget build(BuildContext context) {
    var _palindromeKey = GlobalKey<FormFieldState>();
    var _nameKey = GlobalKey<FormFieldState>();

    String userName = "";
    String palindromeText = "";

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image_1.svg'),
            const SizedBox(
              height: 50,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: _nameKey,
                  onSaved: (value) {
                    userName = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Input The Name";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 20,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Name",
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: const Color.fromRGBO(104, 103, 119, 0.36),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                      gapPadding: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  key: _palindromeKey,
                  onSaved: (value) {
                    palindromeText = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Input The Palindrome";
                    }

                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(
                            isPalindrome(value)
                                ? "isPalindrome"
                                : "Not Palindrome",
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 20,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Palindrome",
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: const Color.fromRGBO(104, 103, 119, 0.36),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                      gapPadding: 0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      _palindromeKey.currentState!.validate();

                      _palindromeKey.currentState!.save();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "CHECK",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (_nameKey.currentState!.validate()) {
                        _nameKey.currentState!.save();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return SecondScreen(
                                userName: userName,
                              );
                            },
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
