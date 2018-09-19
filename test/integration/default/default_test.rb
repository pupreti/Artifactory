# Inspec test for recipe Artifactory::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('artifactory') do
    it { should exist }
  end

  # This is an example test, replace it with your own test.
  describe port(8081) do
    it { should be_listening }
  end

  describe package('jfrog-artifactory-pro') do
    it { should be_installed }
  end

  describe command('java -version') do
    its('exit_status') { should eq 0 }
 end

end
