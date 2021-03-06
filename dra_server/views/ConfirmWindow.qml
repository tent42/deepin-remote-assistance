/****************************************************************************
**
**  Copyright (C) 2011~2014 Deepin, Inc.
**                2011~2014 WanQing Yang
**
**  Author:     WanQing Yang <match.yangwanqing@gmail.com>
**  Maintainer: WanQing Yang <match.yangwanqing@gmail.com>
**
**  This program is free software: you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation, either version 3 of the License, or
**  any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Window 2.2

import DBus.Com.Deepin.Daemon.Display 1.0
import Deepin.Locale 1.0
import Deepin.Widgets 1.0

Rectangle {
    id: root
    color: "transparent"

    Component.onCompleted: {
        windowView.setX(screenSize.width / 2 - width / 2)
        windowView.setY(screenSize.height / 2  - height / 2)
        cancelButton.forceActiveFocus()
    }

    width: 300
    height: 120

    // Setup locale domain
    property var dsslocale: DLocale {
        domain: "deepin-remote-assistance"
    }

    // Internationalization
    function dsTr(s){
        return dsslocale.dsTr(s)
    }

    // Width of box shadow
    property int shadowWidth: 15

    property var displayId: Display {}
    property var screenSize: QtObject {
        property int x: displayId.primaryRect[0]
        property int y: displayId.primaryRect[1]
        property int width: displayId.primaryRect[2]
        property int height: displayId.primaryRect[3]
    }

    DDialogBox {
        id: window
        anchors.fill: parent
        radius: 5

        DssH2 {
            id: title
            width: parent.width
            height: parent.height - buttonRow.height
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            wrapMode: Text.WordWrap
            text: dsTr("Are you sure to close remote desktop connection?")
        }

        Row {
            id: buttonRow
            anchors.right: parent.right
            anchors.rightMargin: 6
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 6
            spacing: 6

            DTransparentButton {
                id: cancelButton
                text: dsTr("Cancel")
                activeFocusOnTab: true
                Keys.onReturnPressed: activate()
                onClicked: active()

                function active(){
                    windowView.rejected()
                    windowView.close()
                }
            }

            DTransparentButton {
                id: confirmButton
                text: dsTr("Confirm")
                activeFocusOnTab: true
                Keys.onReturnPressed: activate()
                onClicked: active()

                function active(){
                    windowView.accepted()
                    windowView.close()
                }
            }
        }
    }
}
