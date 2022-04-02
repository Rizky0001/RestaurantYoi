import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurant/data/model/detail.dart';
import 'package:restaurant/data/model/restaurant.dart';

class ApiService {
  static final String baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String listEndpoint = 'list';
  static final String detailEndpoint = 'detail';
  static final String reviewEndpoint = 'review';
  static final String searchEndpoint = 'search';
  final String _token = '12345';

  final Client client;

  ApiService(this.client);

  Future<RestaurantResult> list() async {
    final response = await client.get(Uri.parse('$baseUrl/$listEndpoint'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load lists');
    }
  }

  Future<DetailResult> get(String id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$detailEndpoint/$id'));

    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<SearchResult> search(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$searchEndpoint?q=$query'));

    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> postReview(ComposeReview review) async {
    return client.post(
      Uri.parse('$baseUrl/$reviewEndpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Auth-Token': _token,
      },
      body: jsonEncode(review.toJson()),
    );
  }
}
