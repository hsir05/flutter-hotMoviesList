const serviceUrl= 'https://api.douban.com/v2/movie';

const servicePath={ 
  // 'hotPageContext': serviceUrl+'/in_theaters?city=%E5%8C%97%E4%BA%AC&start=0&count=40&apikey=0b2bdeda43b5688921839c8ecb20399b', 
  'hotPageContext': serviceUrl+'/in_theaters', 
  'detailPageContext': serviceUrl,
  'upComContext': serviceUrl+'/coming_soon?start=0&count=10&apikey=0b2bdeda43b5688921839c8ecb20399b', 
  'top250Context': serviceUrl + '/top250?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=4&client=&udid=',

  'opinionsContext': serviceUrl + '/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b',
  'northAmericaContext': serviceUrl + 'us_box?apikey=0b2bdeda43b5688921839c8ecb20399b'
};
