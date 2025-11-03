import { htmlSafe } from "@ember/template";
import concatClass from "discourse/helpers/concat-class";
import { apiInitializer } from "discourse/lib/api";
import ButtonLink from "../components/button-link";

export default apiInitializer((api) => {
  // loop through settings.buttons and render a button for each one
  settings.buttons.forEach((button) => {
    api.renderInOutlet(
      button.outlet,
      <template><ButtonLink @button={{button}} /></template>
    );
  });

  settings.custom_text_block.forEach((component) => {
    api.renderInOutlet(
      component.outlet,
      <template>
        <div class={{concatClass "custom-component" component.class}}>
          {{htmlSafe component.text}}
        </div>
      </template>
    );
  });
});
