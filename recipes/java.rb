# This recipe installs open jre

if node['platform'] == 'centos' || node['platform'] == 'rhel7'
  package 'java-1.8.0-openjdk'

elsif node['platform'] == 'ubuntu'
  package 'openjdk-8-jre'
end
