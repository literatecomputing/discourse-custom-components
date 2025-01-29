import Component from "@glimmer/component";
import { service } from "@ember/service";
import concatClass from "discourse/helpers/concat-class";
import UserStatusPicker from "discourse/components/user-status-picker";
import { TrackedObject } from "@ember-compat/tracked-built-ins";

// this is a proof of concept.
// It will show the status picker, but it doesn't work.

export default class CustomStatusPicker extends Component {
  @service currentUser;
  get showStatusPicker() {
    console.log("show the picker", this.args.statusPicker);
    console.log("this.currentUser", this.currentUser);
    // status = new TrackedObject({ ...this.args.model.status });

    // assign isGroupMember to true if user is a member of any of the groups in the button object
    // user is in group if any this.currentUser.groups have an id that is in the button.groups array
    let isGroupMember = this.args.statusPicker.groups.some((group) => {
      return this.currentUser.groups.some((userGroup) => {
        return userGroup.id === group;
      });
    });
    if (this.args.statusPicker.group_action === "show") {
      return isGroupMember;
    } else {
      return !isGroupMember;
    }
    return true;
  }
  get picker() {
    return this.args.statusPicker;
  }

  <template>
    {{#if this.showStatusPicker}}
      <UserStatusPicker status={{this.picker.status}} />
    {{/if}}
  </template>
}
