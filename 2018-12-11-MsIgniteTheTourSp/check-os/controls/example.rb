title 'Windows must be Windows Server 1803'

describe os do
  its('family') { should eq 'windows' }
  its('name') { should eq 'windows_server_2016_datacenter'}
  its('release') { should eq '10.0.17134' } 
end
