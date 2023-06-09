// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FavoritesController from "./favorites_controller"
application.register("favorites", FavoritesController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MapController from "./map_controller"
application.register("map", MapController)

import PinController from "./pin_controller"
application.register("pin", PinController)

import PinnedController from "./pinned_controller"
application.register("pinned", PinnedController)

import RouteTrackingController from "./route_tracking_controller"
application.register("route-tracking", RouteTrackingController)

import SliderController from "./slider_controller"
application.register("slider", SliderController)
