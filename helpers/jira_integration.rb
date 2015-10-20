require 'sinatra'
require 'oauth'
require 'multi_json'

access_token ||= {}
access_token_secret ||= {}
request_token ||= {}
request_token_secret ||= {}

has_logged_in = false

if has_logged_in == false
  before do
    oauth ||= {}
    @consumer ||= OAuth::Consumer.new(
      'apptentive',
      OpenSSL::PKey::RSA.new(IO.read(File.dirname(__FILE__) + "/../rsa.pem")),
      {
      :site => 'https://apptentive.atlassian.net',
      :signature_method => 'RSA-SHA1',
      :scheme => :header,
      :http_method => :post,
      :request_token_path=> '/plugins/servlet/oauth/request-token',
      :access_token_path => '/plugins/servlet/oauth/access-token',
      :authorize_path => '/plugins/servlet/oauth/authorize'
    })
    @request_token = OAuth::RequestToken.new(@consumer, request_token, request_token_secret)
    $access_token = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)

    if has_logged_in == false
      has_logged_in = true
      redirect '/signin'
    end
  end
end

# http://<yourserver>/auth to get the $access_token
get '/signin' do
  @request_token = @consumer.get_request_token(:oauth_callback => "http://#{request.host}:#{request.port}/auth")
  request_token = @request_token.token
  request_token_secret = @request_token.secret
  redirect @request_token.authorize_url
end

# Retrieves the $access_token then stores it
get "/auth" do
  $access_token = @request_token.get_access_token :oauth_verifier => params[:oauth_verifier]
  access_token = $access_token.token
  access_token_secret = $access_token.secret
  redirect "/"
end
