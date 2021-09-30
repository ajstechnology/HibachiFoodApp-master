import 'package:flutter/material.dart';
import '../../helpers/aboutUsContent.dart';

class SocialMediaPolicyPage extends StatelessWidget {
  const SocialMediaPolicyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Social Media")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getParagraph(
                  "GUIDELINES FOR WRITING POSTS, COMMENTS, REVIEWS ON HIBACHI’s SOCIAL MEDIA PAGES (Facebook, Twitter etc.)"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "This document is an electronic record in terms of Information Technology Act, 2000 and rules there under as applicable and the amended provisions pertaining to electronic records in various statutes as amended by the Information Technology Act, 2000. This electronic record is generated by a computer system and does not require any physical or digital signatures."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "Here are some basic guidelines for writing posts, comments, reviews, on HIBACHI’s SOCIAL MEDIA PAGES:"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "While we encourage you to share your views and opinions on the HIBACHI’s SOCIAL MEDIA PAGES, we expect that this will be done in a respectful manner."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED does not agree with or endorse every comment that individuals post on our SOCIAL MEDIA PAGES. When making moderation decisions, we will take these guidelines, as well as the context in which comments are made, into account"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "We share this information in an effort to be transparent about our moderation process and why certain comments may be removed. Kindly read these terms/ guidelines while making any posts, comments, reviews on HIBACHI’s SOCIAL MEDIA PAGES."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "ACCESSING, BROWSING OR OTHERWISE USING HIBACHI’s SOCIAL MEDIA PAGES INDICATE YOUR AGREEMENT TO THESE TERMS AND CONDITIONS, SO PLEASE READ THE TERMS OF USE CAREFULLY BEFORE PROCEEDING. By impliedly or expressly accepting these Terms, You also accept and agree to be bound by these Terms."),
              SizedBox(
                height: 10,
              ),
              //TERMS/ GUIDELINES- COMMENT POLICY
              getHeader("TERMS/ GUIDELINES- COMMENT POLICY"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "You specifically agree not to post or transmit any comments, reviews, posts, content or engage in any activity that: –"),
              SizedBox(
                height: 10,
              ),
              getParagraph("1. Violates our Guidelines and Policies;"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "2. Is harmful, threatening, abusive, harassing, tortious, indecent, defamatory, discriminatory, vulgar, profane, obscene, libellous, hateful or otherwise objectionable"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "3. Violates any right, including, but not limited to, right of privacy, right of publicity, copyright, trademark, patent, trade secret, or any other intellectual property or proprietary rights;"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "4. Disguising or attempting to disguise the origin of your comment, review, posts, content including but not limited to by submitting your comments, posts, reviews, content under a fake or false name"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "5. Constitutes a knowingly erroneous or unethical review"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "6. Causes, or is a result of, a conflict of interest;"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "7. Is commercial in nature, including but not limited to posts, comments, reviews submitted in exchange for payment,"),
              SizedBox(
                height: 10,
              ),
              getParagraph("8. Contains material that is not in English"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "9. Accesses or uses the account of another user without permission;"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "10. We reserve the right to remove any comment, review, posts, content that might be found extremely offensive or threatening."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "11. Please don’t exaggerate, falsely state, misrepresent your experience and watch your language."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "12. This also includes but not is limited to derogatory comments or indication of a personal vendetta against www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED and its affiliates."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "All links posted as comments on HIBACHI’s Social Media Pages will be reviewed and may be deleted if found violating these guidelines. Repeated violations of this policy may cause the author to be blocked from HIBACHI’s SOCIAL MEDIA PAGES. Any Comment, Review, Posts, Content uploaded by you on any social media, shall be subject to relevant laws of India and may be disabled, or and may be subject to investigation under all applicable laws."),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "Further, if you are found to be in non-compliance with the laws and regulations, these terms, terms & conditions, privacy policy on mentioned on the website www.hibachi.in, HIBACHI GOURMET PRIVATE LIMITED we reserve the right to immediately block your access, usage to the Social Media Pages of HIBACHI and HIBACHI GOURMET PRIVATE LIMITED shall have the right to remove any non-compliant comment, post, review, content forthwith, uploaded and shall further have the right to take appropriate recourse to such remedies as would be available to it under various statutes."),
            ],
          ),
        ),
      ),
    );
  }
}
