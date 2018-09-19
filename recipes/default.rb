#
# Cookbook:: Artifactory
# Recipe:: default.rb
#

# default variables
artifactory_version = node['artifactory']['version']
artifactory_package_name = node['artifactory']['package']['name']

# downloading  and installing Artifactory
# ***************************************************************************

# installing Artifactory offical repo
# not recommended in a production environment
if node['artifactory']['install']['repo']
  if node['platform'] == 'centos' || node['platform'] == 'rhel7'

    rhel7_repo_url = node['rhel7']['artifactory']['download']['repo']['url']['internet']
    rhel7_artifactory_repo_name = node['rhel7']['artifactory']['repo']['name']
    yum_repo_location = node['rhel7']['yum']['repo']['location']

    # adding Artifactory repo to yum
    remote_file "#{yum_repo_location}/#{rhel7_artifactory_repo_name}" do
      source rhel7_repo_url.to_s
      owner 'root'
      group 'root'
      mode '0755'
      action :create
      not_if { ::File.exist?("#{yum_repo_location}/#{rhel7_artifactory_repo_name}") }
    end

    # installing Artifactory
    yum_package 'artifactory' do
      package_name artifactory_package_name.to_s
      version artifactory_version.to_s
      not_if 'rpm -qa | grep artifactory'
    end

  elsif node['platform'] == 'ubuntu'

    distribution = `lsb_release -c | cut -f2 | tr '\n' ' '`
    component = 'main'
    ubuntu_repo_url = node['ubuntu']['artifactory']['download']['repo']['url']['internet']
    ubuntu_repo_source_list = node['ubuntu']['repo']['source']['list']

    # Adding Artifactory repo to ubuntu sources list
    execute 'add_repo' do
      command "echo 'deb #{ubuntu_repo_url} #{distribution} #{component}' | tee -a /etc/apt/sources.list && apt-get update"
      not_if "cat #{ubuntu_repo_source_list} | grep #{ubuntu_repo_url}"
    end

    # Installing Artifactory
    apt_package 'artifactory' do
      package_name artifactory_package_name.to_s
      version artifactory_version.to_s
      options '--allow-unauthenticated'
      not_if 'dpkg -l | grep artifactory'
    end
  end

# if installing artifactory from installation package (rpm/deb)
# recommended for a production environment
elsif node['artifactory']['install']['package']
  if node['platform'] == 'centos'

    rpm_package = node['rhel7']['artifactory']['rpm']['package']
    rpm_download_url = node['rhel7']['artifactory']['download']['url']['internal']
    # download rpm package
    remote_file "/tmp/#{rpm_package}" do
      source rpm_download_url.to_s
      owner 'root'
      group 'root'
      mode '0755'
      action :create
      not_if { ::File.exist?("/tmp/#{rpm_package}") }
    end

    # installing installing Artifactory
    execute 'install_rpm' do
      command "yum install -y /tmp/#{rpm_package}"
      not_if 'rpm -qa | grep artifactory'
    end

  elsif node['platform'] == 'ubuntu'

    ubuntu_package = node['ubuntu']['artifactory']['package']
    ubuntu_package_download_url = node['ubuntu']['artifactory']['download']['url']['internal']
    # downloading ubuntu package
    remote_file "/tmp/#{ubuntu_package}" do
      source ubuntu_package_download_url.to_s
      owner 'root'
      group 'root'
      mode '0755'
      action :create
      not_if { ::File.exist?("/tmp/#{ubuntu_package}") }
    end

    # installing Artifactory
    execute 'install_dpkg' do
      command "dpkg -i /tmp/#{ubuntu_package}"
      not_if 'dpkg -l | grep artifactory'
    end
  end
end

# starting Artifactory service
service 'artifactory' do
  action :restart
end
