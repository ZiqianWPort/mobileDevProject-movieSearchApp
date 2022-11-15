# swift project: movie search app

<h3>Notice</h3>
<p>
Welcome to another one of my swift project! This is an in-class project from course CSE 438 "Mobile Application Development" taught by professor Todd Sproull at Washington University in St.Louis. The data used in this app are fetched from The Movie Database(TMDB) using an API key.
</p>
<p>
Because this app is not published in appstore, in order to test and view its functionalities, please follow these steps:<br>
1. please ensure you have Xcode installed on your laptop<br>
2. if you have Xcode installed, please download the code from github, and you should see a folder for it in the directory you downloaded it to.<br>
3. Once you opened the folder, you should see a file called "JeffreyWang-Lab3.xcodeproj". Please click on it and the code will be opened in Xcode automatically.<br>
4. On the top-left side of your Xcode interface, there should be a triangular play button. Click on it and it'll launch an iPhone 13 Pro simulator for you which you can test the app on.<br>
5. Since this is a rapid prototype and there's no constraints setting in this project, please ensure that the simulator is set to "iPhone 13 Pro" for best UI display<br>
</p>
<p>
This code has been made public only for my personal portfolio purposes. If you are a student at WashU, please note that I do not grant permission for anyone to turn in this code as their in-class project or use part of it in their assignment.
</p>

#

<h3>Project Description</h3>
<p>
This project is a movie search app that allows users to search for movies in the TMDB database's record and see detailed information about the movie. I'll explain the app's functionalities one by one:</p>
<p>
1. search:<br>
There are three buttons on the tab bar at the bottom of the app's user interface. The first one, which is also the one users will be taken to automatically when they launch the app, is for searching movies from TMDB. The users can enter the name of a movie they wish to search for using the search bar on the top of the user interface (e.g. Harry Potter), and movies associated with that name will be shown to the users in the form of a list of clickable cells displaying the movie's name and poster. <br>
2. detailed info:<br>
In order to see more detailed information about a movie that came out of the search results, users can click on the movie's poster, and they'll be directed to another page with more detailed info about that specific movie they clicked on. The detailed info includes the movie's release date, their score on TMDB, how many people scored it, and an overview of the movie. The overview of the movie will be displayed on a separate page from the oher detailed info. There is a button labeled "overview" on the detailed info page that takes the users to an overview about the movie.<br> 
In the overview page, there is a button labeled "read the text", which will read out the text for the users. This read-text function is included as an attempt of mine to work on the accessibility features of the apps I develop. I hope this functionality may be useful for those with disabilities affecting their ability to read text.<br>
3. favorite list:<br>
The second button on the tab bar at the bottom of the user interface takes the users to their favorite movie list. There are two ways users can add movies to their favorite list:<br>
  - when the users see the movie in their search result, they can long press on its poster, and a context menu will pop up, giving them the option to add that movie to their favorite list.<br>
  - when the users click on a movie and enters its detailed-info page, there's a button labeled "add to favorite" that will add that movie to the user's favorite list.<br>
In the user's favorite-list page, there's a "remove all movie from favorite" button that'll erase all movies from the user's favorite list. This action cannot be undone, and there'll be a warning note to ask you if you really wish to proceed with it. If the users wish to delete a movie from their favorite list, they can do a right swipe on the movie's cell in the list, and a button to delete that movie will appear.<br>
4. history list:<br>
The third button on the tab bar at the bottom of the user interface takes the users to their browsing history list. Every movie the user clicked on to see more detailed info about will be automatically added to the user's browsing history list. Just like in the favorite movie page, in the user's browsing history page, there's also a "remove all movie from history" button that'll erase all movies from the user's browsing history. Also, if the users wish to delete a movie from their browsing history, they can do a right swipe on the movie's cell in the list, and a button to delete that movie will appear.<br>
5. search on YouTube:<br>
In every movie's detailed-info page, there's a button labeled "YouTube", which takes the users to a web view of a search for the movie's name on YouTube.com. This function will be your friend when you want to see a trailer of the movie or see some fandom works people made for it. <br>
</p>
<p>The userDefaults database is used in this app to store your data of movies added to favorite/history list. So, the two lists will be there for you when you turn your Xcode and simulator down and turn them back on again. Have fun with it!</p>
