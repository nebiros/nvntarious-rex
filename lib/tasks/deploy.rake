def eb_deploy(eb_env_name = "production-env")
  git_path = `which git`.strip.freeze
  git_version = `#{git_path} rev-parse --short HEAD`.strip.freeze
  timestamp = Time.now.utc.to_i
  eb_label = "#{git_version}-#{timestamp}".strip.freeze

  sh "eb use #{eb_env_name}"
  sh "eb deploy #{eb_env_name} --profile evelyn --label #{eb_label} -v"
  sh "git tag -a -m \"Bumps builds/#{eb_env_name}/#{eb_label}\" \"builds/#{eb_env_name}/#{eb_label}\""
  sh "git push --tags"
end

namespace "deploy" do
  desc "Build application and deploy to EB production environment"
  task "production" do
    eb_deploy("production-env")
  end
end