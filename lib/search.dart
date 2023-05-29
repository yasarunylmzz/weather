import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather/search2.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var controller = TextEditingController();
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/search.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      onChanged: (value) {
                        keyword = value;
                      },
                      onEditingComplete: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Searched(keyword)));
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Şehir İsmi",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            ),
          )),
    );
  }
}
