Testing (Discourse-style system specs)

This theme provides RSpec/Capybara system specs that run inside the Discourse
test harness (recommended for end-to-end testing of themes and theme
components). We use the `discourse_theme` CLI to run the specs in a disposable
Docker container.

Run all system specs for the theme:

```bash
discourse_theme rspec spec/system
```

Run a single spec file:

```bash
discourse_theme rspec spec/system/text_block_visibility_spec.rb
```

Run in headful mode (open Chrome so you can watch/debug):

```bash
discourse_theme rspec spec/system --headful
```

Notes:
- If this repository is a theme *component* (not a full theme) the system spec
  uses `upload_theme_component` to install the component into the test
  instance. The spec files live under `spec/system` and use Fabricate helpers
  from Discourse core to create users/groups for tests.
- Tests run in Docker by default; see the `discourse_theme` documentation for
  advanced usage, local Discourse integration, and CI setup:
  https://github.com/discourse/discourse_theme
