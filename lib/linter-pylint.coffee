linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
findFile = require "#{linterPath}/lib/util"

class LinterCoffeelint extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: 'source.python'

  # A string, list, tuple or callable that returns a string, list or tuple,
  # containing the command line (with arguments) used to lint.
  cmd: ["pylint"
        "--reports=n"
        "--persistent=n"
        "--msg-template='{line}:{column}:{msg_id}:{msg}'"].join(' ')

  linterName: 'pylint'

  # A regex pattern used to extract information from the executable's output.
  regex: '(?<line>\\d+):(?<column>\\d+):((?<error>[RFE])|(?<warning>[CIW]))\\d+:(?<message>.*)'

  regexFlags: 's'

  constructor: (editor)->
    super(editor)

    config = findFile(@cwd, ['.rcfile'])
    if config
      @cmd.push "--rcfile=#{config}"

    atom.config.observe 'linter-pylint.pylintExecutablePath', =>
      @executablePath = atom.config.get 'linter-pylint.pylintExecutablePath'

  destroy: ->
    atom.config.unobserve 'linter-pylint.pylintExecutablePath'

module.exports = LinterCoffeelint
