# IANotificationBar
a very light weight Notification bar to View Notification with call back Functionality.

# How to USE?

![alt text](http://i.imgur.com/G5Y7QZ4.png)

# when User click on Message

![alt text](http://i.imgur.com/vu1BgNM.png)


# Show simple Message

IANotificationBar.sharedInstance.showMessage(title:"Hello",description:"Sample Text")

# Show Message with Callback


IANotificationBar.sharedInstance.showMessagewithHandler(title: "Hello", description: "Hello This") { (completed) in
     print("Tapped...")       
}

