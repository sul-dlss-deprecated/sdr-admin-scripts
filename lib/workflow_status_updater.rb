class WorkflowStatusUpdater

  require 'faraday'
  require 'yaml'

  attr_reader :druid
  attr_reader :workflow
  attr_reader :step
  attr_reader :status
  attr_reader :payload

  def initialize(args)
    @druid = args[:druid]
    @workflow = args[:workflow]
    @step = args[:step]
    @status = args[:status]
    @payload = "<process name='#{@step}' status='#{@status}'/>"
  end

  # for example:
  # updater = WorkflowStatusUpdater.update(druid: 'bm459md8742',
  #                                        workflow: 'accessionWF',
  #                                        step: 'descriptive-metadata',
  #                                        status: 'waiting')
  # updater.update

  def update
    path = "/workflow/dor/objects/druid:#{druid}/workflows/#{workflow}/#{step}"
    conn = Faraday.new(url: config['host'])
    conn.basic_auth(config['user'], config['password'])
    conn.headers['content-type'] = 'application/xml'

    conn.put path, payload
  end

  def config
    YAML::load_file(File.join(__dir__, '..', 'config', 'config.yml'))
  end
end
