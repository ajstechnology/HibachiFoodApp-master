import 'package:flutter/material.dart';
import '../../helpers/aboutUsContent.dart';

class UserAgreementsPolicyPage extends StatelessWidget {
  const UserAgreementsPolicyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("User Agreements")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader("IT LEGAL COMPLIANCE"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "This user agreement is published and drafted in accordance & compliance with Section 43 A of IT Act 2008 and IT Rules 2011 (Intermediary guidelines) that require intermediaries to have a user agreement regarding sensitive personal data or information (SPDI)."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "By accessing or securing access, browsing, using www.hibachi.in you agree to the terms of the user agreement regarding your sensitive personal data or information (SPDI)."),
              SizedBox(
                height: 10,
              ),
              //TERMS
              getHeader("TERMS"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "1. I understand and have the knowledge that my sensitive personal data or information is being collected."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "2. I understand and have the knowledge of the purpose for which my sensitive personal data or information is collected."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "3. I understand and have the knowledge of the indented recipients of the information."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "4. I understand and have the knowledge of the name and address of the agency that is collecting, retaining and using the information."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "5. I understand that I have the option not to provide the data or information sought to be collected by www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "6. I understand that I also have an option (while availing the services of www.hibachi.in or otherwise) to withdraw my consent given earlier to www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED and understand and accept that such withdrawal of the consent shall be sent in writing to www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED and in such case, www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED shall have the option not to provide the services for which the said information was sought."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "7. I read and have understood the Privacy Policy mentioned on www.hibachi.in"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "8. I read and have understood the Terms and Conditions of mentioned on www.hibachi.in"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "9. I read and have understood the IP Policy, Social Media Policy and all legal policies mentioned on www.hibachi.in"),
            ],
          ),
        ),
      ),
    );
  }
}
