class WorkflowCreator
  require 'dor/services/client'
  require 'yaml'

  attr_reader :druid

  def initialize(args)
    @druid = args[:druid]
  end

  def object_identifier
    object_client.object_identifier
  end

  def create_workflow(wf_name)
    object_client.workflow.create(wf_name: wf_name)
  end

  private

  def object_client
    dor_services_client.object(druid)
  end

  def dor_services_client
    @dor_services_client ||= Dor::Services::Client.configure(url: config['dor_services_url'])
  end

  def config
    YAML::load_file(File.join(__dir__, '..', 'config', 'config.yml'))
  end
end
