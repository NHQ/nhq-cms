configfile = "#{Rails.root}/config/api.yml"
if File.exist? configfile
  config = YAML.load(File.read(configfile))[Rails.env]
  if config
    FlickRawOptions = {
      "api_key" => config["flickr_key"],
      "shared_secret" => config["flickr_secret"],
      "auth_token" => config["flickr_auth"]
    }
  end
end

require 'flickraw'