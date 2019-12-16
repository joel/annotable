begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yardstick'
require 'yaml'

desc('Documentation stats and measurements')
task('qa:docs') do
  yaml = YAML.load_file(File.expand_path('.yardstick.yml', __dir__))
  config = Yardstick::Config.coerce(yaml)
  measure = Yardstick.measure(config)
  measure.puts
  coverage = Yardstick.round_percentage(measure.coverage * 100)
  exit(1) if coverage < config.threshold
end

desc('Codestyle check and linter')
RuboCop::RakeTask.new('qa:code') do |task|
  task.fail_on_error = true
  task.patterns = [
    'lib/annotable/**/*.rb',
    'app/**/*.rb',
    'spec/*.rb',
    'spec/support/*.rb',
    'spec/**/*_spec.rb'
  ]
end

desc('Run CI QA tasks')
task(qa: ['qa:docs', 'qa:code'])

RSpec::Core::RakeTask.new(spec: :qa) do |t|
  t.rspec_opts = "-I #{File.expand_path('spec', __dir__)}"
  t.pattern =  File.expand_path('spec/**/*_spec.rb', __dir__)
end

task(default: :spec)

APP_RAKEFILE = File.expand_path('spec/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'
