guard :rspec, cmd: "bundle exec rspec" do
  watch('spec/spec_helper.rb') { "spec" }
  watch('config/routes.rb') { "spec/requests" }
  watch('app/controllers/application_controller.rb') { "spec/requests" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/v1/(.+)_(controller)\.rb$}) { |m| "spec/requests/#{m[1]}_request_spec.rb" }
  watch(%r{^app/serializers/v1/(.+)_(serializer)\.rb$}) { |m| "spec/requests/#{m[1]}s_request_spec.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end
