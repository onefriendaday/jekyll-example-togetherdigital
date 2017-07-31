require 'rack/jekyll'
require 'jekyll'
require 'yaml'
require 'fileutils'

class Rebuilder
  def self.call(env)
    FileUtils.rm_rf("./_site/.", secure: true)

    conf = Jekyll.configuration({
      'source'      => './',
      'destination' => './_site'
    })

    Jekyll::Site.new(conf).process

    [200, { "Content-Type" => "text/plain" }, ["OK"]]
  end
end


app = Rack::Builder.new do
  map "/rebuild" do
    run Rebuilder
  end

  map "/" do
    run Rack::Jekyll.new
  end
end

run app