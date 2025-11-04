# frozen_string_literal: true

module ThemeHelpers
  # Configure a custom text block entry on the uploaded theme component
  # theme - the uploaded theme component (returned by upload_theme_component)
  # entry - a Hash representing the text block entry
  def configure_text_block(theme, entry)
    theme.update_setting(:custom_text_block, [entry])
    theme.save!
  end

  # Configure a button entry on the uploaded theme component
  def configure_button(theme, entry)
    theme.update_setting(:buttons, [entry])
    theme.save!
  end
end
