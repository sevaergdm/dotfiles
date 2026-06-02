import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
	id: root
	width: 1920
	height: 1080
	color: config.colorBg

	readonly property color cBg:		config.colorBg		|| "#1d2021"
	readonly property color cBgAlt:		config.colorBgAlt	|| "#282828"
	readonly property color cFg:		config.colorFg		|| "#ddc7a1"
	readonly property color cFgDim:		config.colorFgDim	|| "#a89984"
	readonly property color cGray:		config.colorGray	|| "#928374"
	readonly property color cYellow:	config.colorYellow	|| "#d8a657"
	readonly property color cOrange:	config.colorOrange	|| "#e78a4e"
	readonly property color cAqua:		config.colorAqua	|| "#89b482"
	readonly property color cRed:		config.colorRed		|| "#ea6962"
	readonly property color cPurple:	config.colorPurplse	|| "#d3869b"

	readonly property string uiFont:	config.font		|| "IosevkaTerm Nerd Font Mono"

	LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
	LayoutMirroring.childrenInherit: true

	// Background
	Image {
		id: bg
		anchors.fill: parent
		source: config.background
		fillMode: Image.PreserveAspectCrop
		asynchronous: true
		cache: true
		visible: status === Image.Ready
	}

	// Fallback solid color if no image
	Rectangle {
		anchors.fill: parent
		color: cBg
		visible: bg.status !== Image.Ready
	}

	// Dim to mimick hyprlock
	Rectangle {
		anchors.fill: parent
		color: cBg
		opacity: parseFloat(config.dimBackground) || 0.15
	}

	// Clock
	Column {
		id: clock
		visible: config.showClock !== "false"
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: parent.height * 0.12
		spacing: 4

		Text {
			anchors.horizontalCenter: parent.horizontalCenter
			color: "white"
			font.family: uiFont
			font.pixelSize: 96
			font.bold: true
			text: Qt.formatTime(timeSource.now, config.clockFormat || "HH:mm")
		}
		Text {
			anchors.horizontalCenter: parent.horizontalCenter
			visible: config.showDate !== "false"
			color: cFg
			font.family: uiFont
			font.pixelSize: 24
			text: Qt.formatDate(timeSource.now, config.dateFormat || "dddd, d MMMM")
		}
	}

	Timer {
		id: timeSource
		property var now: new Date()
		interval: 1000
		running: true
		repeat: true
		onTriggered: now = new Date()
	}

	// Login panel
	Rectangle {
		id: panel
		anchors.centerIn: parent
		width: 380
		height: layout.implicitHeight + 56
		radius: 8
		color: Qt.rgba(cBgAlt.r, cBgAlt.g, cBgAlt.b, 0.55)
		border.color: Qt.rgba(cGray.r, cGray.g, cGray.b, 0.4)
		border.width: 1

		ColumnLayout {
			id: layout
			anchors.centerIn: parent
			width: parent.width - 56
			spacing: 16

			// Username selector
			ComboBox {
				id: userBox
				Layout.fillWidth: true
				model: userModel
				textRole: "name"
				currentIndex: userModel.lastIndex
				font.family: uiFont
				font.pixelSize: 16

				contentItem: Text {
					leftPadding: 12
					text: userBox.displayText
					color: cFg
					font: userBox.font
					verticalAlignment: Text.AlignVCenter
					elide: Text.ElideRight
				}
				background: Rectangle {
					implicitHeight: 44
					radius: 6
					color: Qt.rgba(cBg.r, cBg.g, cBg.b, 0.5)
					border.color: cGray
					border.width: 1
				}
				delegate: ItemDelegate {
					width: userBox.width
					contentItem: Text {
						text: model.name
						color: cFg
						font.family: uiFont
						verticalAlignment: Text.AlignVCenter
					}
					highlighted: userBox.highlightedIndex === index
					background: Rectangle {
						color: highlighted ? cYellow : "transparent"
					}
				}
			}

			// Password field
			TextField {
				id: password
				Layout.fillWidth: true
				echoMode: TextInput.Password
				placeholderText: "🔒  Enter Password"
				placeholderTextColor: cGray
				color: cFg
				font.family: uiFont
				font.pixelSize: 16
				leftPadding: 12
				selectByMouse: true
				focus: true

				background: Rectangle {
					implicitHeight: 48
					radius: 6
					color: Qt.rgba(cBg.r, cBg.g, cBg.b, 0.5)
					border.color: password.activeFocus ? cAqua : cGray
					border.width: password.activeFocus ? 2 : 1
				}
				Keys.onReturnPressed: loginButton.clicked()
				Keys.onEnterPressed: loginButton.clicked()
			}

			// Login button
			Button {
				id: loginButton
				Layout.fillWidth: true
				text: "Log In"
				font.family: uiFont
				font.pixelSize: 16
				font.bold: true

				background: Rectangle {
					implicitHeight: 44
					radius: 6
					color: loginButton.down ? cOrange : cYellow
				}
				contentItem: Text {
					text: loginButton.text
					color: cBg
					font: loginButton.font
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
				onClicked: sddm.login(userBox.currentText, password.text, sessionBox.currentIndex)
			}

			// Error / status message
			Text {
				id: message
				Layout.fillWidth: true
				horizontalAlignment: Text.AlignHCenter
				color: cRed
				font.family: uiFont
				font.pixelSize: 13
				text: ""
				wrapMode: Text.WordWrap
			}
		}
	}

	// Bottom bar: session + power
	RowLayout {
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.margins: 24
		spacing: 16

		ComboBox {
			id: sessionBox
			Layout.preferredWidth: 220
			model: sessionModel
			textRole: "name"
			currentIndex: sessionModel.lastIndex
			font.family: uiFont
			font.pixelSize: 14

			contentItem: Text {
				leftPadding: 10
				text: " " + sessionBox.displayText
				color: cFgDim
				font: sessionBox.font
				verticalAlignment: Text.AlignVCenter
				elide: Text.ElideRight
			}
			background: Rectangle {
				implicitHeight: 36
				radius: 6
				color: Qt.rgba(cBgAlt.r, cBgAlt.g, cBgAlt.b, 0.55)
				border.color: cGray
				border.width: 1
			}
			delegate: ItemDelegate {
				width: sessionBox.width
				contentItem: Text {
					text: model.name
					color: cFg
					font.family: uiFont
				}
				highlighted: sessionBox.highlightedIndex === index
				background: Rectangle { color: highlighted ? cYellow : "transparent" }
			}
		}

		Item { Layout.fillWidth: true }

		// Power controls
		Repeater {
			model: [
				{ glyph: "󰤄", action: "suspend",	enabled: sddm.canSuspend	},
				{ glyph: "󰜉", action: "reboot", 	enabled: sddm.canReboot		},
				{ glyph: "", action: "poweroff", 	enabled: sddm.canPowerOff 	}
			]
			delegate: Button {
				Layout.preferredWidth: 44
				Layout.preferredHeight: 36
				visible: modelData.enabled
				text: modelData.glyph
				font.family: uiFont
				font.pixelSize: 18
				background: Rectangle {
					radius: 6
					color: parent.down ? cRed : parent.hovered ? Qt.rgba(cBgAlt.r, cBgAlt.g, cBgAlt.b, 0.8) : Qt.rgba(cBgAlt.r, cBgAlt.g, cBgAlt.b, 0.55)
					border.color: cGray
					border.width: 1
				}
				contentItem: Text {
					text: parent.text
					color: cFg
					font: parent.font
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
				onClicked: {
					if (modelData.action === "suspend") sddm.suspend()
					else if (modelData.action === "reboot") sddm.reboot()
					else if (modelData.action === "poweroff") sddm.powerOff()
				}
			}
		}
	}

	// SDDM wiring
	Connections {
		target: sddm
		function onLoginSucceeded() {
			message.color = cAqua
			message.text = "Welcome back "
		}
		function onLoginFailed() {
			message.color = cRed
			message.text = "Login failed - try again"
			password.text = ""
			password.focus = true
		}
	}

	Component.onCompleted: password.forceActiveFocus()
}

