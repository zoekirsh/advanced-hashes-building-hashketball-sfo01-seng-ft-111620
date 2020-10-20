def game_hash 
  bball = {:home => {}, :away => {}}
  
  bball.each do |key, value|
    value[:team_name] = ""
    value[:colors] = []
    value[:players] = []
  end

  bball[:home]
  
  bball
end 
