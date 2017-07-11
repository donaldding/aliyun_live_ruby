# AliyunLive

 阿里云直播服务gem， 非官方。

 只是按照项目需求接了几个api，并没有把全部接口都接进来，

 具体接口和返回数据格式请参照[阿里云直播服务文档](https://help.aliyun.com/document_detail/48207.html?spm=5176.doc35414.6.570.VvlMr9)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aliyun_live'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aliyun_live

## Usage

```ruby
require 'aliyun_live'

client = AliyunLive::Client.new(your_access_id, your_access_secret)
```

查询推流在线列表
```ruby
client.describeLiveStreamsOnlineList(domain_name, app_name)
```

查询在线用户列表
```ruby
client.describeLiveStreamOnlineUserNum(domain_name, app_name, stream_name)
```

禁止直播推流
```ruby
client.forbidLiveStream(domain_name, app_name, stream_name,resume_time)
```

恢复直播推流
```ruby
client.resumeLiveStream(domain_name, app_name, stream_name)
```

查询推流黑名单
```ruby
client.describeLiveStreamsBlockList(domain_name)
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aliyun_live. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

