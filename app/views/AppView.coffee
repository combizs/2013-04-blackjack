class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">reset</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": ->
      $('.hit-button, .stand-button').attr 'disabled', 'disabled'
      @model.get('playerHand').stand()
      @model.get('dealerHand').stand()
    "click .reset-button": ->
      @model.set('playerHand', @model.get('playerHand').deck.dealPlayer())
      @model.set('dealerHand', @model.get('dealerHand').deck.dealDealer())
      @model.startGame()
      # console.log @model.attributes.deck
      @render()
  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
