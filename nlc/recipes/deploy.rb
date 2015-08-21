node[:deploy].each do |application, deploy|

  interpreter "bash"
  user "root"
  cwd "#{deploy[:deploy_to]}/current"
  code <<-EOH
  touch storage/logs/lumen.log
  chmod -R 777 ./storage
  chmod -R 777 ./public/docs
  EOH

  # write out .env file
  template "#{deploy[:deploy_to]}/current/.env" do
    source 'env.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(
      :env => deploy[:environment_variables]
    )
  end

end
