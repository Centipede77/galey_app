class Photo {
  final int? id;
  final String filePath;
  final String thumbnailPath;
  final String title;
  final DateTime takenAt;
  final int width;
  final int height;
  final int fileSize;
  final List<String> tags;

  Photo({
    this.id,
    required this.filePath,
    required this.thumbnailPath,
    required this.title,
    required this.takenAt,
    required this.width,
    required this.height,
    required this.fileSize,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'filePath': filePath,
      'thumbnailPath': thumbnailPath,
      'title': title,
      'takenAt': takenAt.toIso8601String(),
      'width': width,
      'height': height,
      'fileSize': fileSize,
      'tags': tags.join(','),
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      filePath: map['filePath'],
      thumbnailPath: map['thumbnailPath'],
      title: map['title'],
      takenAt: DateTime.parse(map['takenAt']),
      width: map['width'],
      height: map['height'],
      fileSize: map['fileSize'],
      tags: map['tags'].split(','),
    );
  }
}