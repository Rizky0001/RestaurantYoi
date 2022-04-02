import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/provider/restaurant_provider.dart';

import 'restaurant_provider_test.mocks.dart';

const _apiResponse = {
  'error': false,
  'message': 'success',
  'count': 1,
  'restaurants': [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

const _testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

const _searchResponse = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Provider Test', () {
    var apiMock = MockApiService();
    RestaurantProvider? restaurantProvider;

    setUp(() {
      when(apiMock.list()).thenAnswer(
          (_) async => Future.value(RestaurantResult.fromJson(_apiResponse)));
      restaurantProvider = RestaurantProvider(apiService: apiMock);
    });

    test('verify that fetch all restaurants json parse run as expected',
        () async {
          var result = restaurantProvider!.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(_testRestaurant);
      expect(result.id, equals(jsonRestaurant.id));
      expect(result.name, equals(jsonRestaurant.name));
      expect(result.description, equals(jsonRestaurant.description));
      expect(result.pictureId, equals(jsonRestaurant.pictureId));
      expect(result.city, equals(jsonRestaurant.city));
      expect(result.rating, equals(jsonRestaurant.rating));
    });

    test('verify that restaurants search json parse run as expected', () async {
      when(apiMock.search('melting'))
          .thenAnswer((_) async => SearchResult.fromJson(_searchResponse));
      var result = restaurantProvider!.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(_testRestaurant);
      expect(result.id, equals(jsonRestaurant.id));
      expect(result.name, equals(jsonRestaurant.name));
      expect(result.description, equals(jsonRestaurant.description));
      expect(result.pictureId, equals(jsonRestaurant.pictureId));
      expect(result.city, equals(jsonRestaurant.city));
      expect(result.rating, equals(jsonRestaurant.rating));
    });
  });
}
