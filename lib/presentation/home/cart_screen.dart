import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class CartScreen extends StatefulWidget {
  final ProductDetailModel? product;
  const CartScreen({super.key, this.product});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    int currentImageIndex = 0;
    int selectedSizeIndex = 1;
    List<String> imageUrls = [widget.product!.image];
    List<String> sizes = ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  items: imageUrls.map((url) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        url,
                        height: 120,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentImageIndex = index;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imageUrls.length, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentImageIndex == index
                            ? Colors.red
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 10),

              /// **Size Selection**
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Size: ${sizes[selectedSizeIndex]}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return kSizedBoxWidth(width: 5);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSizeIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: selectedSizeIndex == index
                              ? Colors.red[100]
                              : Colors.white,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          sizes[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),

              /// **Product Name & Rating**
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product!.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < widget.product!.rating.rate
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text('${widget.product!.rating.count}',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              /// **Price & Discount**
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '₹${widget.product!.price * 2}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '₹${widget.product!.price}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '50% Off',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              /// **Product Details**
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.product!.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// **Go to Cart Button**
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    label: Text(
                      'Go to cart',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 10),

                  /// **Buy Now Button**
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    icon: Icon(Icons.touch_app, color: Colors.white),
                    label: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              /// **Delivery Information Box**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'Delivery in ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Fonts.kMontserratNormal),
                            ),
                            TextSpan(
                              text: '1 within Hour',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.kMontserratNormal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
