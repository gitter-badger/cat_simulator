module CatSimulator
  module GameStates
    class Play < Chingu::GameState
      def setup
        self.input = {
          escape: :exit
        }
        # @platform = Platform.create(x: 100, y: 600)
        load_game_objects(file: 'levels/playground.yml')
        @x = 100
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
end
