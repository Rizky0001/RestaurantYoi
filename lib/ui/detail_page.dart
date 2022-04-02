import 'package:flutter/material.dart';
import 'package:restaurant/provider/database_provider.dart';
import 'package:restaurant/provider/preferences_provider.dart';
import 'package:restaurant/provider/restaurant_detail_provider.dart';
import 'package:restaurant/utils/result_state.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/detail.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';
import 'package:restaurant/widget/custom_bottom_modal.dart';
import 'package:restaurant/widget/item_chip_bar.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/restaurant_detail_page';
  final Restaurant restaurant;
  const DetailPage({required this.restaurant});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  static const _url = 'https://restaurant-api.dicoding.dev/images/small';
  var _idSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
          id: widget.restaurant.id, apiService: ApiService(Client())),
      child: Scaffold(
        body: _renderView(),
      ),
    );
  }

  Widget currentTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: chipBarList[_idSelected].bodyWidget,
    );
  }

  Row listChip(Menus menu) {
    foods.addAll(menu.foods);
    drinks.addAll(menu.drinks);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: chipBarList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(item.title),
                selected: _idSelected == item.id,
                onSelected: (_) => setState(() => _idSelected = item.id),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _actionButton(BuildContext context, Function() onTap) {
    return Padding(
      padding: EdgeInsets.only(top: 21, left: 21),
      child: GestureDetector(
        onTap: onTap,
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) => SvgPicture.asset(
            'assets/icon/${provider.isDarkTheme ? 'left_chevron_dark' : 'left_chevron'}.svg',
            width: 41,
            height: 41,
          ),
        ),
      ),
    );
  }

  Widget _renderView() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Hero(
                    tag: widget.restaurant.pictureId,
                    child: Image.network(
                      '$_url/${widget.restaurant.pictureId}',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _actionButton(
                      context,
                      () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 21, top: 21),
                      child: BookmarkButton(restaurant: widget.restaurant),
                    ),
                  ),
                  Container(
                    height: 21,
                    decoration: BoxDecoration(
                      color: provider.isDarkTheme
                          ? Color(0xFF333333)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(51),
                        topRight: Radius.circular(51),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restaurant.name,
                            style: GoogleFonts.poppins(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.25,
                              color: Color(0xFFD74141),
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              SvgPicture.asset('assets/icon/pin.svg'),
                              Text(widget.restaurant.city,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
                          ),
                          Consumer<RestaurantDetailProvider>(
                            builder: (context, provider, child) => Text(
                              provider.state == ResultState.HasData
                                  ? provider.detail.detail.address
                                  : "Loading...",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 43,
                            color: Color(0xFFFFD700),
                          ),
                          Text(
                            '${widget.restaurant.rating}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '''${widget.restaurant.description}''',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(height: 21),
                    Text('Categories'),
                    Consumer<RestaurantDetailProvider>(
                      builder: (context, item, _) {
                        return Center(child: Text('Hai Bro'));
                      },
                    ),
                    SizedBox(height: 21),
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Consumer<RestaurantDetailProvider>(
                      builder: (context, provider, _) {
                        if (provider.state == ResultState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (provider.state == ResultState.HasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: listChip(provider.detail.detail.menus),
                              ),
                              currentTab(),
                            ],
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 51,
                                ),
                                Text(
                                  'Something went wrong :(',
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 11),
                    Text(
                      'Review',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    ElevatedButton(
                      child: Text('Add Your Review'),
                      onPressed: () => showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(17.0)),
                        ),
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => CustomBottomModal(context,
                            id: widget.restaurant.id),
                      ),
                    ),
                    Consumer<RestaurantDetailProvider>(
                      builder: (context, provider, child) {
                        if (provider.state == ResultState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (provider.state == ResultState.HasData) {
                          var item = provider.detail.detail.customerReviews;
                          return Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: item.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                  '${item[index].name} pada ${item[index].date}',
                                ),
                                subtitle: Text(item[index].review),
                              ),
                            ),
                          );
                        } else
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 51,
                                ),
                                Text(
                                  'Something went wrong :(',
                                ),
                              ],
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
  }
}

class BookmarkButton extends StatefulWidget {
  final Restaurant restaurant;

  BookmarkButton({required this.restaurant});

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, state, child) {
      return Consumer<DatabaseProvider>(
        builder: (context, provider, child) => FutureBuilder<bool>(
            future: provider.isFavorite(widget.restaurant.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;
              return GestureDetector(
                onTap: () => setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    provider.addFavorite(widget.restaurant);
                    toast('Favorite Added!');
                  } else {
                    provider.removeFavorite(widget.restaurant.id);
                    toast('Favorite Removed!');
                  }
                }),
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: SvgPicture.asset(
                    isFavorite
                        ? 'assets/icon/${state.isDarkTheme ? 'bookmark_selected_dark' : 'bookmark_selected'}.svg'
                        : 'assets/icon/${state.isDarkTheme ? 'bookmark_unselected_dark' : 'bookmark_unselected'}.svg',
                    width: 40,
                    height: 40,
                  ),
                ),
              );
            }),
      );
    });
  }
}
