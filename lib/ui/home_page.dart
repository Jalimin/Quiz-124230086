import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:quiz_124230086/data/food_list_data.dart';
import 'detail_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.username});
  final String username;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController searchController = TextEditingController();
  List gameFilter = dummyFoods; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), (route) => false);
            }, 
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('Selamat Datang, ${widget.username}!'),
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              
              decoration: InputDecoration(
                hintText: "Cari makanan...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                color: Colors.grey[300],
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8, 
                  ),
                  itemBuilder: (context, index){
                    return _gameModel(context, index);
                  }, 
                  itemCount: gameFilter.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gameModel(BuildContext context, int index) {
    return InkWell(  
     
      child: Card( 
        elevation: 2,
        child: Column(
          children: [
             Expanded(
              flex: 1,
              child: Container(
                width: double.infinity, 
                color: Colors.grey[300],
                child: gameFilter[index].image.isNotEmpty 
                  ? Image.asset(
                      gameFilter[index].image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.gamepad,
                      size: 40,
                      color: Colors.grey[600],
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        gameFilter[index].name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        gameFilter[index].category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                     Flexible(
                      child: Text(
                        gameFilter[index].description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
