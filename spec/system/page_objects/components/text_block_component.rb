# frozen_string_literal: true

module PageObjects
  module Components
    class TextBlockComponent < PageObjects::Components::Base
      COMPONENT_SELECTOR = '.custom-component'

      def component_selector
        COMPONENT_SELECTOR
      end

      def has_content?(content)
        has_css?(COMPONENT_SELECTOR, text: content)
      end

      def visible?(opts = {})
        has_css?(COMPONENT_SELECTOR, **opts)
      end

      def not_visible?(opts = {})
        has_no_css?(COMPONENT_SELECTOR, **opts)
      end

      def attribute(name)
        attribute_value = attribute(name, COMPONENT_SELECTOR) rescue nil
        # Fall back to finding the element directly if Base#attribute isn't available
        attribute_value ||= page.find(COMPONENT_SELECTOR)[name]
        attribute_value
      end
    end
  end
end
