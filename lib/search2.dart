import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:weather/api/api_helper.dart';
import 'package:weather/api/models/five_days_model.dart';
import 'package:weather/api/models/location_data_model.dart';
import 'package:weather/search.dart';

class Searched extends StatefulWidget {
  String searchedCity;
  Searched(this.searchedCity);

  @override
  State<Searched> createState() => _SearchedState();
}

class _SearchedState extends State<Searched> {
  String location = "İstanbul";
  double temperature = 20;
  String background = "assets/c.jpg";
  String currentIcon = "10d";
  List days = [
    "asd",
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              currentDayCard(),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 330,
                child: FutureBuilder<FiveDaysModel>(
                    future: ApiHelper().fiveDaysData(widget.searchedCity),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var response = snapshot.data!;
                        return ListView.builder(
                            itemCount: response.list!.length,
                            itemBuilder: (context, index) {
                              if (response.list![index].dtTxt!.hour == 15) {
                                return Card(
                                  color: Colors.black45,
                                  child: ListTile(
                                    trailing: Text(
                                      response.list![index].main!.temp!
                                              .toInt()
                                              .toString() +
                                          "º C",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    leading: Image(
                                        image: NetworkImage(
                                            "https://openweathermap.org/img/wn/${response.list![index].weather![0].icon}@4x.png")),
                                    title: Text(
                                      days[
                                          response.list![index].dtTxt!.weekday],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Center(
                            child: CircularProgressIndicator());
                      }
                    }),
              )
            ],
          )),
    );
  }

  FutureBuilder<LocationDataModel> currentDayCard() {
    return FutureBuilder<LocationDataModel>(
        future: ApiHelper().locationData(widget.searchedCity),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var response = snapshot.data!;
            temperature = response.main!.temp!.toDouble();
            location = response.name!;
            currentIcon = response.weather![0].icon!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: NetworkImage(
                      "https://openweathermap.org/img/wn/$currentIcon@4x.png"),
                ),
                Text(
                  "${temperature.toInt()}º C",
                  style: const TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$location",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),

                  ],
                )
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator());
          }
        });
  }
}
