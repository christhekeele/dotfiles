Pry.config.command_prefix = ""
Pry.config.memory_size = 300

Pry::Commands.block_command('enable-pry', 'Enable `binding.pry` feature') do
  ENV['DISABLE_PRY'] = nil
end

prompt = ->(obj, next_level, pry){
  "\e[1;36mʃ ".tap do |prompt|
    if obj.to_s == 'main'
      prompt << "\e[0;36m#{pry.config.prompt_name} " if pry.respond_to?(:config) and !pry.config.prompt_name.to_s.empty? and !pry.config.prompt_name == 'pry'
    else
      prompt << "\e[1;35m#{obj} "
    end
    prompt << "\e[0m"
  end
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
