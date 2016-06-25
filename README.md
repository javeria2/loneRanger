# Lone Ranger

>Lone ranger is a simple iOS application built with an idea of helping users by enabling them to directly ask their friends to pick them up when they don't have cash for an uber/taxi etc, some core functionalities included are: 

  - A user can sign in as both a rider/driver.
  - The first view controller for the rider shows a map kit view pinned at their current location which can be made visible to the drivers by hitting the button below the map kit.  
  - The first view controller as a driver shows the list of current ride requests along with the distance from the driver's current location in a UITableView. 
  - Tapping on a cell navigates directly to Apple maps or google maps _(if installed)_ which handles further navigation to rider location. 
  - Once arranged a pick-up, the rider can directly see the geo-location and the distance of the driver from rider's current location on the mapKitView. 
  - Rider can also cancel the request at any time. 

>Basic information:

- back-end handled entirely on parse server, deployed on heroku. 
- front-end/interface elements handled through the MainStoryBoard/UIInterface builder. 

> IDE/language:

- Xcode 7.1.2/Swift 2


> Further improvement provisions: 

- Push notifications enabled for the driver when a ride is cancelled. (can't be tested on the iOS simulator, sigh!) 
- Driver/Rider's picture upload
- Optional billing and payment gateway

> some screens:

<a href="url"><img src="https://raw.githubusercontent.com/javeria2/loneRanger/master/screens/Screen%20Shot%202016-06-25%20at%209.29.51%20AM.png" align="left" height="430" width="250" ></a>
<a href="url"><img src="https://raw.githubusercontent.com/javeria2/loneRanger/master/screens/Screen%20Shot%202016-06-25%20at%209.29.29%20AM.png" align="left" height="430" width="250" ></a>
<a href="url"><img src="https://raw.githubusercontent.com/javeria2/loneRanger/master/screens/Screen%20Shot%202016-06-25%20at%209.30.47%20AM.png" align="left" height="430" width="250" ></a>
