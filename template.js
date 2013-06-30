exports.description = "The Blackest Coffee Ever"

exports.template = function(grunt, init, done) {
  props = {}
  props.dependencies = {
    "bower":                  "0.6.6",
    "jade":                   ">= 0.27.7",
    "coffee-script":          "1.3.3",
    "nib":                    "~0.9.0",
    "stylus":                 "~0.31.0",
    "colors":                 "0.6.x",
    "grunt":                  "0.4.x",
    "grunt-contrib-coffee":   "0.4.0",
    "grunt-contrib-concat":   "0.1.x",
    "grunt-contrib-stylus":   "0.4.x",
    "grunt-contrib-jade":     "0.4.x",
    "grunt-contrib-copy":     "0.4.x",
    "grunt-contrib-clean":    "0.4.x",
    "grunt-contrib-watch":    "0.2.x",
    "grunt-contrib-connect":  "~0.3.0",
    "grunt-karma":            "~0.3.0"
  }

  files = init.filesToCopy(props)
  init.copyAndProcess(files, props)
  init.writePackageJSON('package.json', props)
  done()
}
