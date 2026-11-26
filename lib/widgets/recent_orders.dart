import 'package:eat/data/data.dart';
import 'package:flutter/material.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            'Recent Orders',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 1),
            overflow: TextOverflow.clip,
          ),
        ),
        SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: buildRecentOrders(),
          ),
        ),
      ],
    );
  }

  Widget buildRecentOrders() {

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: currentUser.orders.length,
      itemBuilder: (context, index) {

        final orders = currentUser.orders[index];
        const double cardSize = 100;
        final textStyle = Theme.of(context).textTheme;

        return Padding(
         padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.black12),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    orders.food.imageUrl,
                    fit: BoxFit.cover,
                    height: cardSize,
                    width: cardSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orders.food.name,
                        style: textStyle.titleMedium,
                      ),
                      Text(
                        orders.restaurant.name,
                        style: textStyle.bodyMedium,
                      ),
                      Text(
                        orders.date,
                        style: textStyle.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {},
                  elevation: 0.0,
                  backgroundColor: Colors.deepOrange,
                  heroTag: 'Hero $index',
                  shape: const CircleBorder(),
                  
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
