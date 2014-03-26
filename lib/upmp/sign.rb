require 'digest/md5'

module Upmp
  module Sign
    def self.generate(params)
      query = params.sort.map do |key, value|
        "#{key}=#{value}"
      end.join('&')
      query = "#{query}&#{Digest::MD5.hexdigest(Upmp.key).downcase}"
      Digest::MD5.hexdigest(query)
    end

    def self.verify?(params)
      params = Utils.stringify_keys(params)
      params.delete('signMethod')
      sign = params.delete('signature')

      generate(params) == sign
    end
  end
end
