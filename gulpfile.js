'use strict' 

var gulp = require('gulp'),
    purescript = require('gulp-purescript'),
    runSequence = require("run-sequence"),
    browserify = require("browserify"),
    plumber = require("gulp-plumber"),
    source = require("vinyl-source-stream"),
    buffer = require("vinyl-buffer");


function sequence () {
    var args = [].slice.apply(arguments);
    return function() {
        runSequence.apply(null, args);
    };
}

var sources = [
    'src/**/*.purs',
    'bower_components/purescript-*/src/**/*.purs'
];

var foreigns = [
    'src/**/*.js',
    'bower_components/purescript-*/src/**/*.js'
];

var exampleSources = [
    'example/src/**/*.purs'
];

var exampleForeigns = [
    'example/src/**/*.js'
];

gulp.task('docs', function() {
    return purescript.pscDocs({
        src: sources,
        docgen: {
            "Control.UI.ZClipboard": "docs/Control.UI.ZClipboard.md"
        }
    });
});

gulp.task("example", function() {
    return purescript.psc({
        src: sources.concat(exampleSources),
        ffi: foreigns.concat(exampleForeigns)
    });
});

gulp.task("bundle", ["example"], function() {
    return purescript.pscBundle({
        src: "output/**/*.js",
        output: "node_modules/psc.js",
        main: "Main",
    });
});

gulp.task("browserify", ["bundle"], function() {
    return browserify({entries: ["node_modules/psc.js"]})
        .bundle()
        .pipe(plumber())
        .pipe(source("psc.js"))
        .pipe(buffer())
        .pipe(gulp.dest("example"));
});

gulp.task("default", sequence("docs", "example"));

