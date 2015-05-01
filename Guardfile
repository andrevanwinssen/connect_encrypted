require 'byebug'

guard :rspec, cmd: "rspec" do
  watch(%r{^spec/(.+)/.+_spec\.rb$})
  watch(%r{^lib\/(.*)\/(.+)\.rb$})     { |m| "spec/unit/#{m[1]}/#{m[2]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end


guard :bundler do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end