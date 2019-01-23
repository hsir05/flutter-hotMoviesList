class Config{
   String base_url = "https://api.douban.com/v2/movie";
  //连接服务器超时时间，单位是毫秒.
  int connectTimeout = 10000;

  ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
  ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
  ///  注意: 这并不是接收数据的总时限.
  int receiveTimeout = 3000;
}