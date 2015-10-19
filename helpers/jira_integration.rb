require 'sinatra'
require 'oauth'
require 'multi_json'

# Here, we set up the
# OAuth consumer details including the consumer key, private key,
# site uri, and the request token, access token, and authorize paths
before do
  session[:oauth] ||= {}

  # Set up the consumer
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

  # This logs the HTTP req/resp to the application's log. Useful for debugging the requests
  @consumer.http.set_debug_output($stderr)

  # Here we store the request token/secret in the session cookie
  if !session[:oauth][:request_token].nil? && !session[:oauth][:request_token_secret].nil?
    @request_token = OAuth::RequestToken.new(@consumer, session[:oauth][:request_token], session[:oauth][:request_token_secret])
  end

  if !session[:oauth][:access_token].nil? && !session[:oauth][:access_token_secret].nil?
    $access_token = OAuth::AccessToken.new(@consumer, session[:oauth][:access_token], session[:oauth][:access_token_secret])
  end
end

# Starting point: http://<yourserver>/
# This will serve up a login link if you're not logged in. If you are, it'll show some user info and a
# signout link
get '/jira' do
  if !session[:oauth][:access_token]
    # not logged in
    "<h1>JIRA REST API OAuth Demo</h1>You're not signed in. Why don't you <a href=/signin>sign in</a> first."
  else
    #logged in

    # You'll need to sign each request to the API by using $access_token.<method>.
    # Once we have the response, we grab the body then run it through a JSON decoder
    user = MultiJson.decode($access_token.get('/rest/auth/latest/session',
                                              {'Accept' => 'application/json'}).body)
    server = MultiJson.decode($access_token.get('/rest/api/latest/serverInfo',
                                              {'Accept' => 'application/json'}).body)
    # ticket = MultiJson.decode($access_token.get('/rest/api/latest/issue/MARCOM-94',
    #                                           {'Accept' => 'application/json'}).body)

    # HTTP response inlined with bind data below...
    <<-eos
      <h1>Welcome #{user['name']}!</h1>
      You have logged in #{user['loginInfo']['loginCount']} times.
      This app is accessing <a href='#{server['baseUrl']}'>#{server['serverTitle']}</a>
      version #{server['version']}. <a href='/signout'>Signout</a>"
    eos
  end
end

# http://<yourserver>/signin
# Initiates the OAuth dance by first requesting a token then redirecting to
# http://<yourserver>/auth to get the $access_token
get '/signin' do
  @request_token = @consumer.get_request_token(:oauth_callback => "http://#{request.host}:#{request.port}/auth")
  session[:oauth][:request_token] = @request_token.token
  session[:oauth][:request_token_secret] = @request_token.secret
  redirect @request_token.authorize_url
end

# http://<yourserver>/auth
# Retrieves the $access_token then stores it inside a session cookie. 
get "/auth" do
  $access_token = @request_token.get_access_token :oauth_verifier => params[:oauth_verifier]
  session[:oauth][:access_token] = $access_token.token
  session[:oauth][:access_token_secret] = $access_token.secret
  redirect "/"
end

# http://<yourserver>/signout
# Expires the session
get "/signout" do
  session[:oauth] = {}
  @current_user = nil
  redirect "/"
end

get "/test" do
  ticket = $access_token.get('/rest/api/latest/issue/MARCOM-94').body
end
