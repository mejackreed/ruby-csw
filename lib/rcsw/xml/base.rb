require 'libxml'
require 'open-uri'
require 'ostruct'
require 'active_support/all'

module Rcsw
  module XML
    class Base
      class << self
        attr_accessor :version
      end
      
      attr_accessor :xml_readers
      
      def initialize
        @xml_readers = {}
      end
      
      def read_node(node, obj)
        if (obj.nil?)
          obj = OpenStruct.new
        end

        reader = xml_readers['csw'][node.name]
        if (reader)
          reader.call(node, obj)
        end
        obj
      end

      def read_child_nodes(node, obj)
        if (obj.nil?)
          obj = OpenStruct.new
        end

        children = node.children
        children.each do |child|
          if (child.node_type == 1)
            read_node(child, obj)
          end
        end

        obj
      end

      def child_value(node, default = nil)
        value = default || ""

        node.each do |child|
          case child.node_type
          when 3,4 # Text: 3 or CDATA: 4 use cdata? or text?
            value << child.content
          end
        end
        value.strip!

        value
      end
    end
  end
end