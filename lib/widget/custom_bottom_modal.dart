import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/detail.dart';
import 'package:restaurant/provider/restaurant_provider.dart';

class CustomBottomModal extends StatefulWidget {
  final BuildContext ctx;
  final String id;

  CustomBottomModal(
    this.ctx, {
    required this.id,
  });

  @override
  _CustomBottomModalState createState() => _CustomBottomModalState();
}

class _CustomBottomModalState extends State<CustomBottomModal> {
  var _nameController = TextEditingController();
  var _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var paddingBottom = mediaQueryData.padding.bottom;
    var insetBottom = mediaQueryData.viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        top: 9,
        bottom:
            paddingBottom > 0 ? paddingBottom + insetBottom : 16 + insetBottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              'Compose a Review',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 11),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              controller: _nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 11),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Comment ...',
              ),
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 10,
              controller: _reviewController,
            ),
          ),
          ElevatedButton(
              child: Text('Send'),
              onPressed: () {
                var compose = ComposeReview(
                    id: widget.id,
                    name: _nameController.text,
                    review: _reviewController.text);
                Provider.of<RestaurantProvider>(widget.ctx, listen: false)
                    .sendData(compose);
                Navigator.pop(context);
              }),
          SizedBox(
            height: 21,
          ),
        ],
      ),
    );
  }
}
