# add plugins migration paths to main app's db migrations
PluginsManager.available_plugins.each do |plugin|
  ActiveRecord::Tasks::DatabaseTasks.migrations_paths.push(plugin.path+"/db/migrate")
end
