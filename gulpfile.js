var mandragora = require("mandragora-bucket"),
    gulp = require("gulp");

mandragora.config.entries = {
    "Main": {
        "name": "main",
        "dir": "public"
    }
};

mandragora.config.paths.src.push("example/**/*.purs");

mandragora(gulp);

gulp.task("default", ["deploy-main"]);
