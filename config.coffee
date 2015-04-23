APP_NAME = 'app'

BOWER_COMPONENTS =
	'angular': '1.3.15':
		scripts: 'angular.min.js'
	'angular-animate': '1.3.15':
		scripts: 'angular-animate.min.js'
	'angular-mocks': '1.3.15':
		scripts: 'angular-mocks.js'
	'angular-route': '1.3.15':
		scripts: 'angular-route.min.js'
	'angular-loading-bar': '0.7.1':
		scripts: 'build/loading-bar.min.js'
		styles:  'build/loading-bar.min.css'
	'bootstrap': '3.3.4':
		fonts:   'dist/fonts/**/*.{eot,svg,ttf,woff}'
		styles:  'dist/css/*.min.css'
	'angular-bootstrap': '0.12.1':
		scripts: 'ui-bootstrap-tpls.js'
	'graphdracula': 'https://github.com/strathausen/dracula.git':
		scripts: '{lib,vendor}/*.js'

SCRIPTS = [
	'**/angular.min.js'
	'**/angular-animate.min.js'
	'**/angular-mocks.js'
	'**/angular-route.min.js'
	'**/loading-bar.min.js'
	'**/ui-bootstrap-tpls.js'
	'**/raphael.js'
	'**/app.js'
	'**/*.js'
]

STYLES = [
	'**/bootstrap.min.css'
	'**/bootstrap-theme.min.css'
	'**/*.css'
]

module.exports = {APP_NAME, BOWER_COMPONENTS, SCRIPTS, STYLES}
