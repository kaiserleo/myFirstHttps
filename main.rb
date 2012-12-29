require 'rubygems'
require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'
require 'rack'
require 'rack/request'


class MyServer  < Sinatra::Base
    get '/' do
      "Hellow, world!"
    end
end

CERT_PATH = '/System/Library/OpenSSL/certs/'

webrick_options = {
        :Port               => 443,
        :Logger             => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG),
        :DocumentRoot       => "/ruby/htdocs",
        :SSLEnable          => true,
        :SSLVerifyClient    => OpenSSL::SSL::VERIFY_NONE,
        :SSLCertificate     => OpenSSL::X509::Certificate.new(  File.open(File.join(CERT_PATH, "kueski.test.crt")).read),
        :SSLPrivateKey      => OpenSSL::PKey::RSA.new(          File.open(File.join(CERT_PATH, "kueski.test.key")).read),
        :SSLCertName        => [ [ "CN",WEBrick::Utils::getservername ] ],
        :app                => MyServer
}
Rack::Server.start webrick_options
