// SPDX-FileCopyrightText: 2018-2019 Eon S. Jeon <esjeon@hyunmu.am>
// SPDX-FileCopyrightText: 2021 Mikhail Zolotukhin <mail@genda.life>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.0
import org.kde.kwin 2.0;
import org.kde.taskmanager 0.1 as TaskManager

import Qt.labs.platform 1.1 as Labs

import "../code/index.mjs" as Bismuth

Item {
    id: scriptRoot

    Labs.SystemTrayIcon {
      id: trayItem
      visible: true
      icon.name: "bismuth"
      tooltip: "Windows' Tiling"

      menu: Labs.Menu {
        id: menu

        property var onToggleTiling: () => {}

        Labs.MenuItem {
          id: toggleTilingMenuItem
          text: i18n("Toggle Tiling")
          onTriggered: () => menu.onToggleTiling()
        }
      }
    }

    TaskManager.ActivityInfo {
        id: activityInfo
    }

    Loader {
        id: popupDialog
        source: "popup.qml"

        function show(text) {
            this.item.show(text);
        }
    }

    Component.onCompleted: {
        console.log("[Bismuth] Initiating the script");

        const qmlObjects = {
            scriptRoot: scriptRoot,
            trayItem: trayItem,
            activityInfo: activityInfo,
            popupDialog: popupDialog
        };

        const kwinScriptingAPI = {
            workspace: workspace,
            options: options,
            KWin: KWin
        };

        Bismuth.init(qmlObjects, kwinScriptingAPI);
    }
}
