
A simple upmp ruby gem, without unnecessary magic or wraper, it's directly facing how upmp api works.

It contain this API:

* Send goods


## Installation

Add this line to your application's Gemfile:


```ruby
gem 'upmp', :git => 'https://github.com/oldfritter/upmp'
```

And then execute:

```sh
$ bundle install
```

## Usage

### Config

```ruby
  Upmp.store_no = '880000000001094' #商户合作号
  Upmp.key = 'ETXboGTeXVems2CD655WVSM0qAO122P4' #商户的KEY
  Upmp.UPMP_TRADE_URL = '222.66.233.198' #银联的网关(此处为测试网关)
	
```

### Generate payment url

```ruby
@options = {
        merId: Upmp.store_no,
        backEndUrl: "call_back_url",
        frontEndUrl: "call_back_url",
        # acqCode: '',
        orderTime: Time.now.strftime('%Y%m%d%H%M%S'),
        orderTimeout: 1.hour.from_now.localtime.strftime('%Y%m%d%H%M%S'),
        orderNumber: order.payment_sn,
        orderAmount: order.total_fee,
        orderCurrency: order.currency_code
      }

    http = Net::HTTP.new(Upmp.UPMP_TRADE_URL, 8080)
    response = http.post('/gateway/merchant/trade', Upmp::Service.mobile_payment_control(@option))
	  tn = response.body #获取交易的流水号
	  
    result_url = CGI.escape "#{SITE_ROOT}/utility/upmp_success?payment_sn=#{payment_sn}&result="
    order_info = "tn=#{params},resultURL=#{result_url},usetestmode=true"
    render text: "<a href='uppay://uppayservice/?style=token&paydata=#{CGI.escape(Base64.encode64(order_info))}'><img src='/assets/yinlian.jpg' alt='银联手机支付' style='width: 300px; height: 200px;'/></a>".html_safe #返回一个跳转页面,点击银联的图标以启动银联的app
	  
```


Current support payment type:
```
 Upmp::Service#mobile_payment_control        	# 银联控件支付
 
```

## Contributing

Bug report or pull request are welcome.