#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model
  initialize: ->
    deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @startGame(deck)
  startGame: (deck)->
    @set 'deck', deck
    @get('playerHand').on('bust', ->
      @endGame('Dealer', 'wins')
    , this)
    @get('dealerHand').on('bust', ->
      @endGame('Player', 'wins')
    , this)
    @get('dealerHand').on('compareScore', ->
      @compareScore()
    , this)
    @checkScore('dealerHand')
    @checkScore('playerHand')
  winner: ->
  checkScore: (whom)->
    if @get(whom).scores() == 21
      @endGame(whom, 'blackjack')
  compareScore: =>
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    deck = @get 'deck'
    if player.scores() <= 21 and player.scores() > dealer.scores()
      @endGame('Player', 'wins')
    if dealer.scores() <= 21 and player.scores() < dealer.scores()
      @endGame('Dealer', 'wins')
    if player.scores() == dealer.scores()
      @endGame('Push', 'nobody wins' )
      @startGame(deck)
  endGame: (whom, action)->
    hiddenCard = @get('dealerHand').models[0]
    if !hiddenCard.attributes.revealed
      hiddenCard.flip()
    alert whom + " " + action + "!"