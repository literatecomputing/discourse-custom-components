import { apiInitializer } from "discourse/lib/api";
import ButtonLink from "../components/button-link";
import TextBlock from "../components/text-block";

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
      <template><TextBlock @component={{component}} /></template>
    );
  });
});
