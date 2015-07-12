light control
===================

This is a simple iOS app I made that controls Phillips Hue lights. It's largely designed with my house in mind so if you'd like to use it, you'll have to jump into the code. 

LightControlKit is essentially the API. I added an extra field to the JSON it submits as sort of a security measure as it's designed to talk with a Node.js server which will talk to the Phillips Hue light control device. I added the Node.js server so I could control my lights from over the Internet with a simple server instead of exposing the light control device to the Internet. 

The Node.js server is also on my github profile. 

This repository also contains a very basic iOS 8 notification center widget. I haven't spent much time with it as I just wanted to see how hard it is to make a notification center widget. 
