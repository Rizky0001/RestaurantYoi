import 'package:flutter/material.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/detail.dart';
import 'package:restaurant/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  RestaurantDetailProvider({required this.id, required this.apiService}) {
    _fetchDetail(id);
  }

  String _message = '';
  int _count = 0;
  late ResultState _state;
  late DetailResult _detailResult;

  String get message => _message;
  int get count => _count;
  DetailResult get detail => _detailResult;
  ResultState get state => _state;

  sendData(ComposeReview review) {
    apiService.postReview(review);
    notifyListeners();
    _fetchDetail(review.id);
    notifyListeners();
  }

  Future<dynamic> _fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;
      _detailResult = await apiService.get(id);

      print('Detail Result state error : ${_detailResult.error}');

      if (_detailResult.error == false) {
        _state = ResultState.HasData;
        notifyListeners();
      } else {
        _state = ResultState.NoData;
        _message = 'Empty Data :)';
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}