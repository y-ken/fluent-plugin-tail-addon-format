module Fluent
  class TextParser

    ADDON_TEMPLATE_FACTORIES = {
      'elasticsearch' => Proc.new { RegexpParser.new(
        /^\[(?<time>[^ ]* [^ ]*)\]\[(?<log_level>[^ ]*) *?\]\[(?<cluster_name>[^ ]*) *\] \[(?<node_name>[^ ]*) *\] (?<message>.+)/,
        {'time_format' => "%Y-%m-%d %H:%M:%S,%L"})
      },
      'postfix' => Proc.new { RegexpParser.new(
        /^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +\S*)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$/,
        {'time_format' => "%d/%b/%Y:%H:%M:%S %z"})
      },
      'qmail' => Proc.new { RegexpParser.new(
        /^(?<tai64n>[^ ]+) (?<message>(((?:new|end) msg (?<key>[0-9]+)|info msg (?<key>[0-9]+): bytes (?:\d+) from <(?<address>[^>]*)> |starting delivery (?<delivery_id>[0-9]+): msg (?<key>[0-9]+) to (?:local|remote) (?<address>.+)|delivery (?<delivery_id>[0-9]+))?.*))$/,
        {'time_format' => "%d/%b/%Y:%H:%M:%S %z"})
      },
    }

    def initialize
      super

      ADDON_TEMPLATE_FACTORIES.each do |name, proc|
        TEMPLATE_FACTORIES[name] = proc
      end
    end
  end
end

