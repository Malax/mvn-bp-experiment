require "tmpdir"
require "open3"
require "securerandom"
require "docker"
require "random-port"

SPEED_IT_UP=true

def with_temporary_app_from_fixture(name)
  Dir.mktmpdir do |temporary_fixture_dir|
    FileUtils.copy_entry "test/fixtures/#{name}", temporary_fixture_dir
    yield temporary_fixture_dir
  end
end

class PackBuildResult
  attr_reader :stdout, :stderr, :status, :image, :image_name

  def initialize(stdout, stderr, status, image, image_name)
    @stdout=stdout
    @stderr=stderr
    @status=status
    @image=image
    @image_name=image_name
    freeze
  end

  def build_success?()
    @status == 0
  end

  def start_container(expose_ports: [])
    expose_ports = [expose_ports] unless expose_ports.kind_of?(Array)

    config = {
        "Image" => @image.id,
        "ExposedPorts" => {
        },
        "HostConfig" => {
          "PortBindings" => {
          }
        }
    }

    pool = RandomPort::Pool.new

    port_mappings = expose_ports.map { |container_port| [container_port, pool.acquire] }

    port_mappings.each do |port_mapping|
      config["ExposedPorts"]["#{port_mapping[0]}/tcp"] = {}
      config["HostConfig"]["PortBindings"]["#{port_mapping[0]}/tcp"] = [{ "HostPort" => "#{port_mapping[1]}"}]
    end

    container=Docker::Container.create(config)
    container.start

    begin
      yield ContainerInterface.new(container, Hash[port_mappings])
    ensure
      container.delete(:force => true)
    end
  end
end


class ExecResult
  attr_reader :stdout, :stderr, :status

  def initialize(stdout, stderr, status)
    @stdout=stdout
    @stderr=stderr
    @status=status
    freeze
  end
end

class ContainerInterface

  def initialize(container, port_mappings)
    @container=container
    @port_mappings=port_mappings
  end

  def get_host_port_for(port)
    @port_mappings[port]
  end

  def is_file(path)
    exec_bash("[[ -f '#{path}' ]]").status == 0
  end

  def file_contents(path)
    exec_bash("cat '#{path}'").stdout
  end

  def exec_bash(cmd)
    result = @container.exec(["bash", "-c", cmd])
    ExecResult.new(result[0][0], result[1], result[2])
  end
end




def pack_build(app_dir, image_name: nil, buildpacks: [:this], env: {}, exception_on_failure: true)
  if image_name == nil
    image_name="cnb_test_fffffffffa" if SPEED_IT_UP
    image_name="cnb_test_" + SecureRandom.hex(10) unless SPEED_IT_UP
  end

  buildpack_list=buildpacks
      .map { |buildpack| buildpack == :this ? "." : buildpack }
      .join(",")


  env_string = env.keys.map{ |key| "--env #{key}=#{env[key]}" }.join(" ")

  cmd = "pack build #{image_name} --path #{app_dir} #{env_string} -b #{buildpack_list}"

  image = nil
  stdout, stderr, status = Open3.capture3(cmd)

  if status != 0 and exception_on_failure
    raise "Pack exited with status code #{status}, indicating an error and failed build!\nstderr: #{stderr}\nstdout: #{stdout}"
  end

  if status == 0
    image = Docker::Image.get(image_name)
  end

  begin
    yield PackBuildResult.new(stdout, stderr, status, image, image_name)
  ensure
    # image.remove(:force => true) unless image == nil
  end
end
