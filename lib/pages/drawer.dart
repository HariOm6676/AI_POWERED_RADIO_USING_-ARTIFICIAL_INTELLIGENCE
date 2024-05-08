import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hariomshukla337@gmail.com', // replace with your email
      queryParameters: {
        'subject': 'Hello! I am from your AI Radio App !',
        'body': 'Please! Type your message here',
      },
    );

    final String uri = emailLaunchUri.toString();

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 250,
              color: Color.fromRGBO(80, 227, 194, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '"If Change Is Need\nMy Blood And Sweat Will Feed!"',
                      style: GoogleFonts.dhurjati(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(128, 0, 0, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 3, // Adjust the border width as needed
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/profile.jpg"),
                            maxRadius: 51,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment:
                                Alignment.topLeft, // Align text to the left
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to start (left)
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons
                                          .profile_circled, // Use the built-in Flutter icon
                                      color: Color.fromRGBO(128, 0, 0, 1),
                                      // Set the same orange color
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Hari Om Shukla",
                                      style: GoogleFonts.libreBaskerville(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(128, 0, 0, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                // Add spacing between the text

                                Row(
                                  // Add a Row to display Icon and Text together
                                  children: [
                                    Icon(
                                      Icons
                                          .code, // Use the built-in Flutter icon
                                      color: Color.fromRGBO(65, 0, 147, 1),
                                      // Set the same orange color
                                    ),
                                    SizedBox(
                                        width:
                                            5), // Add some spacing between icon and text
                                    Text(
                                      "Flutter Developer",
                                      style: GoogleFonts.dhurjati(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromRGBO(65, 0, 147, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Row(
                                  // Another Row for School icon and text
                                  children: [
                                    Icon(
                                        Icons
                                            .school, // Use the built-in School icon
                                        color: Color.fromRGBO(65, 0, 147,
                                            1) // Set a contrasting deep red color
                                        ),
                                    SizedBox(width: 5),
                                    Text(
                                      "PSIT Kanpur",
                                      style: GoogleFonts.dhurjati(
                                        fontSize: 20.0,
                                        // fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(65, 0, 147, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              leading: const Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textScaleFactor: 1.2,
              ),
            ),
            ListTile(
              onTap: () {
                final Uri url = Uri.parse(
                    'https://www.linkedin.com/in/hariom-shukla-32ab3a24a/');
                launchUrl(url);
              },
              leading: const Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Linkedin  Profile",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                _sendEmail();
              },
              leading: const Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              title: Text(
                "Email to Leader",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                final Uri url = Uri.parse(
                    'https://drive.google.com/file/d/1fYq0wc9uSL3yECuaO6znWlMo_siDj_pM/view?usp=sharing');
                launchUrl(url);
              },
              leading: const Icon(
                CupertinoIcons.bag_fill_badge_plus,
                color: Colors.white,
              ),
              title: Text(
                "My Resume",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              hoverColor: Colors.lightBlue,
              onTap: () {
                final Uri url = Uri.parse('https://github.com/HariOm6676');
                launchUrl(url);
              },
              leading: const Icon(
                CupertinoIcons.collections,
                color: Colors.white,
              ),
              title: Text(
                "My Git Hub",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
