module ClinicalTrialVisitsHelper
  def visit_when(visit)
    if visit.after_visit
      ret = visit.after_visit.name + " + " + visit.offset_days.to_s + " (" + "&plusmn;" + visit.tolerance_number_of_days.to_s + ") " + t('clinical_trial.visit.days')
    else
      ret = "D"
    end
    return ret
  end
end
