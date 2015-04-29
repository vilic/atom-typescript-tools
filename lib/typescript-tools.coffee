TypescriptToolsView = require './typescript-tools-view'
{CompositeDisposable} = require 'atom'

module.exports = TypescriptTools =
  typescriptToolsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @typescriptToolsView = new TypescriptToolsView(state.typescriptToolsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @typescriptToolsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'typescript-tools:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @typescriptToolsView.destroy()

  serialize: ->
    typescriptToolsViewState: @typescriptToolsView.serialize()

  toggle: ->
    console.log 'TypescriptTools was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
