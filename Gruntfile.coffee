module.exports = (grunt) ->

  grunt.initConfig

    copy:
      fonts:
        files: [
          expand: true
          cwd: 'bower_components/font-awesome/fonts'
          src: ['**/*']
          dest: 'fonts'
        ]

    concat:
      js:
        options:
          separator: ";\n"
        src: [
          'bower_components/jquery/dist/jquery.min.js'
          'js/**/*.js'
        ]
        dest: 'prod.js'

    uglify:
      options:
        mangle: false
      js:
        files:
          'prod.js': ['prod.js']

    less:
      style:
        options:
          cleancss: true
          report: "min"
        files:
          "style.css": "less/style.less"

    watch:
      php:
        files: ['**/*.php']
        tasks: []
        options:
          livereload: true
      js:
        files: ['js/**/*.js']
        tasks: ['concat:js', 'uglify:js']
        options:
          livereload: true
      less:
        files: ['less/**/*.less']
        tasks: ['less:style']
        options:
          livereload: true


  # Build project
  grunt.registerTask 'build', [
    'copy'
    'concat:js'
    'uglify:js'
    'less:style'
  ]

  # Start dev environments using nodemon
  grunt.registerTask 'dev', [
    'build'
    'watch'
  ]


  # Load grunt modules
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
