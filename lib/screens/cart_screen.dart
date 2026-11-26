import 'package:eat/models/order.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.cart});
  final List<Order> cart;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final double imageSize = 130;
  final double spaceBetweenTexts = 3;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final double totalCost = widget.cart.fold(
      0,
      (sum, item) => sum + (item.food.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart (${widget.cart.length})',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: Colors.black12,
                thickness: 2,
              ),
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final order = widget.cart[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          order.food.imageUrl,
                          fit: BoxFit.cover,
                          height: imageSize,
                          width: imageSize,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.food.name,
                                style: textStyle.headlineMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: spaceBetweenTexts,
                              ),
                              Text(
                                order.restaurant.name,
                                style: textStyle.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 35,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.deepOrangeAccent.shade200,
                                    width: 2.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (order.quantity > 1) {
                                            order.quantity--;
                                          }
                                        });
                                      },
                                      child: Text(
                                        '-',
                                        style: textStyle.headlineMedium!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      order.quantity.toString(),
                                      style: textStyle.headlineMedium!.copyWith(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          order.quantity++;
                                        });
                                      },
                                      child: Text(
                                        '+',
                                        style: textStyle.headlineMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '\$ ${(order.food.price * order.quantity).toStringAsFixed(2)}',
                        style: textStyle.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(
              height: 1,
              color: Colors.black12,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estimated Delivery Time:',
                        style: textStyle.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '25 mins',
                        style: textStyle.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total cost:',
                        style: textStyle.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${totalCost.toStringAsFixed(2)}',
                        style: textStyle.headlineMedium!.copyWith(
                            color: Colors.orange,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'CHECKOUT',
                        style: textStyle.headlineMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
