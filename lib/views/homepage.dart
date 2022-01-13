import 'package:flutter/material.dart';
import 'package:flutter_googlesheet_example/data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> data = [];
  getData() async {
    var response = await http.get(Uri.parse(
        'https://script.googleusercontent.com/macros/echo?user_content_key=UCSXd1mavhzozfk_iAGBtZopkNdGCR89G9yuLx-EQe_HqP6tz3NaNlj_BJW9cF1YtNkfSiGwu4f7m-NqjFfmGIsQmEbBc0lOm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnGbDV-hw1hGF-H0ZHUv5swI8LZOP0sYooLaKkGbyufa4HtuNv6zUWt_t3eaCwcH6gF35y9MSrqEB&lib=MOd33BlShGFmEvPfoop-QrCbvz7j8zAGf'));

    var jsonData = convert.jsonDecode(response.body);
    print('This is json Feedback $jsonData');

    jsonData.forEach((element) {
      print('$element next data....');

      Data d = new Data();
      d.title = element['title'];
      d.content = element['content'];
      d.photo_url = element['photo_url'];

      data.add(d);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return DataTile(
              photo_url: data[index].photo_url,
              title: data[index].title,
              content: data[index].content,
            );
          },
        ),
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  final String title, content, photo_url;

  DataTile({Key key, this.title, this.content, this.photo_url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: Image.network(photo_url),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text(
                    content,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
