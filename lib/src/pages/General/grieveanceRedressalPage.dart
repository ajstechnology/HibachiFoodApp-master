import 'package:flutter/material.dart';
import '../../helpers/aboutUsContent.dart';

class GrieveanceRedressalPage extends StatelessWidget {
  const GrieveanceRedressalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Grieveance Redressal")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getParagraph(
                  "In accordance with Information Technology Act 2000 and rules made there under, the name and contact details of the Grievance Officer are provided below:"),
              SizedBox(
                height: 10,
              ),
              getParagraph("Grievance Officer: – Mr. Sekhar Varma"),
              SizedBox(
                height: 10,
              ),
              getParagraph("Email: info@hibachi.in"),
              SizedBox(
                height: 10,
              ),
              getParagraph("Time: Mon – Fri (10:00AM to 5:00PM)"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "If you are the rightful owner of the content or an affected person and have the reason to believe that any content that has been uploaded/contributed through this Service contravenes your rights in violation of Rule 3 of the Information Technology (Intermediary Guidelines) Rules, 2011 then you may intimate the same to www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED in the manner explained below:-"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "a. Sending a request in writing or through email signed with electronic signature identifying the content alleged to be in infringement of your rights as the rightful owner or affecting you prejudicially;"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "b. Providing exact identification and description of the content by giving its URL that is to be disabled, which in your view contravenes Rule 3(2) of aforesaid Rules."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "c. Giving a declaration cum undertaking along with necessary documents establishing you"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "(i) as the rightful owner of the content to be disabled, or"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "(ii) as an affected person, and stating that the information submitted is true, complete & accurate and no material fact has been hidden. Further, stating to www.hibachi.in , HIBACHI GOURMET PRIVATE LIMITED including its Management, Directors, Employees and Grievance Officer shall not be liable in whatsoever manner for any loss or damage or claim for relying upon the said request."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "d. Your contact information like address, telephone number, email address, etc. where you can be contacted."),
            ],
          ),
        ),
      ),
    );
  }
}
