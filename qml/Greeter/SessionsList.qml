/*
 * Copyright (C) 2015 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3
import "." 0.1
import "../Components"

Item {
    id: root
    objectName: "sessionsList"

    property string initiallySelectedSession
    //property alias selectedIndex: sessionsList.selectedIndex
    signal sessionSelected(string sessionKey)

    LoginAreaContainer {
        height: units.gu(5) * sessionsList.model.count
        width: parent.width

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        UbuntuListView {
            id: sessionsList
            anchors.fill: parent
            anchors.margins: units.gu(2)

            model: LightDMService.sessions
            header: ListItemLayout {
                id: header

                padding.leading: 0 // handled by parent's margins

                title.color: theme.palette.normal.raisedText
                title.font.pixelSize: units.gu(2.1)
                title.text: i18n.tr("Select desktop environment")

                Icon {
                    id: icon
                    width: units.gu(3)
                    SlotsLayout.position: SlotsLayout.Leading
                    name: "go-previous"
                }
            }

            headerPositioning: ListView.OverlayHeader

            highlight: Rectangle {
                color:"transparent"
                border {
                    color: theme.palette.normal.positionText
                    width: units.gu(0.2)
                }

                visible: sessionsList.currentItem.visible
                y: sessionsList.currentItem.y
            }

            delegate: ListItem {
                id: delegate

                divider.visible: false
                visible: y > sessionsList.headerItem.y
                + sessionsList.headerItem.height
                - sessionsList.anchors.margins
                && (y + height) < root.height

                onYChanged: console.log("jam")
                MouseArea {
                    anchors.fill: parent
                    onClicked: sessionsList.currentIndex = index
                }

                ListItemLayout {
                    id: layout

                    SessionIcon {
                        id: sessionIcon
                        source: icon_url
                        SlotsLayout.position: SlotsLayout.Leading
                        color: theme.palette.normal.raisedSecondaryText
                    }

                    title.text: display
                    title.color: theme.palette.normal.raisedText
                }
            }
        }

        /*ItemSelector {
            id: sessionsList
            objectName: "sessionsListSelector"

            anchors.fill: parent
            anchors.margins: units.dp(5)
            clip: true
            width: parent.width - units.gu(1)
            expanded:true

            model: LightDMService.sessions
            delegate: UnitySelectorDelegate {
                objectName: "sessionDelegate" + index
                colorImage: true
                iconSource: icon_url
                text: display

                // This matches the color for LoginList
                assetColor: selected ? theme.palette.normal.backgroundText :
                    theme.palette.normal.raisedSecondaryText
                textColor: selected ? theme.palette.normal.selectionText : theme.palette.normal.raisedText
                selected: key === initiallySelectedSession
            }

            onDelegateClicked: {
                sessionSelected(sessionsList.model.data(index,
                    LightDMService.sessionRoles.KeyRole));
            }
        }*/
    }
}
