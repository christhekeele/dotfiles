Pry.config.command_prefix = ""
Pry.config.memory_size = 10000

Pry::Commands.block_command('enable-pry', 'Enable `binding.pry` feature') do
  ENV['DISABLE_PRY'] = nil
end

prompt = ->(obj, next_level, pry){
  pr = "\e[1;36mʃ "
  if Pry.view_clip(obj) == 'main'
    pr << "\e[0;36m#{pry.config.prompt_name} " if pry.respond_to?(:config) and !pry.config.prompt_name.to_s.empty? and !pry.config.prompt_name == 'pry'
  else
    pr << "\e[1;35m#{Pry.view_clip(obj)} "
  end
  pr << "\e[1;33m#{pry.input_array.map(&:to_s).map(&:lines).flatten.count + 1} "
  pr << "\e[0m"
}

Pry.config.prompt = [
  ->(*args){
    prompt.call(*args) << "\e[1;32m❯❯❯ \e[0m"
  },
  ->(*args){
    prompt.call(*args) << "\e[1;32m.\e[0;33m.\e[1;31m. \e[0m"
  }
]

def monitor(every: 1, initial: nil)
  $monitor = Thread.new do
    previous = initial
    loop do
      yield; Thread.stop
    end
  end.tap do
    $monitor_runner = Thread.new do
      loop do
        sleep every
        break unless $monitor.alive?
        $monitor.run
      end
    end
  end
end
