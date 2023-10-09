import "package:flutter/material.dart";
import "package:flutter_application_1/pages/home_page.dart";
import "package:google_fonts/google_fonts.dart";

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
}
}