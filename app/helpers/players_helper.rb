module PlayersHelper
  SCORES = %i[goals wins draws losses].freeze

  def score_type_or_default
    params[:score_type]&.to_sym || :total
  end

  def order_by_or_default
    params[:order_by]&.to_sym || :goals
  end

  def goals(player)
    score_type_or_default == :total ? player.goals : player.goals_per_game
  end

  def wins(player)
    score_type_or_default == :total ? player.wins : player.wins_per_game
  end

  def draws(player)
    score_type_or_default == :total ? player.draws : player.draws_per_game
  end

  def losses(player)
    score_type_or_default == :total ? player.losses : player.losses_per_game
  end

  def main_score(player)
    score(player, order_by_or_default)
  end

  def score(player, category)
    tag.div do
      link_to with_params({ order_by: category }) do
        safe_join([stats_icon(category), send(category, player)], " ")
      end
    end
  end

  def other_scores(player)
    other_scores = SCORES - [order_by_or_default]

    safe_join(other_scores.map { |category| score(player, category) })
  end

  def stats_icon(category)
    icon_name = case category
                when :wins
                  "crown"
                when :draws
                  "handshake"
                when :losses
                  "skull-crossbones"
                else
                  "futbol"
                end

    tag.i class: "fa-solid fa-#{icon_name}"
  end
end
