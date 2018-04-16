GIT_VERSION = `git rev-parse --short HEAD`.strip.freeze
TIMESTAMP = Time.now.utc.to_i
EB_LABEL = "#{GIT_VERSION}-#{TIMESTAMP}".strip.freeze

def eb_deploy(eb_env_name = "production-env")
  sh "eb use #{eb_env_name}"
  sh "eb deploy #{eb_env_name} --profile evelyn --label #{EB_LABEL} -v"
  sh "git tag -a -m \"Bumps builds/#{eb_env_name}/#{EB_LABEL}\" \"builds/#{eb_env_name}/#{EB_LABEL}\""
  sh "git push --tags"
end

namespace "deploy" do
  desc "Build application and deploy to EB production environment"
  task "production" do
    eb_deploy("production-env")
  end
end