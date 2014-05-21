require 'cgi'
require 'open-uri'

module Upmp
  module Service    
    
    MOBILE_PAYMENT_CONTROL = %w( version charset transType merId backEndUrl frontEndUrl orderTime orderTimeout orderNumber orderAmount orderCurrency )
    # Upmp mobile payment control
    def self.mobile_payment_control options={}
      options = {
        'version' => '1.0.0',
        'charset' => 'UTF-8',
        'transType' => '01'
      }.merge(Utils.stringify_keys(options))
      check_required_options options, MOBILE_PAYMENT_CONTROL      
      
      uri = URI.parse Upmp.UPMP_TRADE_URL + "/gateway/merchant/trade"
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Post.new uri.request_uri
      request.body = query_string options
      response = http.request request
      
      CGI.parse(response.body)['tn'].first
    end
    
    MOBILE_PAYMENT_INQUIRE = %w( version charset transType merId orderTime orderNumber )
    # Upmp mobile payment inquire
    def self.mobile_payment_inquire options={}
      options = {
        'version' => '1.0.0',
        'charset' => 'UTF-8',
        'transType' => '01'
      }.merge(Utils.stringify_keys(options))
      check_required_options options, MOBILE_PAYMENT_INQUIRE
            
      uri = URI.parse Upmp.UPMP_TRADE_URL + "/gateway/merchant/query"
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Post.new uri.request_uri
      request.body = query_string options
      response = http.request request
      
      CGI.parse(response.body)['transStatus'].first
      
    end
    
    def self.query_string(options)
      query = options.sort.concat([['signMethod', 'MD5'], ['signature', Upmp::Sign.generate(options)]]).map do |key, value|
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end


    def self.check_required_options options, names
      names.each do |name|
        warn("Upmp Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end
  end
end
