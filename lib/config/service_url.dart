const serviceUrl= 'https://api.douban.com/v2/movie';
const apikey = '0b2bdeda43b5688921839c8ecb20399b';

const servicePath={ 
  // 'hotPageContext': serviceUrl+'/in_theaters?city=%E5%8C%97%E4%BA%AC&start=0&count=40&apikey=0b2bdeda43b5688921839c8ecb20399b', 
  'hotPageContext': serviceUrl+'/in_theaters', 
  'detailPageContext': serviceUrl,
  'upComContext': serviceUrl+'/coming_soon?start=0&count=10&apikey=$apikey', 
  'top250Context': serviceUrl + '/top250?apikey=$apikey&city=%E5%8C%97%E4%BA%AC&start=0&count=4&client=&udid=',

  'opinionsContext': serviceUrl + '/weekly?apikey=$apikey',
  'northAmericaContext': serviceUrl + '/us_box?apikey=$apikey',
  'newMovisContext': serviceUrl + '/new_movies?apikey=$apikey',
  'movieDetailContext': serviceUrl + '/subject',
  // 电影条目剧照
  'moviePhotosContext': serviceUrl + '/subject',
  // 影人条目信息
  'celebrityContext': serviceUrl + '/celebrity'
};
