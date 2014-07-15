module.exports = (grunt) ->

  grunt.initConfig

    # Copy Font Awesome files to /fonts directory
    copy:
      fonts:
        files: [
          expand: true
          cwd: 'bower_components/font-awesome/fonts'
          src: ['**/*']
          dest: 'fonts'
        ]

    # Concatenate all JavaScript files in the /js directory
    concat:
      js:
        options:
          separator: ";\n"
        src: [
          'bower_components/jquery/dist/jquery.min.js'
          'js/**/*.js'
        ]
        dest: 'prod.js'

    # Minify the concatenated JavaScript output
    uglify:
      options:
        mangle: false
      js:
        files:
          'prod.js': ['prod.js']

    # Compile LESS stylesheet into /style.css
    less:
      style:
        options:
          cleancss: true
          report: "min"
        files:
          "style.css": "less/style.less"

    # During developement, watch files and recompile/reload
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

  # Build theme
  grunt.registerTask 'build', [
    'copy'
    'concat:js'
    'uglify:js'
    'less:style'
  ]

  # Build theme and start watching files (for development)
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