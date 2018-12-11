#
# Cookbook:: iis-config-tdd
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Enable the IIS role.
dsc_script 'Web-Server' do
    code <<-EOH
    WindowsFeature InstallWebServer
    {
        Name = "Web-Server"
        Ensure = "Present"
    }
    EOH
end

# Install ASP.NET 4.5.
dsc_script 'Web-Asp-Net45' do
    code <<-EOH
    WindowsFeature InstallDotNet45
    {
        Name = "Web-Asp-Net45"
        Ensure = "Present"
    }
    EOH
end