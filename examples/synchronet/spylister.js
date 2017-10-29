
"use strict";

load("http.js");
load("modopts.js");

var SpyLister = function() {

    var server = "http://spylister.euphoriabbs.com/api/v0";

    var getJSON = function(path) {
        try {
            return JSON.parse(
                new HTTPRequest().Get(server + (typeof path == "undefined" ? "" : path))
            );
        } catch (err) {
            log("SpyLister._getJSON: " + err);
            return null;
        }
    };

    this.filelist = function(path) {
        return getJSON("/filelist");
    };
};

log(SpyLister.filelist);
