#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    deck = new Deck()
    @startGame(deck)
    @get('playerHand').on('bust', ->
      alert('Player bust')
      @endGame('Dealer')
    , this)
    @get('dealerHand').on('bust', ->
      alert('Dealer bust')
      @endGame('Player')
    , this)
    @get('dealerHand').on('compareScore', ->
      @compareScore()
    , this)
  startGame: (deck)->
    @set 'deck', deck
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @checkScore('dealerHand')
    @checkScore('playerHand')

  winner: ->
  checkScore: (whom)->
    if @get(whom).scores() == 21
      @endGame(whom)
  compareScore: =>
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    deck = @get 'deck'
    if player.scores() <= 21 and player.scores() > dealer.scores()
      @endGame('Player')
    if dealer.scores() <= 21 and player.scores() < dealer.scores()
      @endGame('Dealer')
    if player.scores() == dealer.scores()
      @startGame(deck)
      alert 'Push! brah'
  endGame: (whom)->
    hiddenCard = @get('dealerHand').models[0]
    if !hiddenCard.attributes.revealed
      hiddenCard.flip()
    alert whom + ' won!'