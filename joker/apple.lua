SMODS.Joker {
  key = "apple",
  config = {
    extra = {
      odds = 1,
    }
  },
  rarity = 1,
  pos = { x = 6, y = 6 },
  atlas = 'jokers_atlas',
  cost = 1,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
  soul_pos = { x = 7, y = 6 },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative

    return {
      vars = {
        G.GAME.probabilities.normal,
        card.ability.extra.odds,
      }
    }
  end,

  calculate = function(self, card, context)
    if not context.blueprint then
      if context.individual and context.cardarea == G.play then
        if context.other_card:is_suit("Hearts") then
          if pseudorandom("Apple") < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
              trigger = 'before',
              func = function()
                -- Give the negative consumable
                local _card = PB_UTIL.poll_consumable('apple')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                G.GAME.consumeable_buffer = 0

                return true
              end
            }))

            PB_UTIL.destroy_joker(card)

            if not context.blueprint then
              return {
                message = "Destroyed!",
                colour = G.C.RED,
                card = card
              }
            end
          end
        end
      end
    end
  end
}
