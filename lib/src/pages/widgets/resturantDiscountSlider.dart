import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../SendHttpCalls/Models/HomePage/resturantSliderModel.dart';

class ResturantDiscountSliderWidget extends StatelessWidget {
  final List<ResturantSliderModel> items;
  ResturantDiscountSliderWidget(this.items);
  @override
  Widget build(BuildContext context) {
    return items.length == 0
        ? Container()
        : Container(
            color: Colors.red.shade50,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                viewportFraction: 0.7,
              ),
              items: items.map((sliderModel) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return ProductDetailsPage(sliderModel.data.id);
                        //     },
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.15),
                                blurRadius: 15,
                                offset: Offset(0, 2)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: sliderModel.image,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
  }
}
