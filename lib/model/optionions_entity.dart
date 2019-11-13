class OptionionsEntity {
	List<OptionionsSubject> subjects;
	String title;

	OptionionsEntity({this.subjects, this.title});

	OptionionsEntity.fromJson(Map<String, dynamic> json) {
		if (json['subjects'] != null) {
			subjects = new List<OptionionsSubject>();(json['subjects'] as List).forEach((v) { subjects.add(new OptionionsSubject.fromJson(v)); });
		}
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.subjects != null) {
      data['subjects'] =  this.subjects.map((v) => v.toJson()).toList();
    }
		data['title'] = this.title;
		return data;
	}
}

class OptionionsSubject {
	OptionionsSubjectsSubject subject;
	int delta;
	int rank;

	OptionionsSubject({this.subject, this.delta, this.rank});

	OptionionsSubject.fromJson(Map<String, dynamic> json) {
		subject = json['subject'] != null ? new OptionionsSubjectsSubject.fromJson(json['subject']) : null;
		delta = json['delta'];
		rank = json['rank'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['delta'] = this.delta;
		data['rank'] = this.rank;
		return data;
	}
}

class OptionionsSubjectsSubject {
	OptionionsSubjectsSubjectImages images;
	String originalTitle;
	String year;
	List<OptionionsSubjectsSubjectDirector> directors;
	OptionionsSubjectsSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<OptionionsSubjectsSubjectCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	OptionionsSubjectsSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	OptionionsSubjectsSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new OptionionsSubjectsSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<OptionionsSubjectsSubjectDirector>();(json['directors'] as List).forEach((v) { directors.add(new OptionionsSubjectsSubjectDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new OptionionsSubjectsSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates']?.cast<String>();
		if (json['casts'] != null) {
			casts = new List<OptionionsSubjectsSubjectCast>();(json['casts'] as List).forEach((v) { casts.add(new OptionionsSubjectsSubjectCast.fromJson(v)); });
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

class OptionionsSubjectsSubjectImages {
	String small;
	String large;
	String medium;

	OptionionsSubjectsSubjectImages({this.small, this.large, this.medium});

	OptionionsSubjectsSubjectImages.fromJson(Map<String, dynamic> json) {
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

class OptionionsSubjectsSubjectDirector {
	String name;
	String alt;
	String id;
	OptionionsSubjectsSubjectDirectorsAvatars avatars;
	String nameEn;

	OptionionsSubjectsSubjectDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	OptionionsSubjectsSubjectDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new OptionionsSubjectsSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class OptionionsSubjectsSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	OptionionsSubjectsSubjectDirectorsAvatars({this.small, this.large, this.medium});

	OptionionsSubjectsSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class OptionionsSubjectsSubjectRating {
	double average;
	int min;
	int max;
	String stars;

	OptionionsSubjectsSubjectRating({this.average, this.min, this.max, this.stars});

	OptionionsSubjectsSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['average'] = this.average;
		data['min'] = this.min;
		data['max'] = this.max;
		data['stars'] = this.stars;
		return data;
	}
}

class OptionionsSubjectsSubjectCast {
	String name;
	String alt;
	String id;
	OptionionsSubjectsSubjectCastsAvatars avatars;
	String nameEn;

	OptionionsSubjectsSubjectCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	OptionionsSubjectsSubjectCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new OptionionsSubjectsSubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class OptionionsSubjectsSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	OptionionsSubjectsSubjectCastsAvatars({this.small, this.large, this.medium});

	OptionionsSubjectsSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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
