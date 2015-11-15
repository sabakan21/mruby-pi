class Pi
  class Pin
    attr:pin_num
    def initialize(num, mode ="in")
      @pin_num = num
      File.open("/sys/class/gpio/export","w"){|f|
        f.write("#{@pin_num}")
      }

      File.open("/sys/class/gpio/gpio#{@pin_num}/direction","w"){|f|
        f.write(mode)
      } 
      self
    end

    def read
      File.open("/sys/class/gpio/gpio#{@pin_num}/value","r"){|f|
        f.read
      } 
    end

    def write(str)
      File.open("/sys/class/gpio/gpio#{@pin_num}/value","w"){|f|
        f.write(str)
      } 
    end

    def toggle
      File.open("/sys/class/gpio/gpio#{@pin_num}/value","w+"){|f|
        val = f.read.to_i
        f.write("#{1 - val}")
      } 
    end

    def up
      File.open("/sys/class/gpio/gpio#{@pin_num}/direction","w"){|f|
        f.write("high")
      }
    end

    def close
      File.open("/sys/class/gpio/unexport","w"){|f|
        f.write("#{@pin_num}")
      }
    end
  end

end
