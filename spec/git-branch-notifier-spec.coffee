GitBranchNotifier = require '../lib/git-branch-notifier-core'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "GitBranchNotifier", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('git-branch-notifier')

  describe "when the git-branch-notifier:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.git-branch-notifier')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'git-branch-notifier:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.git-branch-notifier')).toExist()

        gitBranchNotifierElement = workspaceElement.querySelector('.git-branch-notifier')
        expect(gitBranchNotifierElement).toExist()

        gitBranchNotifierPanel = atom.workspace.panelForItem(gitBranchNotifierElement)
        expect(gitBranchNotifierPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'git-branch-notifier:toggle'
        expect(gitBranchNotifierPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.git-branch-notifier')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'git-branch-notifier:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        gitBranchNotifierElement = workspaceElement.querySelector('.git-branch-notifier')
        expect(gitBranchNotifierElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'git-branch-notifier:toggle'
        expect(gitBranchNotifierElement).not.toBeVisible()
