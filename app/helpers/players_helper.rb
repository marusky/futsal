module PlayersHelper
  def human_readable_goals(goals)
    text = case goals
      when 0, (5..)
        "gólov"
      when 1
        "gól"
      when 2..4
        "góly"
      end

    "#{goals} #{text}"
  end
end
