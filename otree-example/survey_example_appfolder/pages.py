from otree.api import Currency as c, currency_range, safe_json
from ._builtin import Page, WaitPage
from .models import Constants, Player



class Welcome(Page):
    form_model = Player
    form_fields = ['sm_time_welcome']

class TreatmentPage(Page):
    form_model = Player
    form_fields = ['sm_time_treatmentpage', 'sm_participation']

    def vars_for_template(self):
        return {'sm_group_assignment': safe_json(self.player.sm_group_assignment)}

class ParticipationPage(Page):
    form_model = Player
    form_fields=['sm_time_participationpage', 'sm_topic_relevance', 'sm_familiar_people', 'sm_booked', 'sm_transportation', 'sm_reach', 'sm_crowd', 
    'sm_polarization', 'sm_riots', 'sm_participation_else']

class PoliticalPage(Page):
    form_model = Player
    form_fields=['sm_time_politicalpage', 'sm_missing_knowledge', 'sm_own_knowledge', 'sm_general_knowledge',
    'sm_future', 'sm_unsure', 'sm_olddays']

class DemonstrationPage(Page):
    form_model = Player
    form_fields=['sm_time_demonstrationpage', 'sm_demonstration_change', 'sm_demonstration_democracy', 'sm_demonstration_views',
    'sm_politicians', 'sm_influence', 'sm_interests']

class EndPage(Page):
    form_model = Player
    form_fields=['sm_time_endpage']

page_sequence = [Welcome,
                TreatmentPage,
                ParticipationPage,
                PoliticalPage,
                DemonstrationPage,
                EndPage]