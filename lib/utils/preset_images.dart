class PresetImages {
  static const List<Map<String, String>> images = [
    {'name': 'Forest', 'url': 'assets/presets/photo-1.jpg'},
    {'name': 'Ocean', 'url': 'assets/presets/photo-2.jpg'},
    {'name': 'Mountain', 'url': 'assets/presets/photo-3.jpg'},
    {'name': 'Sky', 'url': 'assets/presets/photo-4.jpg'},
    {'name': 'Flowers', 'url': 'assets/presets/photo-5.jpg'},
    {'name': 'Abstract', 'url': 'assets/presets/photo-6.jpg'},
    {'name': 'Night', 'url': 'assets/presets/photo-7.jpg'},
    {'name': 'Desert', 'url': 'assets/presets/photo-8.jpg'},
  ];

  static String getDefault() => images[0]['url']!;
}
