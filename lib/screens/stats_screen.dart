import 'package:flutter/material.dart';
import '../repositories/photo_repository.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final repo = PhotoRepository();
  int count = 0;
  int size = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final stats = await repo.getStats();
    setState(() {
      count = stats['count'];
      size = stats['size'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stats")),
      body: Column(
        children: [
          Text("Photos: $count"),
          Text("Total size: $size bytes"),
        ],
      ),
    );
  }
}