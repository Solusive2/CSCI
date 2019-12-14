## **Project Type:** C
## **Group Members:** Gavin Doebbert
## **Link to Live App:** https://csci-4131-final-blog.herokuapp.com/
## **Github Link:** https://github.com/Solusive2/CSCI
## **List of Technologies/API's Used:**
	Flask 
	SqlAlchemy
	Werkzeug
	Flask-Bootstrap
	Jinja




## **List of Controllers**

* ### **'/' or index:**
  * Validates new posts from the user and stores them in the database, also gets followed posts and posts by user, as well as checks if there are more pages of posts. This route renders the index.html with a home title.

* ### **/explore**
  * Gets posts in order (most recent first) and checks if there is a next or previous page. This route renders the index.html with an explore title.

* ### **/login**
  * Redirects user to index page if already logged in, else it validates a submitted username and password and logins the user in if correct. This route renders login.html

* ### **/logout**
  * Logs the user out and redirects them to index, which would direct them to the login route

* ### **/register**
  * Redirects user to index if logged in, else it processes the new user. After the user creates a valid account, they are directed to the login route

* ### **/user/<username>**
  * Gets the user with specified user name, gets their posts and checks if there are more pages of posts. This route renders user.html.

* ### **/edit_profile**
  * Gets the form from for editing the profile and checks its validity. If it is valid, the database is updated 

* ### **/reset_password_request**
  * If the user is signed in, it redirects them to the index. Else it validates the password request and sends a reset request to the user's email. This route renders reset_password_request.html

* ### **/reset_password/<token>**
  * If the user is signed in, it redirects them to the index. Else it checks if the token(that was sent to email) and user are both valid. It then adds the new password to the database and sends the user to the login route. This route renders reset_password.html

* ### **/follow/<username>**
  * Gets the specified user, checks if they exist and other errors, and updates the database. It then redirects the user to the specified user's page.

* ### **/unfollow/<username>**
  * Gets the specified user, checks if they exist and other errors, and updates the database. It then redirects the user to the specified user's page.





## **List of Views:**


* ### **_post.html**
  * Html used to generate a post, including the post's content, as well as the author's avatar and username.

* ### **404.html**
  * An error message for when something isn't found or is not the database.

* ### **500.html**
  * An error message for an unspecified or unknown error.

* ### **base.html**
  * Contains the navbar which allows a user to access other routes, also displays flashed messages. It is also present on every other view.

* ### **edit_profile.html**
  * Allows user to submit a form to edit their account.

* ### **index.html**
  * Greets the user and displays posts, it also allows a user to submit posts.

* ### **login.html**
  * Allows the user to sign it and provides links for a user to register or reset their password.

* ### **register.html**
  * Allows the user to submit a registration form to create an account.

* ### **reset_password.html**
  * Page generated after a reset request, it allows the user to submit a form to reset their password.

* ### **reset_password_request.html**
  * Page that allows the user to fill in a form for a password reset request.

* ### **user.html**
  * Page displaying a user profile and that user's information. Allows a user to follow/unfollow other users or see a specific user's posts. It also allows a user to edit their own profile.






# **List of Tables:**
**id**, **user_id**, **follower_id**, and **followed_id** are all the same. They are the association used to join the tables.
	

### **User Table**
* id
* username
* email
* password_hash

This table contains user information. The columns contain their login details such as usernames and password hashes, a user's email, and an id.

### **Post Table**
* id
* body
* timestamp
* user_id

This Table stores the content and details of a post. The columns contain who posted it, when it was posted, and what the post contains. Each post also has its own id

### **Follower Table**

* follower_id
* followed_id

A table representing a many to many relationship between users and other users. Specifically who is following who.



## **References/Resources:**

From tutorial by Miguel Grinberg:   
	https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world
