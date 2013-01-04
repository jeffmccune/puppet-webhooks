require 'puppet_labs/pull_request_job'

##
# Delayed Job to perform work when a pull request is closed.
class PuppetLabs::PullRequestClosedJob < PuppetLabs::PullRequestJob

end
