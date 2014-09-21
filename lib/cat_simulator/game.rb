module CatSimulator
  class Game < Chingu::Window
    def initialize
      super
      push_game_state(GameStates::Play)
    end
  end
end
