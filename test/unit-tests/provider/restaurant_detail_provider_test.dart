import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/detail.dart';
import 'package:restaurant/provider/restaurant_detail_provider.dart';

import 'restaurant_detail_provider_test.mocks.dart';

const _detailResponse = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {"name": "Italia"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Paket rosemary"},
        {"name": "Toastie salmon"},
        {"name": "Bebek crepes"},
        {"name": "Salad lengkeng"}
      ],
      "drinks": [
        {"name": "Es krim"},
        {"name": "Sirup"},
        {"name": "Jus apel"},
        {"name": "Jus jeruk"},
        {"name": "Coklat panas"},
        {"name": "Air"},
        {"name": "Es kopi"},
        {"name": "Jus alpukat"},
        {"name": "Jus mangga"},
        {"name": "Teh manis"},
        {"name": "Kopi espresso"},
        {"name": "Minuman soda"},
        {"name": "Jus tomat"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {"name": "anonim", "review": "a", "date": "30 Agustus 2021"},
      {
        "name": "Jerome Polin",
        "review": "Mantappu Jiwa!!!",
        "date": "30 Agustus 2021"
      },
      {"name": "AAAA", "review": "AAAA", "date": "30 Agustus 2021"},
      {"name": "AAAA", "review": "AAAA", "date": "30 Agustus 2021"},
      {"name": "qwe", "review": "rtu", "date": "30 Agustus 2021"}
    ]
  }
};

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Provider Test', () {
    RestaurantDetailProvider? restaurantProvider;
    var apiMock = MockApiService();

    setUp(() {
      when(apiMock.get('rqdv5juczeskfw1e867')).thenAnswer(
          (_) async => Future.value(DetailResult.fromJson(_detailResponse)));
      restaurantProvider = RestaurantDetailProvider(
          id: 'rqdv5juczeskfw1e867', apiService: apiMock);
    });

    test('verify that fetch detail of restaurants json parse run as expected',
        () async {
      var result = restaurantProvider!.detail.detail;
      var jsonRestaurant = DetailResult.fromJson(_detailResponse).detail;
      expect(result.id, equals(jsonRestaurant.id));
      expect(result.name, equals(jsonRestaurant.name));
      expect(result.description, equals(jsonRestaurant.description));
      expect(result.pictureId, equals(jsonRestaurant.pictureId));
      expect(result.city, equals(jsonRestaurant.city));
      expect(result.rating, equals(jsonRestaurant.rating));
    });
  });
}
