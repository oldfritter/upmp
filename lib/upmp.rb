require "upmp/version"
require 'upmp/utils'
require 'upmp/sign'
require 'upmp/service'
require 'upmp/notify'

module Upmp
  
  class << self

    attr_accessor :store_no
    attr_accessor :key
    attr_accessor :UPMP_TRADE_URL
     
  end
end
