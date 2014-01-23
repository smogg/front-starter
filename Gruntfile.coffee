module.exports = (grunt)->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		copy:
      html:
        files: [
          expand: true
          src: './*.html'
          dest: './build/'
        ]
      css:
        files: [
          expand: true
          src: 'css/**/*.css'
          dest: './build/'
        ]
      fonts:
        files: [
          expand: true
          src: 'fonts/**/*.*'
          dest: './build/'
        ]
      icons:
        files: [
          expand: true
          src: 'icons/**/*.*'
          dest: './build/'
        ]

		sass:
			dev:
				options:
					style: 'compressed'
					includePaths: require('node-bourbon').includePaths
				expand: true
				cwd: './scss'
				src: ['*.scss', '**/*.scss']
				dest: './css/'
				ext: '.css'


		coffee:
			compile:
      	files: {"js/app.js": "js/app.coffee"}
			


		uglify:
			options:
				mangle: false
			scripts:
				files: [
					expand: true
					cwd: 'js/'
					src: '**/*.js'
					dest: './build/js/'
				]


		imagemin:
			options: { optimizationLevel: 3}
			images:
				files: [
					expand: true
					cwd: './images'
					src: ['**/*.{png,jpg,gif}']
					dest: './build/images/'
				]

		browser_sync:
      files:
        src: ['css/*.css', 'images/*.{jpg,png,gif}', '*.html', 'js/*.js']
      options:
        debugInfo: true
        watchTask: true
        server:
          baseDir: '.'
        ghostMode:
          scroll: true
          links: true
          forms: true


    watch:
      styles:
        files: ["scss/*.scss", 'scss/*/*.scss']
        tasks: ['sass']
      scrips:
        files: ["js/*.coffee"]
        tasks: ["coffee"]


  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['sass', 'coffee', 'browser_sync', 'watch']
  grunt.registerTask 'build', ['copy', 'uglify', 'imagemin']