require 'teststrap'

describe Rack::Analytics::Application do
  context "should render a get request correctly" do
    setup { get '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  context "should render a get request on a inner path correctly" do
    setup { get '/inner-page' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "inner page"
  end

  context "should render a post request correctly" do
    setup { post '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  context "should render a put request correctly" do
    setup { put '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  #it "should render a delete request correctly" do
    #delete '/'

    #last_response.should be_ok
    #last_response.body.should == "homepage with delete"
  #end

  #it "should increment access counter of the root page" do
    #db.set("#{namespace}:/:views", 0)

    #get '/'

    #db.get("#{namespace}:/:views").should == "1"
  #end

  #it "should not increment access counter on requests other than get" do
    #db.set("#{namespace}:/:views", 0)

    #post '/'
    #put '/'
    #delete '/'

    #db.get("#{namespace}:/:views").should == "0"
  #end

  #it "should save the referers informations" do
    #db.del "#{namespace}:/:referers"

    #get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'

    #MessagePack.unpack(db.get("#{namespace}:/:referers")).should == {'http://www.google.com' => 1}

    #get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'

    #MessagePack.unpack(db.get("#{namespace}:/:referers")).should == {'http://www.google.com' => 2}
  #end
end