{CompositeDisposable} = require 'atom'
{Emitter, Disposable} = require 'event-kit'

module.exports =
class Repository
  constructor: ->
    @subscriptions = new CompositeDisposable
    @emitter = new Emitter

  onDidChange: (callback) ->
    @emitter.on 'did-change', callback

  getLineDiffs: ->
    # GitRepository.getLineDiffs pattern
    []

  deactivate: ->
    @subscriptions.dispose()
