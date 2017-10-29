
"use strict";

load("sbbsdefs.js")
load("http.js");
load("modopts.js");

var SpyLister = function () {

    var server = "http://138.197.173.20:4567/api/v0";

    var getJSON = function (path) {
        try {
            return JSON.parse(
                new HTTPRequest().Get(server + (typeof path == "undefined" ? "" : path))
            );
        } catch (err) {
            log("SpyLister._getJSON: " + err);
            return null;
        }
    };

    this.getnodes = function () {
        return getJSON("/getnodes");
    };
    this.getnode = function (name) {
        return getJSON("/getnode/" + name);
    };
};

log(SpyLister.getnodes());
log(SpyLister.getnode("euphoria"));
