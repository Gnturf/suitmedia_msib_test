import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_test/models/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
    required this.onSelect,
  });

  final User user;
  final Function(User user) onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect(user);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0.5),
              color: Color.fromRGBO(226, 227, 228, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 49,
              width: 49,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.network(
                user.avatarURL,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ).fontFamily,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
