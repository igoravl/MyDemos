title 'sample section'

# you can also use plain tests
describe os do
  its('family') { should eq 'windows' }
  its('release') { should eq 'windows' }
end
