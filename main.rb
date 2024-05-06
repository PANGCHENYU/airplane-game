require 'dxruby'
require_relative 'newgame'

# ウィンドウサイズの設定
Window.width = 400
Window.height = 600

class Player < Sprite
  attr_accessor :image
  attr_accessor :status
  attr_accessor :score
  attr_accessor :hits
  
  def initialize(x, y)
    @image = Image.load("player.png")
    @x = x
    @y = y
    @score = 0
    @status = 'player'
    super(x, y)
    self.collision = [0, 0, 48, 48]
    @jumping = false
    @jump_count = 0
    @hits = []
    @counter = 0
    @f = 0
  end
  
  def update
    # プレイヤーの移動ロジック
    if Input.key_down?(K_LEFT)
      @x -= 5
      self.image = Image.load("player2.png")  # 左キーを押すと、キャラクタの画像を「player 2.png」に設定します
    elsif Input.key_release?(K_LEFT)
      self.image = Image.load("player.png")   # 左キーを放すと、キャラクタの画像を「player.png」に戻します
    end

    if Input.key_down?(K_RIGHT)
      @x += 5
      self.image = Image.load("player1.png")  # 右キーを押すと、キャラクタの画像が「player 1.png」に設定されます
    elsif Input.key_release?(K_RIGHT)
      self.image = Image.load("player.png")   # 右キーを放すと、キャラクタの画像が「player.png」に設定されます
    end
    
    if Input.key_down?(K_UP)
      @y -= 5
    elsif Input.key_down?(K_DOWN)
      @y += 5
    end
 
    if Input.key_down?(K_SPACE)              #spaceキーを押すと、プレイヤーは素早く上に移動します
      @y -= 10
    elsif Input.key_down?(K_LSHIFT)          #Lshiftキーを押すと、プレイヤーは素早く下に移動します
      @y += 10
    end
    
    if Input.key_down?(K_LCONTROL)
      self.image = Image.load("player4.png")  # 左crtlを押すと、キャラクタの画像が「player 4.png」に設定されます
      self.collision = [0, 0, 16, 16]
    elsif Input.key_release?(K_LCONTROL)
      self.image = Image.load("player.png")   # 左crtlを放すと、キャラクタのピクチャが「player.png」に設定されます
      self.collision = [0, 0, 48, 48]
    end

    # if Input.key_push?(K_SPACE) && !@jumping
    #   @jumping = true
    #   @jump_count = 0
    # end

    # if @jumping
    #   if @jump_count < 10 # 上升
    #     @y -= 8
    #   elsif @jump_count < 20 # 下降
    #     @y += 8
    #   else # 跳跃结束
    #     @jumping = false
    #   end
      
    #   @jump_count += 1
    # end

    @f += 1 

    self.x = @x
    self.y = @y
  end

  def draw
    Window.draw(@x, @y, @image)
    @hits.each do |hit|
     if
      hit.update
      hit.draw
     else 
      hit.vanish  
     end 
      
    end
  end

  def collides_with_block?(block)
    player_sprite = self.sprite
    block_sprite = block.sprite
    player_sprite.collides_with?(block_sprite)
  end
  
  def shot(enemy)
    @hits << Cartridge3Hit.new(self.x, self.y)    if enemy.hitted == false
  end
end

# 背景画像オブジェクトの作成
background = Image.load('maps.png')
begin_ = Image.load('begin.png')
setsumei = Setsumei.new

# maps

# mapimage = []
# mapimage.push(Image.new(32, 32, [100, 100, 200])) # 
# mapimage.push(Image.new(32, 32, [50, 200, 50]))   # 
# mapimage.push(
#   Image.new(32, 32, [50, 200, 50])
#   .box_fill(13, 0, 18, 28, [200, 50, 50])
# )                                                 # 
# mapimage.push(
#   Image.new(32, 32, [50, 200, 50])
#   .triangle_fill(15, 0, 0, 31, 31, 31, [200, 100,100])
# )                                                 # 
# mapimage.push(
#   Image.new(32, 32, [50, 200, 50])
#   .box_fill(13, 16, 18, 31, [200, 50, 50])
#   .circle_fill(16, 10, 8, [0, 255, 0])
# )                                                 # 

# map date 創造
# mapdata = [
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#   [1,1,1,1,1,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4],
#   [1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2],
#   [1,1,1,1,1,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4],
# ]

# 创建地图精灵数组
# mapsprite = []
# mapdata.each_with_index do |row, y|
#   row.each_with_index do |cell, x|
#     mapsprite.push(Sprite.new(x * 32, y * 32, mapimage[cell]))
#   end
# end

player = Player.new(320, 400)


# 弾と敵を作成して配列に格納する
blocks = []
30.times do
  blocks << Cartridge1.new(rand(0..600), rand(50..200))
end
30.times do
  blocks << Cartridge2.new(rand(0..600), rand(50..200))
end
30.times do
  blocks << Cartridge3.new(rand(0..600), rand(50..200))
end
20.times do
  blocks << Enemy1.new(rand(0..600), rand(0..100))
end
20.times do
  blocks << Enemy2.new(rand(0..600), rand(0..100))
end
20.times do
  blocks << Enemy3.new(rand(0..600), rand(0..100))
end
#  blocks = [scissors, rock, cloth]

#success
# class Success < sprite
#  def initialize(x, y)
#   @image.load('success.png')
#   x=300
#   y=300
#  end


Window.loop do
 Window.draw(0,0,begin_)
 setsumei.draw
 setsumei.click
 # マウスの左ボタンをクリックするかどうかをマーク
 mouse_clicked = false
 if Input.mouse_push?(M_LBUTTON)
  mouse_clicked = true
 end
 if mouse_clicked
  # レンダリングサイクル
  Window.loop do
    # 終了サイクル条件
    break if Input.key_push?(K_ESCAPE)
    
    # プレイヤーとマップを更新する
    player.update
    # Sprite.draw(mapsprite)
   
   #  背景を描画
   Window.draw(0, 0, background)
 
    # プレイヤーを描画する
    player.draw 
 
    # ブロックを描き、プレイヤーが触っているかどうかを確認
    Sprite.draw(blocks)
    Sprite.draw(player.hits)
    #  blocks.each do |block|
    #     block.draw
 


    #スコアの描画
    font = Font.new(32)
    Window.draw_font(10, 560, "エネルギー: #{player.score}", font ,color: [255, 255, 255])
    # if player.score >= 100
    #    window.draw(300,300,Success)
    # end 
 
    #勝ち
    if player.score > 4
      success_image = Image.load("succeed.png")
      Window.loop do
      Window.draw(0, 0, success_image)
      end
    end
 
   #     block.hit(player)
   #  end
    Sprite.check(player, blocks)
  end
 end
end