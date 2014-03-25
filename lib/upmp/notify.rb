module Upmp
  class Notify
    def self.verify?(params)
      if Sign.verify?(params)
        params = Utils.stringify_keys(params)
        open("https://mapi.upmp.com/gateway.do?service=notify_verify&partner=#{Upmp.pid}&notify_id=#{CGI.escape params['notify_id'].to_s}").read == 'true'
      else
        false
      end
    end
  end
end
