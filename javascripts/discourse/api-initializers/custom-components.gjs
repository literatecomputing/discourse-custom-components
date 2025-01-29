import { apiInitializer } from "discourse/lib/api";
import ButtonLink from "../components/button-link";
import CustomStatusPicker from "../components/custom-status-picker";
import concatClass from "discourse/helpers/concat-class";
import { htmlSafe } from "@ember/template";

export default apiInitializer("1.8.0", (api) => {
  // loop through settings.buttons and render a button for each one
  settings.buttons.forEach((button) => {
    api.renderInOutlet(button.outlet, <template>
      <ButtonLink @button={{button}} />
    </template>);
  });
  settings.custom_text_block.forEach((component) => {
    console.log("component", component);
    api.renderInOutlet(component.outlet, <template>
      <div class={{concatClass "custom-component" component.class}}>
        {{htmlSafe component.text}}
      </div>
    </template>);
  });
});
