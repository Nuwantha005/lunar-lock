import QtQuick
import QtQuick.Window
import QtMultimedia

Item {
    readonly property real s: Screen.height / 768
    anchors.fill: parent

    readonly property string customBg: typeof root !== "undefined" && root.overrideBg !== undefined ? root.overrideBg : ""
    readonly property bool isCustomVid: customBg !== "" && (customBg.endsWith(".mp4") || customBg.endsWith(".webm") || customBg.endsWith(".mkv"))
    readonly property bool isCustomImg: customBg !== "" && !isCustomVid

    MediaPlayer {
        id: mediaplayer
        source: isCustomVid ? (customBg.startsWith("file://") ? customBg : ("file://" + customBg)) : "bg.mp4"
        autoPlay: true
        loops: MediaPlayer.Infinite
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectCrop
        visible: !isCustomImg
    }

    Image {
        anchors.fill: parent
        visible: isCustomImg
        source: isCustomImg ? (customBg.startsWith("file://") ? customBg : ("file://" + customBg)) : ""
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
}
