# HATEOAS Explorer
This small application is a tool for parsing links in JSON responses from a RESTful service.
By making HTTP OPTIONS requests the tool will also present and allow interactions with resources.

Currently the tool supports the link formats that [Spring HATEOAS](http://projects.spring.io/spring-hateoas/) uses. Atom and HAL.

## Installing
Before running, you must install and configure the following one-time dependencies:

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/)
* [gulp.js](http://gulpjs.com/) - use the terminal command below
```bash
$ npm install -g gulp
```

Once the dependencies have been installed, enter the following in the terminal:
```bash
$ git clone git@github.com:robbanw/hateoas-explorer.git
$ cd hateoas-explorer
$ npm install
```


## Running
Enter the following in the terminal:
```bash
$ gulp
```

## Credit To
* [fatarrow](https://github.com/CaryLandholt/fatarrow)
