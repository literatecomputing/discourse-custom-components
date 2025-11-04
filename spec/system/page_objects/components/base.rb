# frozen_string_literal: true

require 'capybara'

module PageObjects
  module Components
    class Base
      include Capybara::DSL

      # Optional scope can be provided to narrow down searches
      def initialize(scope = nil)
        @scope = scope
      end

      # Subclasses should override COMPONENT_SELECTOR or component_selector
      def component_selector
        self.class.const_defined?(:COMPONENT_SELECTOR) ? self.class.const_get(:COMPONENT_SELECTOR) : @scope
      end

      def has_css?(selector, **opts)
        page.has_css?(selector, **opts)
      end

      def has_no_css?(selector, **opts)
        page.has_no_css?(selector, **opts)
      end

      def find_css(selector)
        page.find(selector)
      end

      def text(selector = nil)
        selector ? find_css(selector).text : find_css(component_selector).text
      end

      def attribute(name, selector = nil)
        find_css(selector || component_selector)[name]
      end

      def click(selector = nil)
        find_css(selector || component_selector).click
      end
    end
  end
end
