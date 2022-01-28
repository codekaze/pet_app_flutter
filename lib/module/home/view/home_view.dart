import 'package:flutter/material.dart';
import 'package:pet_app/configuration/configuration.dart';
import 'package:pet_app/module/pet_detail/view/pet_detail_view.dart';
import '../controller/home_controller.dart';

import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        controller.view = this;

        return AnimatedContainer(
          decoration: controller.isDrawerOpen
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                )
              : BoxDecoration(color: Colors.white),
          transform: Matrix4.translationValues(
              controller.xOffset, controller.yOffset, 0)
            ..scale(controller.scaleFactor),
          duration: Duration(milliseconds: 250),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.isDrawerOpen
                            ? IconButton(
                                onPressed: () {
                                  controller.xOffset = 0;
                                  controller.yOffset = 0;
                                  controller.scaleFactor = 1;
                                  controller.isDrawerOpen = false;
                                  controller.update();
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              )
                            : IconButton(
                                onPressed: () {
                                  controller.xOffset = 230;
                                  controller.yOffset = 150;
                                  controller.scaleFactor = 0.6;
                                  controller.isDrawerOpen = true;
                                  controller.update();
                                },
                                icon: Icon(Icons.menu),
                              ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Kyiv, ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Ukraine'),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/pet_cat1.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[400],
                              ),
                              hintText: 'Search pet',
                              hintStyle: TextStyle(
                                  letterSpacing: 1, color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.tune_sharp,
                                  color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 120,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: shadowList,
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                              categories[index]['imagePath']),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        categories[index]['name'],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: catMapList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PetDetailView(
                                              catDetailsMap: catMapList[index],
                                            )));
                              },
                              child: Container(
                                height: 230,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: (index % 2 == 0)
                                                  ? Colors.blueGrey[200]
                                                  : Colors.orangeAccent[200],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: shadowList,
                                            ),
                                            margin: EdgeInsets.only(top: 40),
                                          ),
                                          Align(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Hero(
                                                tag:
                                                    'pet${catMapList[index]['id']}',
                                                child: Image.asset(
                                                    catMapList[index]
                                                        ['imagePath'])),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 65, bottom: 20),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          boxShadow: shadowList,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  catMapList[index]['name'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 21.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                (catMapList[index]['sex'] ==
                                                        'male')
                                                    ? Icon(
                                                        Icons.male_rounded,
                                                        color: Colors.grey[500],
                                                      )
                                                    : Icon(
                                                        Icons.female_rounded,
                                                        color: Colors.grey[500],
                                                      ),
                                              ],
                                            ),
                                            Text(
                                              catMapList[index]['Species'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            Text(
                                              catMapList[index]['year'] +
                                                  ' years old',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: primaryColor,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  'Distance: ' +
                                                      catMapList[index]
                                                          ['distance'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
