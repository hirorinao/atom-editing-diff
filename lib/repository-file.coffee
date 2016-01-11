Repository = require './repository'
jsdiff = require "diff"

module.exports =
class RepositoryFile extends Repository
  constructor: (@editor) ->
    super

    @subscriptions.add @editor.getBuffer().onDidConflict =>
      @emitter.emit 'did-change'
    @subscriptions.add @editor.getBuffer().onDidSave =>
      @emitter.emit 'did-change'

  getLineDiffs: ->
    diffs = jsdiff.diffLines(@editor.getBuffer().cachedDiskContents, @editor.getText())

    # GitRepository.getLineDiffs pattern
    lines = []
    newRow = 1
    oldRow = 1
    line = {newStart: 0, newLines: 0, oldStart: 0, oldLines: 0}

    for {count, added, removed} in diffs
      if added or removed
        line.newStart = newRow
        line.oldStart = oldRow

      if added
        line.newLines = count
      if removed
        line.oldLines = count

      if not removed
        newRow += count
      if not added
        oldRow += count

      if not added and not removed and (line.newLines or line.oldLines)
        lines.push(line)
        line = {newStart: 0, newLines: 0, oldStart: 0, oldLines: 0}

    if line.newLines or line.oldLines
      lines.push(line)

    return lines
