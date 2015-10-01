[:admin, :customer, :team_member, :project_manager].each do |role|
	Role.create(name: role)
end