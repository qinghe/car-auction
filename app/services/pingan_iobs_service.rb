class PinganIobsService
  attr_accessor :file

  def self.upload_bids_image( auction )

  end

  def call
    String host= "http://iobs-test.paic.com.cn";

 		String bucket = "iobs-sf-dev";

 		String key="iobstest";

 		File file = new File("D://image//timg.jpg");

    string url = host + "/upload/"+bucket + "/"+ key
 		String token = get_token();

		begin

      response = HTTP.post(url, :form => {
        :token => "token",
        :avatar   => HTTP::FormData::File.new(file)
      })

    rescure => err

    end
  end


  def get_token
    ""
  end
end
