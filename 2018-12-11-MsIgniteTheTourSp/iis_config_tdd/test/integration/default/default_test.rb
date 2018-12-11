# encoding: utf-8

title 'Testes de configuração do IIS'

  describe windows_feature('Web-Server') do
    it { should be_installed }
  end
  
  describe windows_feature('Web-Mgmt-Console') do
    it { should be_installed }
  end
  
  describe windows_feature('Web-Mgmt-Service') do
    it { should be_installed }
  end
  
  describe windows_feature('Web-Asp-Net45') do
    it { should be_installed }
  end
  
  describe file('c:\\inetpub\\wwwroot') do
    it { should exist }
    it { should be_directory }
  end
  
  describe service('W3SVC') do
    it { should be_installed }
    it { should be_running }
  end
  
  describe iis_site('Default Web Site') do
    it { should exist }
    it { should be_running }
    it { should have_app_pool('DefaultAppPool') }
    it { should have_binding('http *:80:') }
    it { should have_path('c:\\inetpub\\wwwroot') }
  end
  
  describe iis_app('/MyApp', 'Default Web Site') do
    it { should exist }
    it { should have_application_pool('MyAppPool') }
    it { should have_site_name('Default Web Site') }
    it { should have_physical_path('c:\\inetpub\\wwwroot\\myapp') }
  end
  
  describe port(80) do
    it { should be_listening }
    its('addresses') {should include '0.0.0.0'}
    its('processes') {should cmp 'System'}
  end
  