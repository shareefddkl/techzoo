class OauthController < ApplicationController
  def start
	redirect_to client.web_server.authorize_url(:redirect_uri = &gt; oauth_callback_url, :scope = &gt;'email')
	end

	def callback
	access_token = client.web_server.get_access_token(params[:code], :redirect_uri =&gt; oauth_callback_url)

	session[:fb_user] = JSON.parse access_token.get('/me')
	# in reality you would at this point store the access_token.token value as well as
	# any user info you wanted

	redirect_to :controller =&gt; :users, :action =&gt; :login_process_facebook, :token =&gt; access_token.token

	end

	protected

	def client
	facebook_settings = YAML::load(File.open("#{RAILS_ROOT}/config/oauth.yml"))
	@client ||= OAuth2::Client.new(	"#{facebook_settings[RAILS_ENV]['application_id']}", "#{facebook_settings[RAILS_ENV]['secret_key']}",	:site =&gt; 'https://graph.facebook.com')
	end
end
