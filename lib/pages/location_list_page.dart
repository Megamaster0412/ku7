import 'package:flutter/material.dart';

import 'package:google_map_app/pages/location_detail_page.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  TextEditingController _searchController = TextEditingController();
  List<Location> locations = [
    Location(
      name: 'อาคาร 45 ปีคณะวิทยาศาสตร์',
      landmark: 'อยู่ตรงข้ามกับคณะวิศวกรรมศาสตร์',
      details: 'อาคารรวมสำหรับสาขาในคณะวิทยาศาสตร์',
      imagePath: 'assets/images/location1.jpg',
      latitude: 13.905849646995938, // Latitude of the location
      longitude: 100.60349464085135, // Longitude of the location
    ),
    Location(
      name: 'อาคารจักรพันธ์เพ็ญศิริ',
      landmark: 'อาคารขนาดใหญ่อยู่ติดกับศูนย์เรียนรวม 2 3 และ 4',
      details: 'อาคารขนาดใหญ่',
      imagePath: 'assets/images/location2.jpg',
      latitude: 13.849805372964815, // Example latitude
      longitude: 100.56830608503942, // Example longitude
    ),
    Location(
      name: 'โรงอาหารกลาง 1 ',
      landmark: '(บาร์ใหม่)',
      details: 'เปิดให้บริการทุกวัน ไม่เว้นวันหยุดราชการ',
      imagePath: 'assets/images/canteen1.jpg',
      latitude: 13.848809549837272,  // Example latitude
      longitude: 100.56694995491277, // Example longitude
    ),
    Location(
      name: 'โรงอาหารกลาง 2 ',
      landmark: '(บาร์ใหม่กว่า)',
      details: 'เปิดให้บริการวันจันทร์ – วันเสาร์ หยุดวันอาทิตย์',
      imagePath: 'assets/images/canteen2.jpg',
      latitude: 13.85204405272875,   // Example latitude
      longitude: 100.57179353265312, // Example longitude
    ),
    Location(
      name: 'KU AVENUE ',
      landmark: '(Community Mall ที่รวมร้านอาหาร เครื่องดื่ม ร้านจำหน่ายผัก ผลไม้ และบริการทันตกรรม สื่อสิ่งพิมพ์)',
      details: 'เ เปิดให้บริการทุกวัน ไม่เว้นวันหยุดราชาการ เวลา06.00-21.00',
      imagePath: 'assets/images/KUAvenue.jpg',
      latitude: 13.846259035222511,    // Example latitude
      longitude: 100.56488042264347, // Example longitude
    ),
    Location(
      name: 'โรงอาหารคณะสัตวแพทยศาสตร์',
      landmark: 'คณะสัตวแพทยศาสตร์ ใกล้กับคณะเทคนิคการสัตวแพทย์',
      details: 'เวลาให้บริการ 5.00 - 19.00 น.',
      imagePath: 'assets/images/canteen3.png',
      latitude: 13.845050205855127,     // Example latitude
      longitude: 100.57708292265762, // Example longitude
    ),
    Location(
      name: 'ห้องอาหารแก้วเกษตร (ภาควิชาคหกรรมศาสตร์)',
      landmark: 'คอาคารวิทยบริการ (บริเวณด้านหลังศูนย์หนังสือ มก.)',
      details: 'เวลาให้บริการ 8.30 - 14.00 น.',
      imagePath: 'assets/images/canteen4.png',
      latitude: 13.843687243127363,      // Example latitude
      longitude: 100.57101893619586, // Example longitude
    ),
    Location(
      name: 'โรงอาหารคณะบริหารธุรกิจ (บาร์บริหาร)',
      landmark: 'คณะบริหารธุรกิจ (ฝั่ง Starbucks) และใกล้กับคณะเศรษฐศาสตร์',
      details: 'เวลาให้บริการ 6.30 - 18.30 น.',
      imagePath: 'assets/images/canteen5.png',
      latitude: 13.843955466353528,       // Example latitude
      longitude: 100.56873731379599, // Example longitude
    ),
    Location(
      name: 'โรงอาหารคณะวิทยาศาสตร์ (บาร์วิทย์)',
      landmark: 'คณะวิทยาศาสตร์ และ ใกล้กับศร.1',
      details: 'เวลาให้บริการ 6.30 - 17.00 น.',
      imagePath: 'assets/images/canteen6.png',
      latitude: 13.846044191533514,        // Example latitude
      longitude: 100.57130531781951,  // Example longitude
    ),
    Location(
      name: 'โรงอาหารคณะวิศวกรรมศาสตร์ (บาร์วิศวะ IUP)',
      landmark: 'คณะวิศวกรรมศาสตร์ และใกล้กับ ศร.1  ',
      details: 'เวลาให้บริการ 5.30 - 18.00 น.',
      imagePath: 'assets/images/canteen7.png',
      latitude: 13.846283249786017,         // Example latitude
      longitude: 100.56970925660906,  // Example longitude
    ),
    Location(
      name: 'โรงอาหารคณะเกษตร (บาร์เกษตร)',
      landmark: 'คณะเกษตร และใกล้กับคณะมนุษยศาสตร์',
      details: 'เวลาให้บริการ 7.00 - 15.00 น.',
      imagePath: 'assets/images/canteen8.png',
      latitude: 13.849450064163179,       // Example latitude
      longitude: 100.57202722884936,  // Example longitude
    ),
    Location(
      name: 'โรงอาหารคณะประมง',
      landmark: 'คณะประมง และใกล้กับคณะสิ่งแวดล้อม',
      details: 'เวลาให้บริการ 6.00 - 14.00 น.',
      imagePath: 'assets/images/canteen9.png',
      latitude: 13.857843155750736,    // Example latitude
      longitude: 100.56840557662659,  // Example longitude
    ),
    Location(
      name: 'ห้องอาหารสหโภชน์ (สถาบันค้นคว้าและพัฒนาผลิตภัณฑ์อาหาร)',
      landmark: 'สถาบันค้นคว้าและพัฒนาผลิตภัณฑ์อาหาร และใกล้กับอาคารสารนิเทศ 50 ปี',
      details: 'เวลาให้บริการ 7.00 - 14.00 น.',
      imagePath: 'assets/images/canteen10.png',
      latitude: 13.853740693018077,     // Example latitude
      longitude: 100.57060471346335, // Example longitude
    ),
    Location(
        name: 'โรงอาหารคณะสถาปัตยกรรมศาสตร์',
        landmark: 'คณะสถาปัตยกรรมศาสตร์',
        details: 'เวลาให้บริการ 5.00 - 18.00 น.',
        imagePath: 'assets/images/canteen11.png',
        latitude: 13.853740693018077,     // Example latitude
        longitude: 100.57060471346335, // Example longitude
    ),
    Location(
        name: 'โรงอาหารคณะวนศาสตร์',
        landmark: 'คณะวนศาสตร์',
        details: 'เวลาให้บริการ 6.00 - 15.00น.',
        imagePath: 'assets/images/canteen12.png',
        latitude: 13.845918184682365,  // Example latitude
        longitude: 100.57432135769682,    // Example longitude
    ),
    // Add more locations as needed
  ];
  List<Location> filteredLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    filteredLocations.clear();
                  } else {
                    filteredLocations = locations
                        .where((location) => location.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Search locations...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredLocations.isNotEmpty
                ? ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredLocations[index].name),
                  leading: Image.asset(
                    filteredLocations[index].imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationDetails(
                          location: filteredLocations[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )
                : Center(
              child: Text('Type in the search field to find locations'),
            ),
          ),
        ],
      ),
    );
  }
}

class Location {
  final String name;
  final String landmark;
  final String details;
  final String imagePath;
  final double latitude; // Latitude of the location
  final double longitude; // Longitude of the location

  Location({
    required this.name,
    required this.landmark,
    required this.details,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });
}
