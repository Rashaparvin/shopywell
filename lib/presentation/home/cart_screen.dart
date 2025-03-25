import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/domain/bloc/wish_list/wishlist_bloc.dart';
import 'package:shopywell/presentation/home/bottom_navigation.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(FetchWishlistProducts());
  }

  @override
  Widget build(BuildContext context) {
    int selectedSizeIndex = 1;

    List<String> sizes = ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottonNavigationWithScreen()));
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoaded) {
            final products = state.wishlist;
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      kSizedBoxHeight(height: 10),
                      Divider(),
                      kSizedBoxHeight(height: 10),
                    ],
                  );
                },
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final List imageUrls = [product.image];
                  return Column(
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
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {},
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      /// **Size Selection**
                      Text(
                        'Size: ${sizes[selectedSizeIndex]}',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 14),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (index) => Icon(
                                  index < product.rating.rate
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('${product.rating.count}',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      /// **Price & Discount**
                      Row(
                        children: [
                          Text(
                            '₹${product.price * 2}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '₹${product.price}',
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

                      SizedBox(height: 10),

                      /// **Product Details**
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            icon:
                                Icon(Icons.shopping_cart, color: Colors.white),
                            label: Text(
                              'Go to cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            icon: Icon(Icons.touch_app, color: Colors.white),
                            label: Text(
                              'Buy Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                              child: Column(
                                children: [
                                  Text(
                                    'Delivery in ',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '1 within Hour',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          }
          return Center(
              child: Text(
            'Your cart is empty!',
            style: TextStyle(
                color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
          ));
        },
      ),
    );
  }
}
