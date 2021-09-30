import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../SendHttpCalls/Models/blogApiModel.dart';
import 'blogDetailsScreens.dart';

class BlogSliderWidget extends StatelessWidget {
  final List<BlogModel> items;
  BlogSliderWidget(this.items);
  @override
  Widget build(BuildContext context) {
    return items.length == 0
        ? Container()
        : Container(
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                height: 400,
                viewportFraction: 1.0,
              ),
              items: items.map(
                (sliderModel) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BlogDetailsPage(sliderModel);
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: CachedNetworkImage(
                                  imageUrl: sliderModel.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 80,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 8, 5, 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        sliderModel.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          );
  }
}
