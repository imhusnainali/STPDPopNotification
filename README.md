# STPDPopNotification
Pop notification alert view. Auto fit and animated. For any size of text and image. With customizable buttons. 

### Types of Text / Image Notification alert view pop in front of the current view:

No Text Content with Single Button: 
* Notification with title and Ok button.

    ![alt tag](https://github.com/STPDChen/STPDPopNotification/blob/master/gif/1.gif)

Short Text Content with Two Buttons: (Same on no text / long text)
* Notification with title, center aligned text content and  two customizable buttons.

    ![alt tag](https://github.com/STPDChen/STPDPopNotification/blob/master/gif/2.gif)

Long Text Content with Single Button:
* Notification with title, left aligned scrollable text content and Ok button.

    ![alt tag](https://github.com/STPDChen/STPDPopNotification/blob/master/gif/3.gif)

Regular Image Content with Single Button: 
* Notification with title, regular image and Ok button.

    ![alt tag](https://github.com/STPDChen/STPDPopNotification/blob/master/gif/4.gif)

Long Image Content with Two Buttons: (Same on long image text)
* Notification with title, scrollable long image and Ok button.

    ![alt tag](https://github.com/STPDChen/STPDPopNotification/blob/master/gif/5.gif)

### Three types of UIView extension that perform animations on the view. 
Shake: 
* Vibe UIView on x and y derections with certain distance. 

Breath: 
* Periodiclly change the opacity of the UIView from 1 to 0.  

Rotate:
* Rotate UIView clockwise and counterclockwise with certain degree. 

----------------------------------------------------------------------------

### Direction of use: 
Five Public Funtions: 
* func popStringNotification(text: String, content: String?): 

        STPDPopNotification.popStringNotification("No Detail", content: nil)

* func popStringNotificationWithButton(text: String, content: String?, leftButtonTitle: String, leftButtonHandler: ((leftButton: UIButton)->())?, rightButtonTitle: String, rightButtonHandler: ((rightButton: UIButton)->())?): 

        STPDPopNotification.popStringNotificationWithButton("With Detail [Two Buttons]", content: midContent, leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "OK") { (rightButton) in
            rightButton.addTarget(self, action: #selector(self.popNew(_:)), forControlEvents: .TouchUpInside)
        }
        
        func popNew(sender: UIButton) {
            STPDPopNotification.popStringNotificationWithButton("Two Buttons", content: nil, leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "OK", rightButtonHandler: nil)
        }

* func popImageNotification(text: String, imageFile: UIImage?): 

        STPDPopNotification.popImageNotification("Regular", imageFile: UIImage(named: "small"))

* popImageNotificationWithButton(text: String, imageFile: UIImage?, leftButtonTitle: String, leftButtonHandler: ((leftButton: UIButton)->())?, rightButtonTitle: String, rightButtonHandler: ((rightButton: UIButton)->())?): 

        STPDPopNotification.popImageNotificationWithButton("Two Buttons", imageFile: UIImage(named: "small"), leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "Ok", rightButtonHandler: nil)


* clearAllNotification(): 

        STPDPopNotification.clearAllNotification()



