# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).


## [Unreleased]
### Added
- build.sh supports building several images out of one context
### Changed
- splitted rainloop build file into two
- not removing default nginx config and index file from image
- php-fpm is logging into stdout/stderr now
- communication between nginx and php-fpm changed from unix socket to TCP socket
### Fixed
- redirecting nginx error.log to stderr

## [0.1.0] - 2018-08-09
### Added
- mininit based nginx docker image
- mininit based php-fpm docker image
- build.sh to automate building and tagging of a number of images
- rainloop image and chart
