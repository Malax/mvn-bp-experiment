require "tmpdir"
require "open3"
require "securerandom"
require "docker"

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

  def start_container()
    container=Docker::Container.create("Image" => @image.id)
    container.start

    begin
      yield ContainerInterface.new(container)
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
  def initialize(container)
    @container=container
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
    # image_name="cnb_test_" + SecureRandom.hex(10)
    image_name="cnb_test_fffffffffa"
  end

  buildpack_list=buildpacks
      .map { |buildpack| buildpack == :this ? "." : buildpack }
      .join(",")


  env_string = env.keys.map{ |key| "--env #{key}=#{env[key]}" }.join(" ")

  cmd = "pack build #{image_name} --path #{app_dir} #{env_string} -b #{buildpack_list}"

  image = nil
  stdout, stderr, status = Open3.capture3(cmd)

  if status != 0 and exception_on_failure
    raise "Pack exited with status code #{status}, indicating an error and failed build!"
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
