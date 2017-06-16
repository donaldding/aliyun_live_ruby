require "aliyun_live/version"
require "erb"
require 'base64'
require 'cgi'
require 'openssl'
require 'date'
require 'net/http'
require 'uri'
require 'json'
require 'securerandom'


include ERB::Util
module AliyunLive
  class Client
    attr_reader :access_key_id, :access_key_secret

    def initialize(access_key_id, access_key_secret)
      @access_key_id = access_key_id
      @access_key_secret = access_key_secret
    end

    def describeLiveStreamsOnlineList(domain_name, app_name = nil)
      params = {}
      params[:Action] = 'DescribeLiveStreamsOnlineList'
      params[:DomainName] = domain_name
      params[:AppName] = app_name unless app_name.nil?
      http_get(params)
    end

    def describeLiveStreamOnlineUserNum(domain_name, app_name = nil, stream_name = nil)
      params = {}
      params[:Action] = 'DescribeLiveStreamOnlineUserNum'
      params[:DomainName] = domain_name
      params[:AppName] = app_name unless app_name.nil?
      params[:StreamName] = stream_name unless stream_name.nil?

      http_get(params)
    end

    def describeLiveStreamsBlockList(domain_name)
      params = {}
      params[:Action] = 'DescribeLiveStreamsBlockList'
      params[:DomainName] = domain_name
      http_get(params)
    end

    def forbidLiveStream(domain_name, app_name, stream_name, resume_time = nil)
      params = {}
      params[:Action] = 'DescribeLiveStreamOnlineUserNum'
      params[:DomainName] = domain_name
      params[:AppName] = app_name
      params[:StreamName] = stream_name
      params[:ResumeTime] = resume_time unless resume_time.nil?
      params[:LiveStreamType] = 'publisher' 
      http_get(params)
    end
    
    def resumeLiveStream(domain_name, app_name, stream_name)
      params = {}
      params[:Action] = 'DescribeLiveStreamOnlineUserNum'
      params[:DomainName] = domain_name
      params[:AppName] = app_name
      params[:StreamName] = stream_name
      params[:LiveStreamType] = 'publisher' 
      http_get(params)
    end


    def sign(method,params)
      str_to_sign = method + "&" + url_encode('/') + '&'
      sorted_keys = params.keys.sort
      params_str = ""
      sorted_keys.each do |key|
        params_str +=  url_encode(key) + '=' + url_encode(params[key]) + '&'
      end
      params_str = params_str[0...-1]
      str_to_sign += url_encode(params_str)
      key = @access_key_secret + '&'
      puts str_to_sign
      
      Base64.encode64(OpenSSL::HMAC.digest('sha1',key, str_to_sign))[0...-1]

    end

    def http_get(additional_params)
      host = 'http://live.aliyuncs.com'
      params = gen_pub_params
      params = params.merge(additional_params)
      signature = sign('GET',params)
      params[:Signature] = signature

      uri = URI(host)
      uri.query = URI.encode_www_form(params)
      puts params
      puts URI.encode_www_form(params)
      resp = Net::HTTP.get_response(uri)
      JSON.parse resp.body
    end

    def gen_pub_params
      params={}
      params[:Format] = 'JSON'
      params[:Version] = '2016-11-01'
      params[:AccessKeyId] = @access_key_id
      params[:SignatureMethod] = 'HMAC-SHA1'
      params[:Timestamp] = Time.now.getutc.strftime("%FT%T")
      params[:SignatureVersion] = '1.0'
      params[:SignatureNonce] = SecureRandom.uuid
      params
    end
  end
end
