# GlobalSign

A Ruby interface to the GlobalSign API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'global_sign'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install global_sign
```

## Usage

### Settings

An example Rails initializer would look something like this:

```ruby
GlobalSign.configure do |configuration|
  configuration.user_name = 'PAR12345_taro'
  configuration.password  = 'password'
  configuration.endpoint  = 'https://test-gcc.globalsign.com/kb/ws/v1'
end
```

### URL Verification

```ruby
require 'global_sign'

client = GlobalSign::Client.new

# Prepare CSR beforehand
csr = <<-EOS
-----BEGIN CERTIFICATE REQUEST-----
...
-----END CERTIFICATE REQUEST-----
EOS

contract = GlobalSign::Contract.new(
  first_name:   'Pepabo',
  last_name:    'Taro',
  phone_number: '090-1234-5678',
  email:        'pepabo.taro@example.com',
)

request = GlobalSign::UrlVerification::Request.new(
  order_kind:    'new',   # If you request a new certificate
  csr:           csr,
  contract_info: contract,
)

response = client.process(request)

if response.success?
  puts "Successfully URL Verification"
  puts response.params # => { meta_tag: "xxxxx", ... }
else
  raise StandardError, "#{response.error_code}: #{response.error_message}"
end
```

To use contract on Rails initializer, do it like this:

```ruby
GlobalSign.set_contract do |contract|
  contract.first_name   = 'Pepabo'
  contract.last_name    = 'Taro'
  contract.phone_number = '090-1234-5678'
  contract.email        = 'pepabo.taro@example.com'
end

# Not need to give argument 'contract_info'
request = GlobalSign::UrlVerification::Request.new(
  order_kind: 'new',
  csr:        csr,
)
```

## Contributing

1. Create your feature branch (git checkout -b my-new-feature)
2. Commit your changes (git commit -am 'Add some feature')
3. Push to the branch (git push origin my-new-feature)
4. Create a new Pull Request
