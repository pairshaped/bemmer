var gulp        = require('gulp'),
    coffee      = require('gulp-coffee');

function compileLitCoffee(chain, dest) {
  return chain.pipe(coffee({bare: true}))
    .pipe(gulp.dest(dest));
}

gulp.task('default', function() {
  compileLitCoffee(gulp.src(['source/bemmer-class.litcoffee', 'source/bemmer.litcoffee']), './')
  compileLitCoffee(gulp.src('source/react/react-bemmer.litcoffee'), './react')
})
