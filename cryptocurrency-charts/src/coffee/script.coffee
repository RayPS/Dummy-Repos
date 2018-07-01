presets =
  "1 Hour": 
    "period": "1min"
    "size": "60"
    "description": "60 Minutes"

  "1 Day": 
    "period": "60min"
    "size": "24"
    "description": "24 Hours"

  "1 Week": 
    "period": "1day"
    "size": "7"
    "description": "7 Days"

  "1 Month": 
    "period": "1day"
    "size": "30"
    "description": "30 Days"


loadData = (preset = "1 Hour", callback) ->
  period = presets[preset].period
  size = presets[preset].size
  symbol = "eosusdt"
  baseURL = "https://api.huobi.pro/market/history/kline"
  parameters = "period=#{period}&size=#{size}&symbol=#{symbol}"
  api = baseURL + "?" + parameters
  
  $.getJSON api, (response) ->
    data = response.data

    labels = [0...data.length]

    data_label = []

    data_high = []
    data_low = []
    data_open = []
    data_close = []

    data_open_close_middle = []

    for item, index in data.reverse()
      data_label.push "#{index}"

      data_high.push item.high
      data_low.push item.low
      data_open.push item.open
      data_close.push item.close

      middle = (item.open + item.close) / 2
      data_open_close_middle.push middle
    
    datasets = [
        label: "High"
        data: data_high
        borderColor: "transparent"
      ,
        label: "Low"
        data: data_low
        backgroundColor: "rgba(0, 0, 255, 0.5)"
        borderColor: "transparent"
        fill: "-1"
      ,
        label: "(O + C) / 2"
        data: data_open_close_middle
        backgroundColor: "transparent"
        borderColor: "white"
    ]

    # Update Current Price:
    price = document.getElementById("price")
    before = parseFloat price.innerHTML.replace "$", ""
    current = data_close[data_close.length - 1]
    price.innerHTML = "$" + current

    if current > before
      price.style.color = "green"
    else if current < before
      price.style.color = "red"



    callback(datasets, labels)

options =
  # title:
  #   display: true
  #   text: "EOS/USDT 1 Hour"
  #   fontSize: 36
  #   fontColor: "white"
  legend:
    display: false
  elements:
    line:
      tension: 0
    point:
      radius: 0
  layout:
    padding:
      top: 30
      bottom: 0
      left: 0
      right: 0
  scales:
    yAxes: [
      type: 'linear'
      position: 'right'
      gridLines:
        color: "rgba(255, 255, 255, 0.2)"
    ]
    xAxes: [
      # display: false
      gridLines:
        color: "rgba(255, 255, 255, 0.2)"
      ticks:
        display: false
    ]
  animation:
    duration: 0
  hover:
    animationDuration: 0
  responsiveAnimationDuration: 0
  plugins:
    filler:
      propagate: true


window.onload = ->
  ctx = document.getElementById("myChart").getContext('2d')

  myChart = new Chart(ctx,
    type: "line"
    data:
      labels: []
      datasets: []
    options: options
  )



  setInterval( ->
    loadData $(".button.active").html(), (datasets, labels) ->
      myChart.data.labels = labels
      myChart.data.datasets = datasets
      myChart.update()
  , 1000)




  $(".button").click ->
    $(".button").removeClass("active")
    $(this).addClass("active")
    $("#title").html "EOS/USDT (#{presets[this.innerHTML].description})"
