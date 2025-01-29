import Component from "@glimmer/component";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";

export default class ButtonLink extends Component {
  @service currentUser;
  get showButtonLink() {
    // assign isGroupMember to true if user is a member of any of the groups in the button object
    // user is in group if any this.currentUser.groups have an id that is in the button.groups array
    let isGroupMember = this.args.button.groups.some((group) => {
      return this.currentUser.groups.some((userGroup) => {
        return userGroup.id === group;
      });
    });
    if (this.args.button.group_action === "show") {
      return isGroupMember;
    } else {
      return !isGroupMember;
    }
  }

  get button() {
    return this.args.button;
  }

  <template>
    {{#if this.showButtonLink}}
      <DButton
        @icon={{this.button.icon}}
        @translatedLabel={{this.button.text}}
        class={{concatClass "btn-custom" this.button.class}}
        @translatedTitle={{this.button.title}}
        @href={{this.button.url}}
      />
    {{/if}}
  </template>
}
