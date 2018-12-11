# encoding: utf-8

title 'Windows RDP Configuration'

control 'windows-rdp-100' do
  impact 1.0
  title 'Windows Remote Desktop Configured to Always Prompt for Password'
  describe registry_key('HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services') do
    it { should exist }
    its('fPromptForPassword') { should eq 1 }
  end
end

control 'windows-rdp-101' do
  impact 1.0
  title 'Strong Encryption for Windows Remote Desktop Required'
  describe registry_key('HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services') do
    it { should exist }
    its('MinEncryptionLevel') { should eq 3 }
  end
end
