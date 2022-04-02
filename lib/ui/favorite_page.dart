import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/provider/database_provider.dart';
import 'package:restaurant/utils/result_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/widget/custom_list.dart';

class FavoritePage extends StatefulWidget {
  static String favoriteTitle = 'Favorites';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<SearchResult> restaurantSearch;

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildRestaurantItem() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.HasData) {
        return Expanded(
          child: ListView.builder(
            itemCount: provider.favorites.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var restaurant = provider.favorites[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 21),
                child: CustomListItem(restaurant: restaurant),
              );
            },
          ),
        );
      } else {
        return Expanded(child: Center(child: Text(provider.message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 41, left: 21, right: 21),
            child: Text('FAVORITES',
                style: GoogleFonts.poppins(
                  color: Color(0xFFD74141),
                  fontWeight: FontWeight.bold,
                  fontSize: 29,
                )),
          ),
          _buildRestaurantItem()
        ],
      ),
    );
  }
}
