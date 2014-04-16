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

      response = Net::HTTP.new(Upmp.UPMP_TRADE_URL, 8080).post('/gateway/merchant/trade', query_string(options))
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
      
      response = Net::HTTP.new(Upmp.UPMP_TRADE_URL, 8080).post('/gateway/merchant/query', query_string(options))
      CGI.parse(response.body)['respCode'].first
      
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
