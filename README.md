# fluent-plugin-tail-addon-format

[Fluentd](http://fluentd.org/) Input plugin add-on for `in_tail` format. It provides 3rd party in_tail format rules working with postfix, qmail and elasticsearch.

## Installation

install with `gem` or `fluent-gem` command as:

```bash
# for fluentd
$ gem install fluent-plugin-tail-addon-format

# for td-agent
$ sudo /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-tail-addon-format
```

## Usage

After installing this plugin, it has got ready to use 3rd party format like below.

```
<source>
  type     tail
  tag      elasticsearch.general_log
  format   elasticsearch
  path     /var/log/elasticsearch/elasticsearch.log
  pos_file /var/log/td-agent/elasticsearch.log.pos
</source>
```

## Specification

It provides these formats.

* elasticsearch
* postfix
* qmail

## Note

This plugin has inspired from this article.

* Aliasing Log Parsing Logic for Fluentd<br>
http://kiyototamura.tumblr.com/post/79699762964/aliasing-log-parsing-logic-for-fluentd

## TODO

Pull requests are very welcome!!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014- Kentaro Yoshida (@yoshi_ken)

## License

Apache License, Version 2.0
