# Support whyrun
def whyrun_supported?
  true
end

action :install do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Install Steam App #{ @new_resource }") do
      install_steam_app
    end
  end
end

action :update do
  if @current_resource.exists
    converge_by("Update Steam App #{ @new_resource }") do
      update_steam_app
    end
  else
    Chef::Log.info "#{ @current_resource } doesn't exist - can't update."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::RustSteamcmd.new(@new_resource.name)

  @current_resource.name(@new_resource.name)
  @current_resource.app_id(@new_resource.app_id)
  @current_resource.path(@new_resource.path)
  @current_resource.beta(@new_resource.beta)

  if directory_exists?(@current_resource.path)
    # TODO: We should probably be smarter about this and actually check the contents
    @current_resource.exists = true
  end
end


def install_steam_app
  beta = ''
  if new_resource.beta
    beta = "-beta #{ new_resource.beta }"
  end

  # Install app via powershell
  powershell "Installing Steam App #{ new_resource.app_id }" do
    code <<-EOH
      steamcmd login anonymous +force_install_dir #{ new_resource.path } #{ new_resource.app_id } #{ beta } validate +quit
    EOH
  end
end

def update_steam_app
  beta = ''
  if new_resource.beta
    beta = "-beta #{ new_resource.beta }"
  end

  # Install app via powershell
  powershell "Installing Steam App #{ new_resource.app_id }" do
    code <<-EOH
      steamcmd login anonymous +force_install_dir #{ new_resource.path } +app_update #{ new_resource.app_id } #{ beta } validate +quit
    EOH
  end
end
