class window.HandView extends Backbone.View

  initialize: -> 
    @collection.on 'change', @render, @
    #why doesn't 'add' trigger 'change'?
    @collection.on 'add', @render, @
    @render()
  render: -> 
    @$el.html @collection.map (card) -> new CardView(model: card).el
