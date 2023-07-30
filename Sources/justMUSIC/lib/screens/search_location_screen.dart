import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

import '../components/city_list_component.dart';
import '../services/GeoApi.dart';
import '../values/constants.dart';

class SearchCityScreen extends StatefulWidget {
  final Function callback;
  const SearchCityScreen({Key? key, required this.callback}) : super(key: key);

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final ScrollController _scrollController = ScrollController();
  final GeoApi api = GeoApi();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 60.0,
        sigmaY: 60.0,
      ),
      child: Container(
        color: bgAppBar.withOpacity(0.5),
        height: screenHeight - 50,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Align(
              child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Color(0xFF3A3A3A).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
                child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: true),
              child: FutureBuilder(
                future: api.getNearbyCities(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        controller: _scrollController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                widget.callback(snapshot.data[index]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CityListComponent(
                                  location: snapshot.data[index],
                                ),
                              ));
                        });
                  } else {
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: 15,
                        color: grayColor,
                      ),
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
