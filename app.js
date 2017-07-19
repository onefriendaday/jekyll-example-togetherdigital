// Better would be to implement a plugin like https://github.com/awood/hawkins

var express = require('express')
var fs = require('fs')
var cors = require('cors')
var app = express()
var exec = require('child_process').exec

function puts(error, stdout, stderr) {
  console.log(stdout)
}

app.use(cors())

app.get('/', function (req, res) {
  exec('bundle exec jekyll build', function(error, stdout, stderr) {
    console.log(stdout)
  	res.send('rebuilt')
  })
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})

exec('bundle exec jekyll serve', puts)