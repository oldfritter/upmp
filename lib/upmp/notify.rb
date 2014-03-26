module Upmp
  class Notify
    def self.verify?(params)
      if Sign.verify?(params)
        # params = Utils.stringify_keys(params)
        
      else
        false
      end
    end
  end
end
