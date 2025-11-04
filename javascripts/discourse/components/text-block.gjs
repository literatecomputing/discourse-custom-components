import Component from "@glimmer/component";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import concatClass from "discourse/helpers/concat-class";

export default class TextBlock extends Component {
  @service currentUser;

  get shouldRender() {
    const component = this.args?.component;
    if (!component) {
      return false;
    }
    const groups = component.groups ?? [];
    const currentUser = this.currentUser;
    if (!groups.length) {
      // No groups configured: show unless explicit hide?
      return component.group_action !== "show" ? true : false;
    }
    const userGroups = currentUser?.groups ?? [];
    const isGroupMember =
      !!currentUser && groups.some((g) => userGroups.some((ug) => ug.id === g));
    return component.group_action === "show" ? isGroupMember : !isGroupMember;
  }

  get component() {
    return this.args.component;
  }

  <template>
    {{#if this.shouldRender}}
      <div
        class={{concatClass "custom-component" this.component.class}}
        id={{this.component.id}}
      >
        {{htmlSafe this.component.text}}
      </div>
    {{/if}}
  </template>
}
