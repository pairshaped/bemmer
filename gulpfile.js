var gulp        = require('gulp'),
    watch       = require('gulp-watch'),
    coffee      = require('gulp-coffee'),
    clean       = require('gulp-clean'),
    jasmine     = require('gulp-jasmine');

gulp.task('test', ['compile'], function() {
  require('coffee-script/register');

  return gulp.src('spec/*.coffee')
    .pipe(jasmine())
});

gulp.task('compile', ['clean'], function() {
  return gulp.src('source/bemmer.litcoffee')
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('./'))
});

gulp.task('clean', function() {
  return gulp.src('bemmer.js', {read: false}).pipe(clean({ force: true }))
});

gulp.task('watch', function() {
  return watch('source/*.litcoffee').pipe(function() {
    gulp.start('test');
  })
});

gulp.task('default', ['test']);
