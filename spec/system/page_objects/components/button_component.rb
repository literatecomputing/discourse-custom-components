# frozen_string_literal: true

module PageObjects
  module Components
    class ButtonComponent < PageObjects::Components::Base
      COMPONENT_SELECTOR = '.btn-custom'

      def label_text
        # DButton may render text inside the component; return its visible text
        text(COMPONENT_SELECTOR)
      end

      def href
        attribute_value('href')
      end

      def id
        attribute_value('id')
      end
      def visible?(opts = {})
        has_css?(COMPONENT_SELECTOR, **opts)
      end

      def not_visible?(opts = {})
        has_no_css?(COMPONENT_SELECTOR, **opts)
      end

      private

      # Try to delegate to Base#attribute if available, otherwise fall back
      # to a direct Capybara lookup. This is defensive: test environments
      # may load PageObjects differently so the Base helper might not be
      # present at the time of invocation.
      def attribute_value(name)
        begin
          # Call Base#attribute directly if it's defined there
          base_attr = PageObjects::Components::Base.instance_method(:attribute)
          base_attr.bind(self).call(name, COMPONENT_SELECTOR)
        rescue NameError, NoMethodError
          # Fallback: find the element and return the attribute
          page.find(COMPONENT_SELECTOR)[name]
        end
      end
    end
  end
end
