module PatientVisitsHelper
  def from_to(enrollment_visit, visit)
    if enrollment_visit.present?
      start_date = enrollment_visit.recorded_date + visit.offset_days.days - visit.tolerance_number_of_days.days
      end_date = enrollment_visit.recorded_date + visit.offset_days.days + visit.tolerance_number_of_days.days
      return t("visit.from") + ": " + l(start_date) + " " + t("visit.to") + ": " + l(end_date)
    else
      return "D + " + visit.offset_days.to_s + " &plusmn; " + visit.tolerance_number_of_days.to_s
    end
  end

  def is_outdate(visit, patient)
    enrollment_visit = visit.clinical_trial.visits.first.get_patient_visit(patient)
    if visit.clinical_trial.visits.first == visit
      start_date = visit.clinical_trial.enrollment_begin_date
      end_date = visit.clinical_trial.enrollment_end_date
    else
      start_date = enrollment_visit.recorded_date + visit.offset_days.days - visit.tolerance_number_of_days.days
      end_date = enrollment_visit.recorded_date + visit.offset_days.days + visit.tolerance_number_of_days.days
    end
    today = DateTime.now.to_date
    if today < start_date or today > end_date
      return true
    end
    return false
  end
end
