path = require 'path'

module.exports =
  configDefaults:
    coffeelintExecutablePath: path.join __dirname, 'pylint'

  activate: ->
    console.log 'activate linter-pylint'
