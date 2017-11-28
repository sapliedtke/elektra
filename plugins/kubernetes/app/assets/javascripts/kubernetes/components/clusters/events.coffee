# import
{ tr, td, h5, p, strong, div, i } = React.DOM
{ connect } = ReactRedux
{ loadClusterEvents } = kubernetes



Events = React.createClass

  componentDidMount: ->
    @props.handleLoadClusterEvents(@props.cluster.name)
    @startPollingClusterEvents()


  startPollingClusterEvents: () ->
    clearInterval(@pollingEvents)
    @pollingEvents = setInterval((() => @props.handleLoadClusterEvents(@props.cluster.name)), 60000)

  render: ->
    {cluster, events, handleLoadClusterEvents} = @props

    if events.length > 0
      tr className: 'cluster-events',
        td colSpan: '5',
          h5 null, "Events within the last hour:"
          for event in events
            div key: event.firstTimestamp,
              i className: "event-type #{event.type.toLowerCase()}"
              strong null,
                moment(event.firstTimestamp).format("HH:mm:ssZZ")
                if (event.count > 1)
                  " - "
                  moment(event.lastTimestamp).format("HH:mm:ssZZ")
                  " (#{event.count} times)"

              p null,
                event.message
                " (#{event.reason})"
    else
      tr null





Events = connect(
  (state, ownProps) ->
    console.log(state.clusters.events)
    clusterEvents = state.clusters.events[ownProps.cluster.name]
    events: (if clusterEvents? then clusterEvents else [] )


  (dispatch) ->
    handleLoadClusterEvents:  (clusterName) -> dispatch(loadClusterEvents(clusterName))


)(Events)


# export
kubernetes.ClusterEvents = Events
