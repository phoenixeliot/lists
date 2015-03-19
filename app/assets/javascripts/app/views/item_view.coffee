class App.views.ItemView extends Backbone.View
  events:
    'click .item__title': 'toggleDisplay'
    'click .item__edit': 'showFormView'

  initialize: (item) ->
    @item = item
    @children = item.children
    @childViews = (new App.views.ItemView(child) for child in item.children) || []

  render: ->
    $template = $(HandlebarsTemplates['item'](@item))
    $childList = $template.find(".item__children")
    for childView in @childViews
      childTemplate = childView.render()
      $childList.append childTemplate
    @$el.html $template

  toggleDisplay: (event) ->
    event.stopPropagation()
    @$el.find(".item__children").toggle()

  showFormView: ->
    formView = new App.views.ItemFormView(@item)
    @listenTo formView, 'item:save', =>
      console.log "save event"
      @render()
    @$el.find(".item__attributes").first().html(formView.render())
