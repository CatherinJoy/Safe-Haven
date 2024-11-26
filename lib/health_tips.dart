//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthTipsPage extends StatefulWidget {
  @override
  _HealthTipsPageState createState() => _HealthTipsPageState();
}

class _HealthTipsPageState extends State<HealthTipsPage> {
  Map<String, String>? selectedArticle;
  Map<String, String>? selectedLecture;

  List<Map<String, String>> popularArticles = [
    {
      'title': '''The Pillars of
Vibrant Health''',
      'url':
          'https://himalayaninstitute.org/online/series/pillars-of-health/?gad=1&gclid=Cj0KCQjw1rqkBhCTARIsAAHz7K3bVz1dlKbZSlnHJ8vjsJN0_qpTybBr54i-fmisj_nffJ_pJWcgNygaAuaQEALw_wcB',
    },
    {
      'title': '''Health Actions 
  for Women''',
      'url':
          'https://store.hesperian.org/prod/Health_Actions_for_Women.html?gad=1&gclid=Cj0KCQjw1rqkBhCTARIsAAHz7K0D7nQ2vARwwkkkg9lAWXdv23-eK9-0DOvPhemQK3WXCozlrzbcFlgaAg6wEALw_wcB',
    },
    {
      'title': '''A Complete Health
Guide for Women''',
      'url':
          'https://www.godigit.com/health-insurance/tips/health-tips-for-women',
    },
  ];

  List<Map<String, String>> videoLectures = [
    {
      'title': '''Health Tips
    for Women''',
      'url': 'https://www.youtube.com/watch?v=E4EaRk6r_SM',
    },
    {
      'title': '''Health Tips ||
5 excellent asanas 
for women's health''',
      'url': 'https://www.youtube.com/watch?v=vRmdFoa9mH0',
    },
    {
      'title': '''Mental Health 
    & Women''',
      'url': 'https://www.youtube.com/watch?v=i4Q_bL-63oc',
    },
  ];

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 229, 234),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/SignIn_backgrd.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.14,
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 239, 221, 233),
                    radius: 55,
                    backgroundImage: AssetImage("img/s_logo.png"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: w,
              margin: const EdgeInsets.only(left: 10, right: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_right,
                          size: 30, color: Color.fromARGB(255, 139, 18, 148)),
                      Text(
                        "Articles",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 139, 18, 148),
                        ),
                      ),
                      DropdownButton<Map<String, String>?>(
                        value: selectedArticle,
                        onChanged: (Map<String, String>? value) {
                          setState(() {
                            selectedArticle = value;
                          });

                          if (value != null) {
                            launchURL(value['url']!);
                          }
                        },
                        items: popularArticles.map((article) {
                          return DropdownMenuItem<Map<String, String>?>(
                            value: article,
                            child: TextButton(
                              onPressed: () => launchURL(article['url']!),
                              child: Text(article['title']!),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.arrow_right,
                          size: 30, color: Color.fromARGB(255, 139, 18, 148)),
                      Text(
                        "Videos",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 139, 18, 148),
                        ),
                      ),
                      DropdownButton<Map<String, String>>(
                        value: selectedLecture,
                        onChanged: (Map<String, String>? value) {
                          setState(() {
                            selectedLecture = value;
                          });

                          if (value != null) {
                            launchURL(value['url']!);
                          }
                        },
                        items: videoLectures.map((lecture) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: lecture,
                            child: TextButton(
                              onPressed: () => launchURL(lecture['url']!),
                              child: Text(lecture['title']!),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 300),
            Container(
              width: w,
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_right, size: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        text: " Back",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 62, 62, 62),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}