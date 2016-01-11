{CompositeDisposable} = require 'atom'
EditingDiffView = require './editing-diff-view'
DiffListView = null

diffListView = null
toggleDiffList = ->
  editor = atom.workspace.getActiveTextEditor()
  DiffListView ?= require './diff-list-view'
  diffListView ?= new DiffListView()
  diffListView.toggle()

module.exports = EditingDiff =
  config:
    showIconsInEditorGutter:
      type: 'boolean'
      default: true
      description: 'Show colored icons for added (`+`), modified (`·`) and removed (`-`) lines in the editor\'s gutter, instead of colored markers (`|`).'

  activate: ->
    atom.workspace.observeTextEditors (editor) ->
      new EditingDiffView(editor)
      atom.commands.add(atom.views.getView(editor), 'editing-diff:toggle-diff-list', toggleDiffList)

  deactivate: ->
    diffListView?.cancel()
    diffListView = null
