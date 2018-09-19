default['artifactory']['version'] = '6.3.3'
default['artifactory']['package']['name'] = 'jfrog-artifactory-pro'

# Installing artifactory from official repo
default['artifactory']['install']['repo'] = true
default['rhel7']['artifactory']['download']['repo']['url']['internet'] = 'https://bintray.com/jfrog/artifactory-pro-rpms/rpm'
default['rhel7']['artifactory']['repo']['name'] = 'jfrog-artifactory-pro-rpms.repo'
default['rhel7']['yum']['repo']['location'] = '/etc/yum.repos.d'

default['ubuntu']['artifactory']['download']['repo']['url']['internet'] = 'https://jfrog.bintray.com/artifactory-pro-debs'
default['ubuntu']['repo']['source']['list'] = '/etc/apt/sources.list'

# Installing artifactory from a package (rpm/deb file)
default['artifactory']['install']['package'] = false
# change the url to an internal url 
default['rhel7']['artifactory']['download']['url']['internal'] = 'https://bintray.com/jfrog/artifactory-pro-rpms/download_file?file_path=org%2Fartifactory%2Fpro%2Frpm%2Fjfrog-artifactory-pro%2F6.3.3%2Fjfrog-artifactory-pro-6.3.3.rpm'
default['rhel7']['artifactory']['rpm']['package'] = 'artifactory.rpm'

# change the url to an internal url
default['ubuntu']['artifactory']['download']['url']['internal'] = 'https://bintray.com/jfrog/artifactory-pro-debs/download_file?file_path=pool%2Fmain%2Fj%2Fjfrog-artifactory-pro-deb%2Fjfrog-artifactory-pro-6.3.3.deb'
default['ubuntu']['artifactory']['package'] = 'artifactory.deb'
