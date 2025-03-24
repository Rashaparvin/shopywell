import 'package:flutter/material.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class SearchBarColumnWidget extends StatelessWidget {
  final String heading;
  const SearchBarColumnWidget({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 3),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search any Product',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              suffixIcon: Icon(Icons.mic, color: Colors.grey),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              heading,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            kSizedBoxWidth(width: 5),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.swap_vert, color: Colors.black, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Sort',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                kSizedBoxWidth(width: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.filter_list, color: Colors.black, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Filter',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
