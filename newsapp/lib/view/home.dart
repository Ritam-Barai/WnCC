import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Help/data.dart';
import 'package:newsapp/Help/news.dart';
import 'package:newsapp/model/article_model.dart';
import 'package:newsapp/model/category_model.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:newsapp/view/article.dart';

import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> category =  <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategories();
    getNews();
  }
  getNews() async{
    News newsCLass = News();
    await newsCLass.getNews();
    articles = newsCLass.news;
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("NEWS"),
            Text("TIME", style: TextStyle(
              color:Colors.blue
            ),)
          ],
        ),
        elevation: 0.0,
      ),
      body: loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              /// Categories
              Container(
                padding: EdgeInsets.symmetric(horizontal:16),
                height:70,
                child:ListView.builder(
                  itemCount: category.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return CategoryTile(
                      imageURL: category[index].imageURL,
                      categoryName: category[index].categoryName,
                    );
                }),
              ),

              ///Cards
              Container(
                padding:EdgeInsets.only(top: 16),
                /*child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return BlogCard(
                          imageURL: articles[index].urlToImage,
                          title:articles[index].title,
                          desc: articles[index].description,
                      );
                    }
                ),*/
                 child:  Swiper(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BlogCard(
                          imageURL: articles[index].urlToImage,
                          title:articles[index].title,
                          desc: articles[index].description,
                          url:articles[index].url
                      ),
                    );
                  },
                   itemHeight: 550,
                   itemWidth: 400,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  layout: SwiperLayout.TINDER,
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}

class CategoryTile extends StatelessWidget {

  final imageURL,categoryName;
  CategoryTile({this.imageURL,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toLowerCase(),
            ),
          ),
        );

      },
      child: Container(
        margin: EdgeInsets.only(right:16),
        child:Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageURL, width:120, height:60,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
                width:120,
                height:60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child:Text(categoryName,style:TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
               )
              )
            ),
          ],
        ),

      ),
    );
  }
}

class BlogCard extends StatelessWidget {

  final String imageURL,title,desc,url;
  BlogCard({@required this.imageURL,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Article(

            )
        ));
      },
      child: Container(
        margin:EdgeInsets.only(bottom: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start ,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(imageURL)),
                SizedBox(height:15),
                Text(title,style: TextStyle(
                  fontSize: 25
                ),),
                SizedBox(height:20),
                Text(desc, style: TextStyle(
                    fontSize: 17,
                  color: Colors.black54
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


