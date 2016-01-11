Repository = require './repository'

module.exports =
class RepositoryGit extends Repository
  constructor: (@editor, @gitRepository) ->
    super

    @subscriptions.add @gitRepository.onDidChangeStatuses =>
      @emitter.emit 'did-change'
    @subscriptions.add @gitRepository.onDidChangeStatus (changedPath) =>
      @emitter.emit 'did-change'  if changedPath is @editor.getPath()

  getLineDiffs: ->
    @gitRepository.getLineDiffs(@editor.getPath(), @editor.getText())
