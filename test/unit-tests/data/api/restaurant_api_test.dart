import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/detail.dart';
import 'package:restaurant/data/model/restaurant.dart';

import 'restaurant_api_test.mocks.dart';

const listResponse =
    '{"error":false,"message":"success","count":20,"restaurants":[]}';

const getResponse = ''' 
{
    "error": false,
    "message": "success",
    "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [],
        "menus": {
            "foods": [],
            "drinks": []
        },
        "rating": 4.2,
        "customerReviews": []
    }
}
''';

// think the query response founded = 1, the search endpoint = 'melting'
const searchResponse = '{"error":false,"founded":1,"restaurants":[]}';

@GenerateMocks([http.Client])
void main() {
  group('API test', () {
    test('Return List of Restaurant', () async {
      var client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client,
      when(client.get(
              Uri.parse('${ApiService.baseUrl}/${ApiService.listEndpoint}')))
          .thenAnswer((_) async => http.Response(listResponse, 200));
      expect(await ApiService(client).list(), isA<RestaurantResult>());
    });

    test('Return Restaurant by Id', () async {
      var client = MockClient();
      final id = 'rqdv5juczeskfw1e867';

      // Use Mockito to return a successful response when it calls the
      // provided http.Client,
      when(client.get(Uri.parse(
              '${ApiService.baseUrl}/${ApiService.detailEndpoint}/$id'))) //id of Melting Pot
          .thenAnswer((_) async => http.Response(getResponse, 200));
      expect(await ApiService(client).get(id), isA<DetailResult>());
    });

    test('Return Restaurant by Query in search', () async {
      var client = MockClient();
      final query = 'melting';

      // Use Mockito to return a successful response when it calls the
      // provided http.Client,
      when(client.get(Uri.parse(
              '${ApiService.baseUrl}/${ApiService.searchEndpoint}?q=$query'))) //id of Melting Pot
          .thenAnswer((_) async => http.Response(searchResponse, 200));
      expect(await ApiService(client).search(query), isA<SearchResult>());
    });
  });
}
