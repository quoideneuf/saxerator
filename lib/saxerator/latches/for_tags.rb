require 'saxerator/latches/abstract_latch'

module Saxerator
  module Latches
    class ForTags < AbstractLatch
      def initialize(names, ignore_namespaces = false)
        @ignore_namespaces = ignore_namespaces
        @names = names
      end

      def start_element name, _
        name = @ignore_namespaces ? strip(name) : name
        @names.include?(name) ? open : close
      end

      def end_element name
        name = @ignore_namespaces ? strip(name) : name
        close if @names.include?(name)
      end

      def strip(name)
        name.split(':').last
      end
    end
  end
end
