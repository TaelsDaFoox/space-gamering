extends Node
var currentVehicle = null
var zoomDist:=0.0
var targetPos := Vector3.ZERO
var homePos :=Vector3(-6.0,1.0,18.0)
var stations = []
var deliveryDialogue:=["Could you deliver this to Station [S] for me?","I have a package that needs to be delivered to Station [S].","Please, deliver this to Station [S]!","I gotta mail this to Station [S], would you mind delivering it?","Deliver this to Station [S], would ya?", "This was sent here, but the address says it was supposed to go to Station [S]... would you mind shipping it there?"]
var recieveDialogue:=["Oh, that's my package! Thank you!","Hey, it finally arrived. Thanks!","It's here! Thanks for delivering it!"]
var targetStation
var ship
var player
var mainUI
