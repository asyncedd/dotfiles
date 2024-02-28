import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Mpris from "resource:///com/github/Aylur/ags/service/mpris.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
const battery = await Service.import("battery");
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

const Workspaces = () =>
  Widget.Box({
    class_name: "workspaces",
    child: Widget.Box({
      children: [
        Widget.EventBox({
          onScrollUp: () => execAsync("hyprctl dispatch workspace +1"),
          onScrollDown: () => execAsync("hyprctl dispatch workspace -1"),
          className: "eventbox",
          child: Widget.Box({
            children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
              Widget.Button({
                onClicked: () =>
                  execAsync(`hyprctl dispatch workspace ${i}`).catch(print),
                child: Widget.Label({
                  label: `${i}`,
                  className: "indicator",
                  valign: "center",
                }),
                connections: [
                  [
                    Hyprland,
                    (btn) => {
                      const occupied = Hyprland.getWorkspace(i)?.windows > 0;
                      btn.toggleClassName(
                        "active",
                        Hyprland.active.workspace.id === i,
                      );
                      btn.toggleClassName("occupied", occupied);
                    },
                  ],
                ],
              }),
            ),
          }),
        }),
      ],
    }),
  });

const ClientTitle = () =>
  Widget.Label({
    class_name: "client-title",
    label: Hyprland.active.client.bind("title"),
  });

const Clock = () =>
  Widget.Label({
    class_name: "clock",
    setup: (self) =>
      self
        // this is bad practice, since exec() will block the main event loop
        // in the case of a simple date its not really a problem
        .poll(1000, (self) => (self.label = exec('date "+%H:%M:%S %b %e."')))

        // this is what you should do
        .poll(1000, (self) =>
          execAsync(["date", "+%H:%M:%S %b %e."]).then(
            (date) => (self.label = date),
          ),
        ),
  });

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
const Notification = () =>
  Widget.Box({
    class_name: "notification",
    visible: Notifications.bind("popups").transform((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: Notifications.bind("popups").transform(
          (p) => p[0]?.summary || "",
        ),
      }),
    ],
  });

const Media = () =>
  Widget.Button({
    class_name: "media",
    on_primary_click: () => Mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => Mpris.getPlayer("")?.next(),
    on_scroll_down: () => Mpris.getPlayer("")?.previous(),
    child: Widget.Label("-").hook(
      Mpris,
      (self) => {
        if (Mpris.players[0]) {
          const { track_artists, track_title } = Mpris.players[0];
          self.label = `${track_artists.join(", ")} - ${track_title}`;
        } else {
          self.label = "Nothing is playing";
        }
      },
      "player-changed",
    ),
  });

const BatteryLabel = () =>
  Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Icon({
        icon: battery.bind("icon_name"),
      }),
      Widget.Label({
        label: battery.bind("percent").as((p) => `${p}%`),
      }),
    ],
  });

const SysTray = () =>
  Widget.Box({
    children: SystemTray.bind("items").transform((items) => {
      return items.map((item) =>
        Widget.Button({
          child: Widget.Icon({ binds: [["icon", item, "icon"]] }),
          on_primary_click: (_, event) => item.activate(event),
          on_secondary_click: (_, event) => item.openMenu(event),
          binds: [["tooltip-markup", item, "tooltip-markup"]],
        }),
      );
    }),
  });

// layout of the bar
const Left = () =>
  Widget.Box({
    spacing: 8,
    children: [Workspaces()],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [BatteryLabel(), Clock(), SysTray()],
  });

const Bar = (monitor = 0) =>
  Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      // center_widget: Center(),
      end_widget: Right(),
    }),
  });

import { monitorFile } from "resource:///com/github/Aylur/ags/utils.js";

monitorFile(`${App.configDir}/style.css`, function () {
  App.resetCss();
  App.applyCss(`${App.configDir}/style.css`);
});

// exporting the config so ags can manage the windows
export default {
  style: App.configDir + "/style.css",
  windows: [
    Bar(),

    // you can call it, for each monitor
    // Bar(0),
    // Bar(1)
  ],
};
