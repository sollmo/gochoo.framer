# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "곧휴가철"
	author: "sollmo"
	twitter: ""
	description: "꿀연휴 예측하여, 휴가계획 미리미리 세워보자."


Framer.Device.background.backgroundColor = "333333"

# Import file "gochoo"
sketch = Framer.Importer.load("imported/gochoo@1x")

scroll = ScrollComponent.wrap(sketch.$02_cards)
scroll.scrollHorizontal = false
scroll.frame = Screen.frame
scroll.contentInset = top: 1230, left: 25

#sketch에서 숨겨놨던 navBar 작은 타이틀 켜고 다시 숨기기.
sketch.headline_small.visible = true
sketch.headline_small.opacity = 0

#sketch에서 숨겨놨던 bottom 핸들 일러스트 켜고 다시 숨기기
sketch.handle_illust.visible = true
sketch.handle_illust.opacity = 0

scroll.on Events.Move, ->
	sketch.blurred_bg.visible = true
	sketch.header_bg.originY = 0
	# 배경 블러주고 먹깔기
	sketch.Calendar.blur = Utils.modulate(scroll.scrollY, [100, 700], [0, 26], true)
	sketch.blurred_bg.opacity = Utils.modulate(scroll.scrollY, [300, 700], [0, 1], true)
	# bottom 손잡이
# 	sketch.card_00_arrow.opacity = Utils.modulate(scroll.scrollY, [100, 300], [1, 0], true)
	sketch.handle_arrow.opacity = Utils.modulate(scroll.scrollY, [100, 300], [1, 0], true)
	sketch.card_handle.scale = Utils.modulate(scroll.scrollY, [100, 400], [1, 0.8], true)
	sketch.handle_illust.opacity = Utils.modulate(scroll.scrollY, [100, 300], [0, 1], true) 
	# navBar 애니메이션
	sketch.header_divider.scaleX = Utils.modulate(scroll.scrollY, [100,300], [1, 1.2], true)
	sketch.header_divider.y = Utils.modulate(scroll.scrollY, [100,300], [216, 130], true)
	sketch.headline.opacity = Utils.modulate(scroll.scrollY, [100, 250], [1, 0], true)
	sketch.headline.y = Utils.modulate(scroll.scrollY, [100, 300], [79, 49], true)
	sketch.headline_small.opacity = Utils.modulate(scroll.scrollY, [100, 300], [0, 1], true)
	sketch.ic_settings.y = Utils.modulate(scroll.scrollY, [100,300], [141, 70], true)
	sketch.header_bg.scaleY = Utils.modulate(scroll.scrollY, [100,300], [1, 0.6], true)

	
# cal_reds 하위레이어들의 originX를 모두 좌측 끝으로 정의하고 scaleX를 0으로 전체가 보이지 않게 함.
stayReds = ->
	for reds, i in sketch.cal_reds.children
		reds.originX = 0
		reds.scaleX = 0
	# 	print reds.name + ", originX:" + reds.originX + ", scaleX:" + reds.scaleX

goReds = ->
	for reds, i in sketch.cal_reds.children
		animateRed = new Animation reds,
			scaleX: 1
			options:
				curve: "bezier-curve(0.25, 0.1, 0.25, 1)"
		animateRed.start()

stayReds()
setTimeout ->
	goReds()
, 2000


# po_dropdown에 state 추가
sketch.po_dropdown.states.add
	close:
		visible: true
		scaleY: 0
		originY: 0
		opacity: 0
		animationOptions:
			time: 0.15
			curve: "bezier-curve(0.7, 0.6, 0.2, 1)"	

	open:
		scaleY: 1
		opacity: 1
		animationOptions:
			time: 0.1
			curve: "spring(600, 0, 10)"		

# sketch에서 po_bg(po_dropdown 오픈 시, 클로즈 용도의 background 전체)가 눌려지지 않도록 visible을 false로 정의
sketch.po_bg.visible = false
# po_dropdown의 기본 state정의, switchInstant를 사용하면 animationOption을 무시한다.
sketch.po_dropdown.states.switchInstant("close")

# btn_day 선택 시, po_dropdown을 open으로 변경하고, 클로즈 가능하도록 po_bg의 visible 속성을 true 처리
sketch.btn_day.on Events.Tap, ->
	sketch.po_dropdown.states.switch("open")
	sketch.po_bg.visible = true

# po_dropdown이 열려있는 상태에서만 po_bg가 visible = true이기 때문에, po_dropdown 클로즈 용도로만 사용되는 이벤트
sketch.po_bg.on Events.Tap, ->
	sketch.po_dropdown.states.switch("close")
	sketch.po_bg.visible = false

sketch.po_dropdown.on Events.TapStart, ->
	sketch.po_dropdown_pressed.visible = true

sketch.po_dropdown.on Events.TapEnd, ->
	sketch.po_dropdown.states.switch("close")
	sketch.po_bg.visible = false
	sketch.po_dropdown_pressed.visible = false
	stayReds()
	goReds()
	








