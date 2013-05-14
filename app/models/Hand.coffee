class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer)->

  hit: =>
    @add(@deck.pop()).last()
    if @scores() > 21
      @.trigger('bust')
  stand: =>
    if @isDealer
      unless @models[0].attributes.revealed then @models[0].flip()
      if @scores >= 21 then return
      while @scores() < 17
        @hit()
      @.trigger('compareScore')
  scores: =>
    score = @reduce (score, card)->
      score + card.get 'value'
    , 0
    if @hasAce()
      if @isDealer and score+10 <= 21 then score+=10
      if !@isDealer and score+10 <= 21 then score+=10
    return score
  viewScores: =>
    score = @reduce (score, card)->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if @hasAce()
      if @isDealer and [score].revealed and [score+10] <= 21 then [score+=10]
      if !@isDealer and [score+10] <= 21 then [score+=10]
    return [score]
  hasAce: =>
    return @reduce (memo, card)->
      memo or card.get('value') is 1
    , false
