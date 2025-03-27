import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/domain/bloc/payment/payment_bloc.dart';
import 'package:shopywell/domain/bloc/product/product_bloc.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';
import 'package:shopywell/domain/models/user_model/user_details_modl.dart';
import 'package:shopywell/presentation/home/bottom_navigation.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class PaymentScreen extends StatelessWidget {
  final ProductDetailModel product;
  final UserDetailsModel user;
  const PaymentScreen({super.key, required this.product, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/paymt_success.png'),
                          kSizedBoxHeight(height: 15),
                          Text(
                            'Payment done successfully.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ],
                  );
                },
              );

              Future.delayed(Duration(seconds: 2), () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottonNavigationWithScreen(),
                  ),
                );
              });
            } else if (state is PaymentFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      Column(
                        children: [
                          Text(
                            state.errMessage,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  );
                },
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildSummaryRow('Order', '₹ ${product.price}',
                      isBold: false),
                  _buildSummaryRow('Shipping', '₹ 30', isBold: false),
                  const SizedBox(height: 10),
                  Divider(thickness: 1, color: Colors.grey),
                  _buildSummaryRow(
                      'Total', '₹ ${(product.price + 30).toStringAsFixed(2)}',
                      isBold: true),
                  const SizedBox(height: 20),
                  Text(
                    'Payment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentOption(0, 'Stripe', user.bankAccountNumber,
                      image: 'assets/images/stripe.png', isBlue: true),
                  const SizedBox(height: 10),
                  _buildPaymentOption(1, 'Apple Pay', user.bankAccountNumber,
                      icon: Icons.apple),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(RemoveFromCart(productId: product.id));
                      context.read<PaymentBloc>().add(
                          ProceedPayment(amount: (product.price + 30).toInt()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 17,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isBold ? Colors.black : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(int index, String name, String maskedNumber,
      {IconData? icon, String? image, bool isBlue = false}) {
    return GestureDetector(
      // onTap: () => selectPaymentMethod(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: index == 0 ? Colors.red : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, size: 24, color: Colors.black)
            else if (image != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(image),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '*********${maskedNumber.substring(maskedNumber.length - 4)}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
