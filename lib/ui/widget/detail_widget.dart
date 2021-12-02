part of 'widget.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantDetailed restaurantDetailed;
  final RestaurantDetailProvider detailProvider;

  const DetailRestaurant({
    required this.restaurant,
    required this.restaurantDetailed,
    required this.detailProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                            child: Hero(
                                tag: restaurant.id,
                                child: Image.network(
                                  "${ApiService.imageUrl}medium/" + restaurant.pictureId,
                                  height: 350,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, left: 20),
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Color(0xFF98bd8f).withOpacity(0.50)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 275, left: 325),
                            child: FloatingActionButton(
                              backgroundColor: Color(0xFF98bd8f),
                              elevation: 0.0,
                              onPressed: () {
                                isFavorited;
                              },
                              child: isFavorited
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => provider.removeFavorite(restaurantDetailed.id),
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => provider.addFavorite(restaurant),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                            width: null,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black54,
                              ),
                              Text(
                                restaurant.city,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                restaurantDetailed.address,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              ),
                              Text(
                                restaurant.rating.toString(),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurantDetailed.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                                      child: Chip(
                                        backgroundColor: Color(0xFF98bd8f).withOpacity(0.7),
                                        label: Text(
                                          restaurantDetailed.categories[index].name,
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Tentang",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            restaurant.description,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Review", style: Theme.of(context).textTheme.subtitle2),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 130,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurantDetailed.customerReviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: SizedBox(
                                    width: 200,
                                    child: Card(
                                      color: Color(0xFF98bd8f),
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                restaurantDetailed.customerReviews[index].name,
                                                style: Theme.of(context).textTheme.bodyText2,
                                              ),
                                              Text(
                                                restaurantDetailed.customerReviews[index].date,
                                                style: Theme.of(context).textTheme.overline,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '\"' + restaurantDetailed.customerReviews[index].review + '\"',
                                                style: Theme.of(context).textTheme.bodyText1,
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Tambahkan review",
                              style: Theme.of(context).textTheme.button,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(provider: detailProvider, id: restaurantDetailed.id),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Menu", style: Theme.of(context).textTheme.subtitle2),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFcbdec7),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Foods',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: restaurantDetailed.menus.foods
                                        .map(
                                          (food) => Container(
                                            height: 100,
                                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      food.name,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    child: Image.asset("assets/food.png", height: 50, width: 50),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Drinks',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: restaurantDetailed.menus.drinks
                                        .map(
                                          (drink) => Container(
                                            height: 100,
                                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      drink.name,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    child: Image.asset("assets/drink.png", height: 50, width: 50),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}