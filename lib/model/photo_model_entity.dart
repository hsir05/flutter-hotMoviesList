class PhotoModel {
  int count;
  List<Photos> photos;
  int total;
  int start;
  Subject subject;

  PhotoModel({this.count, this.photos, this.total, this.start, this.subject});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    total = json['total'];
    start = json['start'];
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['start'] = this.start;
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    return data;
  }
}

class Photos {
  int photosCount;
  String thumb;
  String icon;
  Author author;
  String createdAt;
  String albumId;
  String cover;
  String id;
  String prevPhoto;
  String albumUrl;
  int commentsCount;
  String image;
  int recsCount;
  int position;
  String alt;
  String albumTitle;
  String nextPhoto;
  String subjectId;
  String desc;

  Photos(
      {this.photosCount,
      this.thumb,
      this.icon,
      this.author,
      this.createdAt,
      this.albumId,
      this.cover,
      this.id,
      this.prevPhoto,
      this.albumUrl,
      this.commentsCount,
      this.image,
      this.recsCount,
      this.position,
      this.alt,
      this.albumTitle,
      this.nextPhoto,
      this.subjectId,
      this.desc});

  Photos.fromJson(Map<String, dynamic> json) {
    photosCount = json['photos_count'];
    thumb = json['thumb'];
    icon = json['icon'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    createdAt = json['created_at'];
    albumId = json['album_id'];
    cover = json['cover'];
    id = json['id'];
    prevPhoto = json['prev_photo'];
    albumUrl = json['album_url'];
    commentsCount = json['comments_count'];
    image = json['image'];
    recsCount = json['recs_count'];
    position = json['position'];
    alt = json['alt'];
    albumTitle = json['album_title'];
    nextPhoto = json['next_photo'];
    subjectId = json['subject_id'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photos_count'] = this.photosCount;
    data['thumb'] = this.thumb;
    data['icon'] = this.icon;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['created_at'] = this.createdAt;
    data['album_id'] = this.albumId;
    data['cover'] = this.cover;
    data['id'] = this.id;
    data['prev_photo'] = this.prevPhoto;
    data['album_url'] = this.albumUrl;
    data['comments_count'] = this.commentsCount;
    data['image'] = this.image;
    data['recs_count'] = this.recsCount;
    data['position'] = this.position;
    data['alt'] = this.alt;
    data['album_title'] = this.albumTitle;
    data['next_photo'] = this.nextPhoto;
    data['subject_id'] = this.subjectId;
    data['desc'] = this.desc;
    return data;
  }
}

class Author {
  String uid;
  String avatar;
  String signature;
  String alt;
  String id;
  String name;

  Author({this.uid, this.avatar, this.signature, this.alt, this.id, this.name});

  Author.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    signature = json['signature'];
    alt = json['alt'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['avatar'] = this.avatar;
    data['signature'] = this.signature;
    data['alt'] = this.alt;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Subject {
  Rating rating;
  List<String> genres;
  String title;
  List<Casts> casts;
  List<String> durations;
  int collectCount;
  String mainlandPubdate;
  bool hasVideo;
  String originalTitle;
  String subtype;
  // List<Directors> directors;
  List<String> pubdates;
  String year;
  Avatars images;
  String alt;
  String id;

  Subject(
      {this.rating,
      this.genres,
      this.title,
      this.casts,
      this.durations,
      this.collectCount,
      this.mainlandPubdate,
      this.hasVideo,
      this.originalTitle,
      this.subtype,
      // this.directors,
      this.pubdates,
      this.year,
      this.images,
      this.alt,
      this.id});

  Subject.fromJson(Map<String, dynamic> json) {
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    genres = json['genres'].cast<String>();
    title = json['title'];
    if (json['casts'] != null) {
      casts = new List<Casts>();
      json['casts'].forEach((v) {
        casts.add(new Casts.fromJson(v));
      });
    }
    durations = json['durations'].cast<String>();
    collectCount = json['collect_count'];
    mainlandPubdate = json['mainland_pubdate'];
    hasVideo = json['has_video'];
    originalTitle = json['original_title'];
    subtype = json['subtype'];
    // if (json['directors'] != null) {
    //   directors = new List<Directors>();
    //   json['directors'].forEach((v) {
    //     directors.add(new Directors.fromJson(v));
    //   });
    // }
    pubdates = json['pubdates'].cast<String>();
    year = json['year'];
    images =
        json['images'] != null ? new Avatars.fromJson(json['images']) : null;
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['genres'] = this.genres;
    data['title'] = this.title;
    if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
    data['durations'] = this.durations;
    data['collect_count'] = this.collectCount;
    data['mainland_pubdate'] = this.mainlandPubdate;
    data['has_video'] = this.hasVideo;
    data['original_title'] = this.originalTitle;
    data['subtype'] = this.subtype;
    // if (this.directors != null) {
    //   data['directors'] = this.directors.map((v) => v.toJson()).toList();
    // }
    data['pubdates'] = this.pubdates;
    data['year'] = this.year;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }
}

class Rating {
  int max;
  double average;
  Details details;
  String stars;
  int min;

  Rating({this.max, this.average, this.details, this.stars, this.min});

  Rating.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    average = json['average'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    stars = json['stars'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['average'] = this.average;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['stars'] = this.stars;
    data['min'] = this.min;
    return data;
  }
}

class Details {
  int i1;
  int i2;
  int i3;
  int i4;
  int i5;

  Details({this.i1, this.i2, this.i3, this.i4, this.i5});

  Details.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.i1;
    data['2'] = this.i2;
    data['3'] = this.i3;
    data['4'] = this.i4;
    data['5'] = this.i5;
    return data;
  }
}

class Casts {
  Avatars avatars;
  String nameEn;
  String name;
  String alt;
  String id;

  Casts({this.avatars, this.nameEn, this.name, this.alt, this.id});

  Casts.fromJson(Map<String, dynamic> json) {
    avatars =
        json['avatars'] != null ? new Avatars.fromJson(json['avatars']) : null;
    nameEn = json['name_en'];
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name_en'] = this.nameEn;
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }
}

class Avatars {
  String small;
  String large;
  String medium;

  Avatars({this.small, this.large, this.medium});

  Avatars.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}