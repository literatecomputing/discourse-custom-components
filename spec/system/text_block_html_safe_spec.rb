# frozen_string_literal: true

require_relative "page_objects/components/text_block_component"
require_relative "../support/theme_helpers"

include ThemeHelpers

RSpec.describe "Text block HTML-safe rendering", type: :system do
  fab!(:group1) { Fabricate(:group, name: "group1") }
  fab!(:member) { Fabricate(:user, groups: [group1]) }
  let!(:theme) { upload_theme_component }

  it "renders HTML tags unescaped when the text contains HTML" do
    configure_text_block(
      theme,
      {
        "name" => "text_block html",
        "text" => "This is <strong>bold</strong> text",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "group_action" => "show",
        "groups" => [group1.id],
      },
    )

    sign_in(member)
    visit "/"

    # The component should render the <strong> tag, not escape it.
    expect(page).to have_css(".custom-component strong", text: "bold")
  end
end
