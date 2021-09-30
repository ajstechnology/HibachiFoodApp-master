import 'package:flutter/material.dart';
import '../../helpers/aboutUsContent.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("About Us")),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          // color: Colors.amber.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader("The More You Know Us The Much You Love Us…"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "Ah! There You Are! Well, hope the day is good with you, you are on our site, and wanted to know about us, so what do you wanna know? Where are we from? What are we? Our products? Our Vision? Our Aim? Alright, lets begin from what are we? Well, we are a bunch of meat lovers after all, we love meat and we have tried numerous varieties and qualities of meat, our endless craving for a quality meat is what made us to launch the site, HIBACHI, being an immense meat lovers we utmost tried every meat and found few of them finger-licking, and wanted to introduce these tastes to the fellow meat lovers, as there are countless meat lovers out there, everyone cant explore the meat world just like we did, to reduce your struggle and to quench your thirst for a better meat we have come up with the idea, HIBACHi, where you can find a quality yet tasty meat on your fingertips. Alright this turned out a big paragraph, hope you got what are we! "),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "And now Where are we from? does that really matters? Nope! right? lets get to ‘Our Products’ then, we knew you have been waiting for this, alright meat eaters, we have everything that’s what we can say, right from chicken to sushi, we have got everything. As majority people are Chicken lovers, we have got numerous qualities of chicken, and so does the sea food! You might wondering of the packing right? we too care your health as much as you do, you can blindly trust us on the packing, we are using the best premium packing ever, you can blindly rely on us. A special mention, we only serve the ‘Halaal’ meat. We assure you an efficient cleaning and sanitation of the meat  So these are our products, and the also about the sanitation an all. Wanna try some? What are you waiting for? Go back to the main menu instead of reading about us, and order your food now, we mean right now!"),
              SizedBox(
                height: 10,
              ),
              getParagraph(
                  "Uh! Oh! You are still here? alright, seems like you have got a bit more interest on our site than the meat, okay, lets continue then, what else you wanna know? Our aim? A simple and precised aim we have got, “Serve the best meat to all the meat lovers”, well, that sounds too simple but it ain’t, however, we endeavour to serve you the best. And that’s all for now! you have known everything about us, now go order your meat, and taste the best meat ever. Down right here is the link for main menu…And Yeah! Have a great meat day! Uh! oh! A great day, we mean."),
            ],
          ),
        ),
      ),
    );
  }
}
