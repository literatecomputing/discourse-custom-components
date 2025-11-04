# frozen_string_literal: true

require_relative "page_objects/components/text_block_component"
require_relative "../support/theme_helpers"

include ThemeHelpers

RSpec.describe "Text block visibility", type: :system do
  fab!(:group1) { Fabricate(:group, name: "group1") }
  fab!(:member) { Fabricate(:user, groups: [group1]) }
  let!(:theme) { upload_theme_component }

  let(:text_block) { PageObjects::Components::TextBlockComponent.new }

  # use ThemeHelpers#configure_text_block(theme, entry)

  it "shows the text block for a member of the configured group" do
    configure_text_block(
      theme,
      {
        "name" => "text_block 1",
        "text" => "Visible to group1",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "group_action" => "show",
        "groups" => [group1.id],
      },
    )

    sign_in(member)

    visit "/"
    expect(text_block.has_content?("Visible to group1")).to be true
  end

  it "hides the text block for anonymous visitors" do
    configure_text_block(
      theme,
      {
        "name" => "text_block 1",
        "text" => "Visible to group1",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "group_action" => "show",
        "groups" => [group1.id],
      },
    )

    visit "/"
    expect(text_block.not_visible?).to be true
  end

  it "hides the text block for a group member when group_action is 'hide'" do
    configure_text_block(
      theme,
      {
        "name" => "text_block 1",
        "text" => "Hidden from group1",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "group_action" => "hide",
        "groups" => [group1.id],
      },
    )

    sign_in(member)
    visit "/"
    expect(text_block.not_visible?).to be true
  end

  it "shows the text block for anonymous visitors when group_action is 'hide'" do
    configure_text_block(
      theme,
      {
        "name" => "text_block 1",
        "text" => "Visible to anonymous",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "group_action" => "hide",
        "groups" => [group1.id],
      },
    )

    visit "/"
    expect(text_block.has_content?("Visible to anonymous")).to be true
  end

  it "shows the text block when user is in any of multiple groups" do
    group2 = Fabricate(:group, name: "group2")
    member2 = Fabricate(:user, groups: [group2])

    configure_text_block(
      theme,
      {
        "name" => "text_block 1",
        "text" => "Visible to multiple groups",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "group_action" => "show",
        "groups" => [group1.id, group2.id],
      },
    )

    sign_in(member2)
    visit "/"
    expect(text_block.has_content?("Visible to multiple groups")).to be true
  end

  it "renders the configured id attribute when visible" do
    configure_text_block(
      theme,
      {
        "name" => "text_block 1",
        "text" => "Has ID",
        "outlet" => "top-notices",
        "class" => "test-text-block",
        "id" => "my-text-block",
        "group_action" => "show",
        "groups" => [group1.id],
      },
    )

    sign_in(member)
    visit "/"
    expect(text_block.attribute("id")).to eq("my-text-block")
  end
end
