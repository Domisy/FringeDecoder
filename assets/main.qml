// Grid view with detail project template
import bb.cascades 1.0
import bb.system 1.0

NavigationPane {
    id: navigationPane
    Menu.definition: MenuDefinition {
        // Add a Help action
        helpAction: HelpActionItem {
            title: "About"
            onTriggered: {
                aboutDialog.show()
            }
        }
        attachedObjects: [
            SystemDialog {
                id: aboutDialog
                title: "About"
                body: "Fringe Decoder was brought to you by - Domisy Dev\n\nLead Developer - Theodore Mavrakis\n\nSupport - domisydev@gmail.com\nVersion - 1.0"
            }
        ]
    }
    property string filePath: "appleList.xml"
    property variant myBackground: Color.create("#125671")
    firstPage: Page {
        id: pgMain
        content: Container {
            background: background.imagePaint
            layout: StackLayout {
            }
            ListView {
                id: listView
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                dataModel: XmlDataModel {
                    source: "baseImages.xml"
                }
                // set object name to let listView to be discoverable from C++
                objectName: "listView"
                layout: GridListLayout {
                }
                listItemComponents: [
                    // define component which will represent list item GUI appearence
                    ListItemComponent {
                        type: "item"
                        // list item GUI appearence component is defined in external MyListItem.qml file
                        MyListItem {
                            verticalAlignment: VerticalAlignment.Top
                            horizontalAlignment: HorizontalAlignment.Left
                            touchPropagationMode: TouchPropagationMode.Full
                        }
                    }
                ]
                onTriggered: {
                    console.log("selected_index: " + indexPath)
                    var curr_item = dataModel.data(indexPath)
                    // show detail page for selected item
                    setDetailItem(curr_item)
                }
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
            }
            Container {
                preferredHeight: 140
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                background: myBackground
                Container {
                    topPadding: 5
                    TextArea {
                        //preferredWidth: 660
                        editable: true
                        id: fringeTextArea
                        touchPropagationMode: TouchPropagationMode.PassThrough
                        hintText: "Fringe Decoder"
                        textStyle.fontSize: FontSize.XXLarge
                        textStyle.textAlign: TextAlign.Center
                        textStyle.color: Color.White
                        backgroundVisible: false
                        //preferredHeight: 135
                    }
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    rightPadding: 15
                    Button {
                        preferredWidth: 20
                        preferredHeight: 20
                        text: "X"
                        onClicked: {
                            fringeTextArea.text = ""
                        }
                    }
                }
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: secondPageDefinition
            //property string dataPath
            content: Page {
                id: pgDetail
                actionBarVisibility: ChromeVisibility.Hidden
                content: Container {
                    layout: StackLayout {
                    }
                    ListView {
                        id: sublistView
                        topPadding: 50
                        leftPadding: 20
                        rightPadding: 20
                        dataModel: XmlDataModel {
                            id: subListData
                            source: filePath
                        }
                        // set object name to let listView to be discoverable from C++
                        objectName: "listView"
                        layout: GridListLayout {
                        }
                        listItemComponents: [
                            // define component which will represent list item GUI appearence
                            ListItemComponent {
                                type: "item"
                                // list item GUI appearence component is defined in external MyListItem.qml file
                                SubListItem {
                                }
                            }
                        ]
                        onTriggered: {
                            console.log("selected_index: " + indexPath)
                            var curr_item = dataModel.data(indexPath)
                            // show detail page for selected item
                            addLetter(curr_item)
                        }
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
        },
        ImagePaintDefinition {
            id: background
            repeatPattern: RepeatPattern.Fill
            imageSource: "asset:///background.png"
        }
    ]
    function setDetailItem(item) {
        // show detail page
        filePath = item.subimagesFile
        var page = secondPageDefinition.createObject();
        navigationPane.push(page)
    }
    function addLetter(item) {
        navigationPane.pop();
        fringeTextArea.text += item.letter
    }
    onCreationCompleted: {
        // this slot is called when declarative scene is created
        // write post creation initialization here
        console.log("NavigationPane - onCreationCompleted()")

        // enable layout to adapt to the device rotation
        // don't forget to enable screen rotation in bar-bescriptor.xml (Application->Orientation->Auto-orient)
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
    }
}
