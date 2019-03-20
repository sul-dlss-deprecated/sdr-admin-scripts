require 'spec_helper'
require 'workflow_creator.rb'

describe 'WorkflowCreator' do
  before(:all) do
    @workflow_creator = WorkflowCreator.new(druid: 'druid:bm459md8742')
  end

  it 'can instantiate with appropriate arguments' do
    expect(@workflow_creator).to be_kind_of(WorkflowCreator)
  end

  it 'can return the druid it was instantiated with' do
    expect(@workflow_creator.druid).to eq('druid:bm459md8742')
  end

  describe '.object_identifier' do
    it 'returns the object_identifier from the Dor::Services::Client::Object' do
      expect(@workflow_creator.object_identifier).to eq('druid:bm459md8742')
    end
  end

  describe '.create_workflow' do
    it 'throws an exception for an unknown workflow' do
      stub_request(:any, /dor-services/).to_raise(Dor::Services::Client::UnexpectedResponse)
      expect{ @workflow_creator.create_workflow('foo')}.to raise_error(Dor::Services::Client::UnexpectedResponse)
    end

    it 'returns nil for a known workflow' do
      stub_request(:any, /dor-services/)
      expect(@workflow_creator.create_workflow('etdSubmitWF')).to be_nil
    end
  end
end
