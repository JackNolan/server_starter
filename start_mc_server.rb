require 'AWS'
class AmazonWrapper
  def initialize
    @ec2 = AWS::EC2::Base.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                              :secret_access_key =>  ENV['AWS_SECRET_ACCESS_KEY'])
  end
  def current_ip
    request_status.reservationSet.item.first.instancesSet.item.first.ipAddress
  end
  def assign_ip
    @ec2.associate_address(instance_id: "i-ce4b28b0",public_ip:"23.21.180.84")
  end
  def start_mc
    @ec2.start_instances(instance_id: "i-ce4b28b0")
  end
  def stop_mc
    @ec2.stop_instances(instance_id: "i-ce4b28b0")
  end
  def request_status
    @ec2.describe_instances(instance_id: "i-ce4b28b0")
  end
  def get_status
    status = request_status.reservationSet.item.first.instancesSet.item.first.instanceState
    case status.code
      when "80"
        "offline"
      when "16"
        "online"
      when "64"
        "stopping"
      when "0"
        "starting up"
      else
        status.name + " " +status.code
    end
  end
  def status
    @status ||= get_status
  end
end