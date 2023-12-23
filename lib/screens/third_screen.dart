import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_test/models/user.dart';
import 'package:suitmedia_test/widgets/third_screen/user_item.dart';

import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() {
    return _ThirdScreenState();
  }
}

class _ThirdScreenState extends State<ThirdScreen> {
  final controller = ScrollController();

  List<User> userData = [];
  int currPage = 1;
  bool isLoading = true;
  bool hasData = true;
  bool isFailedFetch = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        _loadData();
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      currPage = 1;
      isLoading = true;
      hasData = true;
      userData = [];
    });

    _loadData();
  }

  Future<void> _loadData() async {
    final headers = {"User-Agent": "PostmanRuntime/7.36.0"};
    final uri = Uri.https(
      'reqres.in',
      '/api/users',
      {"page": "${currPage}", "per_page": "10"},
    );

    try {
      final r = await http.get(uri, headers: headers);
      final Map<String, dynamic> rBody = json.decode(r.body);
      final List<dynamic> users = rBody["data"];

      if (users.isEmpty) {
        setState(() {
          hasData = false;
        });

        return;
      }

      List<User> userList = [];

      for (var user in users) {
        userList.add(
          User(
              id: user["id"],
              email: user["email"],
              firstName: user["first_name"],
              lastName: user["last_name"],
              avatarURL: user["avatar"]),
        );
      }

      setState(() {
        isLoading = false;
        currPage++;

        userData.addAll(userList);
      });
    } catch (e) {
      Future.delayed(
        Duration(seconds: 20),
      );

      setState(() {
        isFailedFetch = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currContent = isFailedFetch
        ? Center(
            child: Text(
              "Failed To Fetch To The Server :(",
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 20,
                color: Colors.black26,
              ),
            ),
          )
        : isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return _onRefresh();
                },
                child: ListView.builder(
                  controller: controller,
                  itemCount: userData.length + 1,
                  itemBuilder: (ctx, index) {
                    if (userData.isEmpty) {
                      return Center(
                        child: Text(
                          "There is no data",
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 20,
                            color: Colors.black26,
                          ),
                        ),
                      );
                    }

                    if (index < userData.length) {
                      return UserItem(
                        user: userData[index],
                        onSelect: (user) {
                          Navigator.of(context).pop(user);
                        },
                      );
                    } else {
                      return hasData
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container();
                    }
                  },
                ),
              );

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
          'Third Screen',
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
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: currContent,
      ),
    );
  }
}
