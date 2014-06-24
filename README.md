AppPartner Demo
================

##DESCRIPTION

This is the mobile assignment for the hiring process of AppPartner.

The assignment consists of three coding tasks:

- The user has to be able to pull his friends list from Facebook, and see them listed in a scrollable list view.
- A ping test to an Amazon server which should return a response on how long it took.
- An animation test which allows the user to interact with the AppPartner logo.

##TASKS

- [x] Build out the UI fully
- [x] Build out Facebook component
- [x] Build out server ping component
- [x] Build out animation component

##USER INTERFACE

The user interface appears to consist of four views, along with an initial splash screen.

- Splash screen
- Coding tasks view
  - Facebook friends list view
    - Scrollable list (TableView)
      - Custom cells
    - Reload data will refresh friends list
    - Tapping won't do anything
  - Server ping view
    - Asynchronous post request
    - Display response time
    - Amazon server with parameter and value
  - Animation view
    - Spin around 360 degrees
    - Drag around screen by touching and dragging
    - Other ideas pending...


##FACEBOOK COMPONENT

Apparently, Facebook has recently decided to not allow developers to pull the list of user's Facebook friends. You can only view friends who have downloaded the same app as you. I was only able to have one of my friends download the same app, so I only had one friend for my list, which prevented me from working with a tableView with more than one friend.

##ANIMATION COMPONENT

Spinning and dragging has been implemented for the animation component. In addition to that, you can rotate the logo using two fingers, and you can zoom in and out on the logo by pinching it. Furthermore, all gestures can be recognized simultaneously, so gesture away!

##OTHER NOTES

I had some issues with the font sizes. All the fonts ended up looking bigger than the PDF even though I used the given font sizes.

##HOURS

This is where you'll log your hours spent on each part of the project.

Tasks | Hours
----- | -----
Planning | 1
Build UI | 3
Post Request | 1.5
Facebook SDK | 5
Animation | 2
