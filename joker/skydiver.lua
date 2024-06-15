SMODS.Joker {
    key = 'skydiver',
    loc_txt = {
        name = "Skydiver",
        text = {
            "{C:white,X:mult}x#1#{} Mult if all {C:attention}scored cards{} are equal",
            "to or lower than the {C:attention}lowest ranked{} card scored this round.",
            "Lowest card updated at end of played hand.",
            "(Currently: #2#)"
        }
    },
    config = {
        extra = {
            Xmult = 1,
            Xmult_mod = 3,
            lowest_rank = 14,
        }
    },
    rarity = 2,
    pos = { x = 4, y = 1 },
    atlas = 'jokers_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.Xmult_mod
            }
        }
    end,

    -- Calculate function for the Joker
    calculate = function(self, card, context)
        if context.scoring_hand then

        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            card.ability.extra.lowest_rank = 14
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_reset'), colour = G.C.SECONDARY_SET.Planet})
            -- return {
            --     card = self,
            --     message = localize('k_reset')
            -- }
        end
    end
}
