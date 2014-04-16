require 'digest/md5'

module Upmp
  module Sign
    def self.generate(params)
      Digest::MD5.hexdigest(params.sort.map{|key, value| "#{key}=#{value}" }.join('&') + "&#{Digest::MD5.hexdigest(Upmp.key).downcase}")
    end

    def self.verify?(params)
      params = Utils.stringify_keys(params)
      params.delete('signMethod')
      sign = params.delete('signature')

      generate(params) == sign
    end
  end
end
