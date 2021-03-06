require 'test_helper'

context 'Rack::Analytics::RequestParser' do
  helper(:request) { {"HTTP_HOST"=>"example.org", "SERVER_NAME"=>"example.org",
                      "HTTP_USER_AGENT"=>"Firefox", "PATH_INFO"=>"/", "SERVER_PORT"=>"80",
                      "REQUEST_METHOD"=>"GET", "QUERY_STRING"=>"", "HTTP_REFERER"=> "http://www.google.com"} }

  setup { Rack::Analytics::RequestParser.new }

  context "should parse the default attributes correctly" do
    hookup { topic.parse(request) }

    asserts('it should save the time') { topic.data['time'] }.kind_of Time
    asserts('it should save the path') { topic.data['path'] }.equals '/'
    asserts('it should save the user agent') { topic.data['user_agent'] }.equals 'Firefox'
    asserts('it should save the referral') { topic.data['referral'] }.equals 'http://www.google.com'
  end

  context "should accept exceptions" do
    asserts ('it should accept single arguments') do
      topic.except = 'time'
      topic.parse(request).data['time']
    end.nil

    asserts ('it should accept multiple values as arguments') do
      topic.except = ['time']
      topic.parse(request).data['time']
    end.nil
  end

  context "should handle 'only'" do
    asserts ('it should accept single arguments') do
      topic.only = 'time'
      topic.parse(request).data['path']
    end.nil

    asserts ('it should accept multiple values as arguments') do
      topic.except = ['time', 'path']
      topic.parse(request).data['user_agent']
    end.nil
  end

  context "should accept custom fields" do
    asserts('it should receive the custom fields') do
      topic << lambda { |env, data| data['port'] = env['SERVER_PORT'] }
      topic.parse(request).data['port']
    end.equals '80'

    asserts('it should raise TypeError when receiving non-callables') do
      topic << 0
      topic.parse request
    end.raises TypeError
  end
end
