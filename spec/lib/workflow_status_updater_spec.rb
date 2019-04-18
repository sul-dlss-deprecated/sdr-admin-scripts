require 'spec_helper'
require 'workflow_status_updater.rb'

describe 'WorkflowStatusUpdater' do

  before(:all) do
    @workflow_status_updater = WorkflowStatusUpdater.new(druid: 'bm459md8742',
                                                         workflow: 'accessionWF',
                                                         step: 'descriptive-metadata',
                                                         status: 'waiting',
                                                         repo: 'dor')
  end

  it 'can instantiate with appropriate arguments' do
    expect(@workflow_status_updater).to be_kind_of(WorkflowStatusUpdater)
  end

  it 'can return its druid' do
    expect(@workflow_status_updater.druid).to eql('bm459md8742')
  end

  it 'can return its workflow' do
    expect(@workflow_status_updater.workflow).to eql('accessionWF')
  end

  it 'can return its step' do
    expect(@workflow_status_updater.step).to eql('descriptive-metadata')
  end

  it 'can return desired status' do
    expect(@workflow_status_updater.status).to eql('waiting')
  end

  it 'can return its repository' do
    expect(@workflow_status_updater.repo).to eql('dor')
  end

  it 'can return its XML payload' do
    expect(@workflow_status_updater.payload).to eql("<process name='descriptive-metadata' status='waiting'/>")
  end

  describe '.update' do
    it 'returns a 200 on a successful update' do
      url = "#{@workflow_status_updater.config['host']}/workflow/#{@workflow_status_updater.repo}/objects/druid:#{@workflow_status_updater.druid}/workflows/#{@workflow_status_updater.workflow}/"
      stub_request(:put, "https://lyberservices-test.stanford.edu/workflow/dor/objects/druid:bm459md8742/workflows/accessionWF/descriptive-metadata")
        .with(
          body: @workflow_status_updater.payload,
          headers: {
            'Authorization'=>'Basic ZG9yX3NlcnZpY2VfdHN0OnB3NG1lbmU=',
            'Content-Type'=>'application/xml'
          }
      ).to_return(status: 200, body: "", headers: {})
      response = @workflow_status_updater.update

      expect(response.status).to eql(200)
    end
  end

  describe '.config' do
    it 'returns configuration from a YAML file' do
      config = @workflow_status_updater.config
      expect(config).to be_kind_of(Hash)
      expect(config).to have_key('host')
      expect(config).to have_key('user')
      expect(config).to have_key('password')
    end
  end
end
