require 'spec_helper'
require 'ostruct'
require 'puppet_labs/pull_request_controller'
require 'puppet_labs/pull_request_app'

describe PuppetLabs::PullRequestController do
  subject do
    opts = {
      :logger => logger,
      :pull_request => pull_request,
    }
    described_class.new(opts)
  end

  let(:log_collector) { StringIO.new }
  let(:logger) { Logger.new(log_collector) }

  before :each do
    PuppetLabs::PullRequestJob.any_instance.stub(:queue).and_return(OpenStruct.new)
  end

  context 'when a pull request is merged and closed' do
    before :all do
      @payload = read_fixture("example_pull_request_closed_and_merged.json")
    end

    let :pull_request do
      PuppetLabs::PullRequest.new(:json => @payload)
    end

    it "returns 202 ACCEPTED" do
      status = subject.run
      status.first.should == 202
    end

    it "queues the job" do
      PuppetLabs::PullRequestJob.any_instance.
        should_receive(:queue).and_return(OpenStruct.new)
      status = subject.run
    end
    it "body has a job_id key" do
      status = subject.run
      status[2].should have_key 'job_id'
    end
    it "body has a queue key" do
      status = subject.run
      status[2].should have_key 'queue'
    end
    it "body has a priority key" do
      status = subject.run
      status[2].should have_key 'priority'
    end
    it "body has a created_at key" do
      status = subject.run
      status[2].should have_key 'created_at'
    end
    it "returns no headers" do
      status = subject.run
      status[1].should be_empty
    end
  end
end
