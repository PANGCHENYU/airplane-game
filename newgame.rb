require 'dxruby'


#　BGMを読み込む
bgm = Sound.new("bgm.wav")

# BGMを再生
bgm.play

# 分数オブジェクト
class Score < Sprite
  attr_reader :value
  
  def initialize
    @value = 0
    @font = Font.new(32)
  end
  
  def update(player, blocks)
    blocks.each do |block|
      if player === block
        score = block.hit(player)
        if score == 1
          @value += 1
        else
          @value -= 1
        end
        block.vanish # 衝突後に弾が消える
      end
    end
  end
end
# def initialize
# TODO score = 10
# end

# 3つの弾を定義
class Cartridge1 < Sprite
  attr_accessor :hitted

  def initialize(x, y)
    @x = x
    @y = y
    self.collision = [0, 0, 32, 32]
    super(x, y)
    @image = Image.load('cartridge1.png')
    @hit_sound1 = Sound.new('cartridge1.wav')
  end
  
  def draw
    @y += 1
    if @y > Window.height
      # 画面の上部にブロックを戻す
      @y = 0
      # ブロックの水平位置をランダムに再設定する
      @x = rand(0..400)
    end
    self.x = @x 
    self.y = @y
    Window.draw(@x, @y, @image)
  end

  def hit(player)
     # プレイヤーが弾丸で撃たれた場合、ポイント-2
    if player.status == 'player'
      player.score -= 2
      @hit_sound1.play
    end    
    
     @x = rand(0..400)
     @y = 100
     self.x = @x
     self.y = @y
  end

  

end

class Cartridge2 < Sprite  
  attr_accessor :hitted

  def initialize(x, y)
    @x = x
    @y = y
    super(x, y)
    self.collision = [0, 0, 32, 32]
    @image = Image.load('cartridge2.png')
    @hit_sound2 = Sound.new('cartridge2.wav')
  end
  
  def draw
    @y += 1
    if @y > Window.height
      # 画面の上部にブロックを戻す
      @y = 0
      # ブロックの水平位置をランダムに再設定する
      @x = rand(0..400)
    end
    self.x = @x 
    self.y = @y
    Window.draw(@x, @y, @image)
  end
  
  def hit(player)
    # プレイヤーが弾丸で撃たれた場合、ポイント-1
     if player.status == 'player'
      player.score -= 1
      @hit_sound2.play
     end
    
     @x = rand(0..400)
     @y = 100
     self.x = @x
     self.y = @y
  end
end

class Cartridge3 < Sprite
  attr_accessor :hitted
  attr_accessor :image

  def initialize(x, y)
    @x = x
    @y = y
    super(x, y)
    self.collision = [0, 0, 32, 32]
    @image = Image.load('cartridge3.png')
    @hit_sound3 = Sound.new('cartridge3.wav')
    @hit_image = Image.load('hit3.png')
    @hitted = false
  end
  
  def draw
    @y += 1
    if @y > Window.height
      # 画面の上部にブロックを戻す
      @y = 0
      # ブロックの水平位置をランダムに再設定する
      @x = rand(0..400)
    end
    self.x = @x 
    self.y = @y
    Window.draw(@x, @y, @image)
  end
  
  def hit(player)
   # プレイヤーがヒットするとポイントが加算されます
  if player.status == 'player'
    player.score += 1
    @hitted = true
    @hit_sound3.play # 効果音
    # 「hit 3.png」ピクチャを表示するための瞬時オブジェクトを作成する
#    hit_sprite = Sprite.new(player.x, player.y, @hit_image)
#    hit_sprite.z = 999 # このオブジェクトが他のオブジェクトの上にあることを確認します
    # 1秒間待ち、瞬時オブジェクトを削除
#    Thread.new do
#      sleep(1)
#      hit_sprite.vanish
#    end
  end
   
   @x = rand(0..400)
   @y = 100
     self.x = @x
     self.y = @y
 end
end


class Cartridge3Hit < Sprite
  attr_accessor :image
  def initialize(x, y)
    @x = x + 16
    @y = y + 16
    super(x, y)
    @image = Image.load('hit3.png')
    @sound = Sound.new('cartridge3.wav')
    @f = 0
  end

  def draw

    if @y > Window.height
      self.vanish
    end
    self.x = @x 
    self.y = @y 
    Window.draw(@x, @y, @image)
    
  end

  def update
    @f += 1
   if @f > 15
    return false
   else
    return true
   end
  end

end

class Enemy1 < Sprite
    def initialize(x, y)
        @x = x
        @y = y
        @dx = 1
        super(x, y)
        self.collision = [0, 0, 64, 64]
        @image = Image.load('enemy1.png')
      end

      def draw
        if @x < 0 || @x > Window.width
          @dx *= -1
        end
        @x += @dx
#        if @x > Window.width
#          # 画面の上部にブロックを戻す
#          @x -= 1
#          self.x = @x
#        end
        self.x = @x
        Window.draw(@x, @y, @image)
      end
    end

    class Enemy2 < Sprite
      def initialize(x, y)
          @x = x
          @y = y
          @dx = 1
          super(x, y)
          self.collision = [0, 0, 64, 64]
          @image = Image.load('enemy2.png')
        end
  
        def draw
          if @x < 0 || @x > Window.width
            @dx *= -1
          end
          @x -= @dx
  #        if @x > Window.width
  #          # 画面の上部にブロックを戻す
  #          @x -= 1
  #          self.x = @x
  #        end
          self.x = @x
          Window.draw(@x, @y, @image)
        end
      end

      class Enemy3 < Sprite
        def initialize(x, y)
            @x = x
            @y = y
            @dx = 1
            super(x, y)
            self.collision = [0, 0, 64, 64]
            @image = Image.load('enemy3.png')
          end
    
          def draw
            if @x < 0 || @x > Window.width
              @dx *= -1
            end
            @x += @dx
    #        if @x > Window.width
    #          # 画面の上部にブロックを戻す
    #          @x -= 1
    #          self.x = @x
    #        end
            self.x = @x
            Window.draw(@x, @y, @image)
          end
        end

        class Success < Sprite
          def initialize(x,y)
            @x = x
            @y = y
            super(x,y)
            @image = Image.lode('succeed.png')
            @status = 'success'
          end
        end

        class Setsumei
          def initialize
            @image = Image.load('setsumei.png')
            @x = 6
            @y = 6
          end
        
          def draw
            Window.draw(@x, @y, @image)
          end
        
          def click
            if Input.mouse_push?(M_RBUTTON)
              @image = Image.load('setsu.png')
            end
          end
        end