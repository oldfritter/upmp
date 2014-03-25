
A simple upmp ruby gem, without unnecessary magic or wraper, it's directly facing how upmp api works.

It contain this API:

* Generate payment url
* Send goods
* Verify notify


## Installation

Add this line to your application's Gemfile:


```ruby
gem 'upmp', :github => 'https://github.com/oldfritter/upmp'
```

And then execute:

```sh
$ bundle
```

## Usage

### Config

```ruby
  Upmp.store_no = '880000000001095'
  Upmp.key = 'ETXboGTeXVems2CD655WVSM0qAO122P5'
  Upmp.card_no = '6226440123456785'
```

### Generate payment url

```ruby
options = {
        merId: Upmp.store_no,
        backEndUrl: order.call_back_url{payment = 'upmp'},
        frontEndUrl: order.call_back_url{payment = 'upmp'},
        # acqCode: '',
        orderTime: Time.now.strftime('%Y%m%d%H%M%S'),
        orderTimeout: 1.hour.from_now.strftime('%Y%m%d%H%M%S'),
        orderNumber: order.payment_sn,
        orderAmount: order.total_fee_,
        orderCurrency: order.currency_code
      }

Upmp::Service.mobile_payment_control(options)
```

You can redirect user to this payment url, and user will see a payment page for his/her order.

Current support three payment type:
```
 Upmp::Service#mobile_payment_control        	# 银联控件支付
 
```

## Contributing

Bug report or pull request are welcome.