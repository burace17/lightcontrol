light control
===================

This is a simple iOS app I made that controls Phillips Hue lights. It's largely designed with my house in mind so if you'd like to use it, you'll have to jump into the code. 

LightControlKit is essentially the API. You can use it with lots of different iOS targets, as it's a standalone framework. The API has an extra JSON field that it submits as sort of a security measure, since I have the Node.js service it talks to exposed to the Internet. Obviously, I recommend changing this field in the app and the Node.js server if you wish to use my code. I added the Node.js server so I could control my lights from over the Internet with a simple server instead of exposing the light control device to the Internet. 

The Node.js server is also on my github profile. 

This repository also contains a very basic iOS 8 notification center widget. I haven't spent much time with it as I just wanted to see how hard it is to make a notification center widget. 
