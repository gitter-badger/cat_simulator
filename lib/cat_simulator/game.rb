module CatSimulator
  class Game < Chingu::Window
    def initialize
      super
      self.input = {escape: :exit}
      @platform = Platform.create
      @player = Cat.create(x: 100, y: 400)
    end

    def update
      super
      Cat.each_collision(Platform) do |player, platform|
        player.encounter_platform(platform)
      end
    end
  end
end
