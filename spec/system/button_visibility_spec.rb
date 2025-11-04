# frozen_string_literal: true

require_relative "page_objects/components/button_component"

RSpec.describe "Button visibility", type: :system do
  fab!(:group1) { Fabricate(:group, name: "group1") }
  fab!(:member) { Fabricate(:user, groups: [group1]) }
  let!(:theme) { upload_theme_component }

  let(:button) { PageObjects::Components::ButtonComponent.new }

  def configure_button(entry)
    theme.update_setting(:buttons, [entry])
    theme.save!
  end

  it "shows the button for members when group_action is 'show'" do
    configure_button(
      {
        "name" => "button 1",
        "text" => "Click me",
        "title" => "Click this",
        "url" => "https://example.com",
        "class" => "test-button",
        "icon" => "triangle-exclamation",
        "outlet" => "top-notices",
        "group_action" => "show",
        "groups" => [group1.id]
      }
    )

    sign_in(member)
    visit "/"

    expect(button.visible?).to be true
    expect(button.label_text).to include('Click me')
    expect(button.href).to include('https://example.com')
  end

  it "hides the button for anonymous visitors when group_action is 'show'" do
    configure_button(
      {
        "name" => "button 1",
        "text" => "Click me",
        "title" => "Click this",
        "url" => "https://example.com",
        "class" => "test-button",
        "icon" => "triangle-exclamation",
        "outlet" => "top-notices",
        "group_action" => "show",
        "groups" => [group1.id]
      }
    )

    visit "/"
    expect(button.not_visible?).to be true
  end

  it "hides the button for group members when group_action is 'hide'" do
    configure_button(
      {
        "name" => "button 1",
        "text" => "Hidden",
        "url" => "https://example.com",
        "class" => "test-button",
        "outlet" => "top-notices",
        "group_action" => "hide",
        "groups" => [group1.id]
      }
    )

    sign_in(member)
    visit "/"
    expect(button.not_visible?).to be true
  end

  it "renders the configured id attribute when visible" do
    configure_button(
      {
        "name" => "button 1",
        "text" => "Has ID",
        "url" => "https://example.com",
        "class" => "test-button",
        "id" => "my-button",
        "outlet" => "top-notices",
        "group_action" => "show",
        "groups" => [group1.id]
      }
    )

    sign_in(member)
    visit "/"
    expect(button.id).to eq('my-button')
  end
end
