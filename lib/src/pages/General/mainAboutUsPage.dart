import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'foodLicensePage.dart';
import 'grieveanceRedressalPage.dart';
import 'privacyPolicyPage.dart';
import 'refundPolicyPage.dart';
import 'socialMediaPolicyPage.dart';
import 'termsAndConditionsPage.dart';
import 'userAgreementsPage.dart';
import 'aboutUsPage.dart';

class MainAboutUsPage extends StatelessWidget {
  const MainAboutUsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("About Us")),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Hello, What are you Looking for ?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Roboto',
                      fontSize: 31,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AboutUsPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'About Us',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TermAndConditionsPolicyPage();
                          },
                        ),
                      );
                    },
                    child: getText('Terms & Conditions')),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PrivacyPolicyPage();
                        },
                      ),
                    );
                  },
                  child: getText('Privacy Policy'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SocialMediaPolicyPage();
                        },
                      ),
                    );
                  },
                  child: getText('Social Media Policy'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserAgreementsPolicyPage();
                        },
                      ),
                    );
                  },
                  child: getText('User Agreements'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return GrieveanceRedressalPage();
                        },
                      ),
                    );
                  },
                  child: getText('Grieveance Redressal'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FoodLicensePage();
                        },
                      ),
                    );
                  },
                  child: getText('Food License'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RefundPolicyPage();
                        },
                      ),
                    );
                  },
                  child: getText('Refund Policy'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Contact Us,',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Roboto',
                      fontSize: 34,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _makePhoneCall('tel:+917288885555');
                  },
                  child: Text(
                    '+91 72 8888 5555',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'For Assistance,\n\nSend a Mail',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Roboto',
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _makePhoneCall('mailto:info@hibachi.in');
                  },
                  child: Text(
                    'info@hibachi.in',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getText(String value) {
    return Text(
      value,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          height: 1),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Unable to launch the " + url);
    }
  }
}
