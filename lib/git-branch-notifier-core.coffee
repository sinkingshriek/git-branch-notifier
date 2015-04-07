module.exports =
  fs: require('fs')
  wasIsBranches: []
  checkBranch: (branch) ->
    if @wasIsBranches[1] != branch
      console.log 'Starting to attach event...'
      @attachEvent()

  activate: (state) ->
    atom.workspaceView.command "git-branch-notifier:start", => @start()

  start: ->
    repo = atom.project.getRepo()
    if repo && repo.projectAtRoot && repo.branch
      _branch = repo.branch
      @wasIsBranches = @arrayPlus 2, [_branch]
      console.log '.git and branch found. \nStarted listening'
      Object.defineProperty repo, "branch", {
        get: () ->
          _branch
        set: ((v) ->
          console.log('switching branch')
          @wasIsBranches.pusher v
          @checkBranch v).bind(this)
      }
    else
      alert 'Please refresh the editor. \nNo .git directory or any branch found yet!'

  arrayPlus: (size, opts) ->
    tmp = if Array.isArray opts then opts else []
    tmp.pusher = ->
      args = Array.prototype.slice.apply(arguments, null)
      args.forEach ((arg) ->
        this.unshift(arg) ;
        ).bind(this)
      if this.length > size
        this.pop()
      this.length
    return tmp

  attachEvent: ->
    atom.workspace.getPaneItems().forEach ((pane, i) ->
      panePath = pane.getPath && pane.getPath()
      if !@fs.existsSync(panePath)
        console.log('pane:' + i + ' has event attached to it now')
        @onDidChangeOnce(pane)
    ).bind(this)

  onDidChangeOnce: (pane)->
    flag =
      state: ''
    paneEvent = pane.onDidChange (->
      console.log 'File belongs to' + @wasIsBranches[1]
      branch = if @wasIsBranches[1] then "this is file from: " + @wasIsBranches[1] else "new file found"
      #TODO:- And maybe reinvoke this when tab gets
      #       active
      alert(branch)
      flag.state = true
    ).bind(this)
    Object.defineProperty flag, "state",
      set: (->
        console.log('disposing now')
        this.dispose()).bind(paneEvent)
