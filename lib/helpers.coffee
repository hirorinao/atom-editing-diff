fs = require "fs-plus"
path = require "path"
RepositoryGit = require './repository-git'
RepositoryFile = require './repository-file'

module.exports =
  repositoryForEditor: (editor) ->
    return null if not editor.getPath()?

    for directory, i in atom.project.getDirectories()
      if editor.getPath() is directory.getPath() or directory.contains(editor.getPath())
        if atom.project.getRepositories()[i]
          return new RepositoryGit(editor, atom.project.getRepositories()[i])
        else
          return new RepositoryFile(editor)
    null
