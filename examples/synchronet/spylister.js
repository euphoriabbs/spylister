
"use strict";

load("sbbsdefs.js")
load("http.js");
load("modopts.js");

var SpyLister = function () {

    var server = "http://spylister.euphoriabbs.com/api/v0";

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

    this.list = {};

    this.list.systems = function () {
        return getJSON("/list/boards");
    };
    this.list.files = function (name) {
        return getJSON("/list/files/" + name);    };

};
