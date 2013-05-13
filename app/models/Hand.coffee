class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce
      newScore = [score, score + 10]
      if newScore[1] <= 21 then [score+10] else [score]
    return [score]
  stand: ->

  dealer: =>
    @models[0].flip()
    while @scores() < 17
      @hit()