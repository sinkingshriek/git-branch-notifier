GitBranchNotifierView = require './git-branch-notifier-view'
{CompositeDisposable} = require 'atom'

module.exports = GitBranchNotifier =
  gitBranchNotifierView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @gitBranchNotifierView = new GitBranchNotifierView(state.gitBranchNotifierViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @gitBranchNotifierView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'git-branch-notifier:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @gitBranchNotifierView.destroy()

  serialize: ->
    gitBranchNotifierViewState: @gitBranchNotifierView.serialize()

  toggle: ->
    console.log 'GitBranchNotifier was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
