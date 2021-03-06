module GameUI
  class Window < Gosu::Window
    Mouse = Struct.new(:x, :y)

    attr_accessor :active_container
    attr_reader :elements, :mouse

    def self.instance=(this)
      @instance = this
    end

    def self.instance
      @instance
    end

    def initialize
      Window.instance = self
      super(800, 600, false)
      $window = self
      self.caption = "GameUI"

      @elements = []
      @mouse = Mouse.new(0, 0)
      @active_container = nil
      setup
    end

    def setup
    end

    def draw
      @elements.each(&:draw)
      if @active_container.is_a?(GameUI::Container)
        @active_container.draw
      end
    end

    def update
      @mouse.x, @mouse.y = self.mouse_x, self.mouse_y

      @elements.each(&:update)
      if @active_container.is_a?(GameUI::Container)
        @active_container.update
      end
    end

    def button_up(id)
      @elements.each {|e| if defined?(e.button_up); e.button_up(id); end}
      if @active_container.is_a?(GameUI::Container)
        @active_container.button_up(id)
      end
    end

    def needs_cursor?
      true
    end

    def fill_rect(x, y, width, height, color = Gosu::Color::WHITE, z = 0, mode = :default)
      return  draw_quad(x, y, color,
                        x, height+y, color,
                        width+x, height+y, color,
                        width+x, y, color,
                        z, mode)
    end
  end
end
