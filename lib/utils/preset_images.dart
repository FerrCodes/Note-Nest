class PresetImages {
  static const List<Map<String, String>> images = [
    {
      'name': 'Forest',
      'url':
          'https://images.unsplash.com/photo-1790122387967-ffecd6ab8e8e?q=80&w=436&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Ocean',
      'url':
          'https://images.unsplash.com/photo-1505142468610-359e7d316be0?q=80&w=800&auto=format&fit=crop',
    },
    {
      'name': 'Mountain',
      'url':
          'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?q=80&w=800&auto=format&fit=crop',
    },
    {
      'name': 'Sky',
      'url':
          'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?q=80&w=800&auto=format&fit=crop',
    },
    {
      'name': 'Flowers',
      'url':
          'https://plus.unsplash.com/premium_photo-1751442185613-030272e824e0?q=80&w=1055&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Abstract',
      'url':
          'https://images.unsplash.com/photo-1550684376-efcbd6e3f031?q=80&w=800&auto=format&fit=crop',
    },
    {
      'name': 'Night',
      'url':
          'https://images.unsplash.com/photo-1782226768510-16de87e9166f?q=80&w=415&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Desert',
      'url':
          'https://images.unsplash.com/photo-1734605013460-45663eec2358?q=80&w=385&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
  ];

  static String getDefault() => images[0]['url']!;
}
