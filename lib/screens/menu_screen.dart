import 'package:eat/models/restaurant.dart';
import 'package:eat/widgets/rating.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Hero(
                 tag: widget.restaurant.imageUrl,
                  child: Image.asset(
                    widget.restaurant.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28.0, vertical: 28.0),
                child: Row(
                  children: [
                    CustomButton(
                      heroTag: 'arrow_back',
                      icon: Icons.arrow_back,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    CustomButton(
                      heroTag: 'fav',
                      icon:
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          RestaurantDescriptionWidget(restaurantVar: widget.restaurant),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialCustomButton(label: 'Reviews'),
              MaterialCustomButton(label: 'Contact'),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Menu',
            style: textStyle.headlineMedium!.copyWith(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.restaurant.menu.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image:
                            AssetImage(widget.restaurant.menu[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.black38,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.restaurant.menu[index].name,
                                      style: textStyle.headlineMedium!.copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '\$ ${widget.restaurant.menu[index].price.toString()}',
                                      style: textStyle.headlineMedium!.copyWith(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomButton(
                                      heroTag: 'hero $index',
                                      icon: Icons.add_rounded,
                                      onTap: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.heroTag});
  final IconData icon;
  final VoidCallback onTap;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      elevation: 0.0,
      highlightElevation: 0.0,
      heroTag: heroTag,
      onPressed: (onTap),
      child: Icon(icon),
    );
  }
}

class RestaurantDescriptionWidget extends StatelessWidget {
  const RestaurantDescriptionWidget({super.key, required this.restaurantVar});

  final Restaurant restaurantVar;
  final double spaceBetweenTexts = 6.0;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                restaurantVar.name,
                style: textStyle.headlineMedium!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Spacer(),
              Text(
                '0.3 mile away',
                style: textStyle.headlineMedium!
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          Text(
            getRating(restaurantVar.rating),
            style: textStyle.headlineMedium!.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: spaceBetweenTexts,
          ),
          Text(
            restaurantVar.address,
            style: textStyle.headlineMedium!
                .copyWith(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class MaterialCustomButton extends StatelessWidget {
  const MaterialCustomButton({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: MaterialButton(
        height: 50,
        minWidth: 160,
        elevation: 0.0,
        highlightElevation: 0.0,
        color: Colors.deepOrange,
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
