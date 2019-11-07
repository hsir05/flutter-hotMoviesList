class HotModelEntity {
	int total;
	List<HotModelSubject> subjects;
	int count;
	int start;
	String title;

	HotModelEntity({this.total, this.subjects, this.count, this.start, this.title});

	HotModelEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['subjects'] != null) {
			subjects = new List<HotModelSubject>();(json['subjects'] as List).forEach((v) { subjects.add(new HotModelSubject.fromJson(v)); });
		}
		count = json['count'];
		start = json['start'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.subjects != null) {
      data['subjects'] =  this.subjects.map((v) => v.toJson()).toList();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		data['title'] = this.title;
		return data;
	}
}

class HotModelSubject {
	HotModelSubjectsImages images;
	String originalTitle;
	String year;
	List<HotModelSubjectsDirector> directors;
	HotModelSubjectsRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<HotModelSubjectsCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	HotModelSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	HotModelSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new HotModelSubjectsImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<HotModelSubjectsDirector>();(json['directors'] as List).forEach((v) { directors.add(new HotModelSubjectsDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new HotModelSubjectsRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates']?.cast<String>();
		if (json['casts'] != null) {
			casts = new List<HotModelSubjectsCast>();(json['casts'] as List).forEach((v) { casts.add(new HotModelSubjectsCast.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres']?.cast<String>();
		durations = json['durations']?.cast<String>();
		mainlandPubdate = json['mainland_pubdate'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.images != null) {
      data['images'] = this.images.toJson();
    }
		data['original_title'] = this.originalTitle;
		data['year'] = this.year;
		if (this.directors != null) {
      data['directors'] =  this.directors.map((v) => v.toJson()).toList();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['alt'] = this.alt;
		data['title'] = this.title;
		data['collect_count'] = this.collectCount;
		data['has_video'] = this.hasVideo;
		data['pubdates'] = this.pubdates;
		if (this.casts != null) {
      data['casts'] =  this.casts.map((v) => v.toJson()).toList();
    }
		data['subtype'] = this.subtype;
		data['genres'] = this.genres;
		data['durations'] = this.durations;
		data['mainland_pubdate'] = this.mainlandPubdate;
		data['id'] = this.id;
		return data;
	}
}

class HotModelSubjectsImages {
	String small;
	String large;
	String medium;

	HotModelSubjectsImages({this.small, this.large, this.medium});

	HotModelSubjectsImages.fromJson(Map<String, dynamic> json) {
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

class HotModelSubjectsDirector {
	String name;
	String alt;
	String id;
	HotModelSubjectsDirectorsAvatars avatars;
	String nameEn;

	HotModelSubjectsDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	HotModelSubjectsDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new HotModelSubjectsDirectorsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class HotModelSubjectsDirectorsAvatars {
	String small;
	String large;
	String medium;

	HotModelSubjectsDirectorsAvatars({this.small, this.large, this.medium});

	HotModelSubjectsDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class HotModelSubjectsRating {
	double average;
	int min;
	int max;
	HotModelSubjectsRatingDetails details;
	String stars;

	HotModelSubjectsRating({this.average, this.min, this.max, this.details, this.stars});

	HotModelSubjectsRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? new HotModelSubjectsRatingDetails.fromJson(json['details']) : null;
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['average'] = this.average;
		data['min'] = this.min;
		data['max'] = this.max;
		if (this.details != null) {
      data['details'] = this.details.toJson();
    }
		data['stars'] = this.stars;
		return data;
	}
}

class HotModelSubjectsRatingDetails {
	String rating1;
	String rating2;
	String rating3;
	String rating4;
	String rating5;

	HotModelSubjectsRatingDetails({this.rating1, this.rating2, this.rating3, this.rating4, this.rating5});

	HotModelSubjectsRatingDetails.fromJson(Map<String, dynamic> json) {
		rating1 = json['1'];
		rating2 = json['2'];
		rating3 = json['3'];
		rating4 = json['4'];
		rating5 = json['5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['rating11'] = this.rating1;
		data['rating12'] = this.rating2;
		data['rating13'] = this.rating3;
		data['rating14'] = this.rating4;
		data['rating15'] = this.rating5;
		return data;
	}
}

class HotModelSubjectsCast {
	String name;
	String alt;
	String id;
	HotModelSubjectsCastsAvatars avatars;
	String nameEn;

	HotModelSubjectsCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	HotModelSubjectsCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new HotModelSubjectsCastsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class HotModelSubjectsCastsAvatars {
	String small;
	String large;
	String medium;

	HotModelSubjectsCastsAvatars({this.small, this.large, this.medium});

	HotModelSubjectsCastsAvatars.fromJson(Map<String, dynamic> json) {
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
