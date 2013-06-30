module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-karma"

  grunt.initConfig
    package: grunt.file.readJSON "package.json"

    coffee:
      compile:
        files:
          "build/js/app.js": [
            "app/scripts/app.coffee"
            "app/scripts/**/*.coffee"
          ]
    concat:
      js:
        dest: "build/js/vendor.js"
        src: [
          "vendor/bower/jquery/jquery.js"
          "vendor/bower/underscore/underscore.js"
        ]
      css:
        dest: "build/css/app.css"
        src: ["tmp/import.css"]
    stylus:
      compile:
        options:
          use: [require "nib"]
        files:
          "tmp/import.css": ["app/styles/import.styl"]
    jade:
      files:
        expand: true
        cwd: "app"
        src: ["**/*.jade"]
        ext: ".html"
        dest: "build"
    clean: ["tmp"]
    connect:
      server:
        options:
          port: 8080
          base: "build"
          keepalive: true
    watch:
      js:
        files: ["app/**/*.coffee"]
        tasks: ["coffee"]
        options: interrupt: true
      css:
        files: ["app/**/*.styl"]
        tasks: ["stylus", "concat:css", "clean"]
        options: interrupt: true
      jade:
        files: ["app/**/*.jade"]
        tasks: ["jade"]
        options: interrupt: true
    karma:
      unit:
        configFile: "test/karma.conf.js"
        autoWatch: true

  # Helper Functions

  spawn = (options, done = ->) ->
    options.opts ?= stdio: "inherit"
    grunt.util.spawn options, done

  # Helper Routines

  runDevelopment = (tests = false) ->
    @async()

    spawn
      grunt: true
      args: ["build"]
    , ->
      spawn
        grunt: true
        args: ["watch"]

      spawn
        grunt: true
        args: ["connect"]
        
      if tests
        spawn
          grunt: true
          args: ["karma"]

  # Custom Tasks

  grunt.registerTask "build", "Build all source code", [
    "coffee"
    "stylus"
    "jade"
    "concat"
    "clean"
  ]

  grunt.registerTask "lite", "Build, Watch and Connect", ->
    runDevelopment.call this

  grunt.registerTask "default", "Build, Watch, Connect, and Karma", ->
    runDevelopment.call this, true
