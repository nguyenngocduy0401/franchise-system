﻿using FluentValidation;
using FranchiseProject.Application.Utils;
using FranchiseProject.Application.ViewModels.AppointmentViewModels;

namespace FranchiseProject.API.Validator.AppointmentValidator
{
    public class UpdateAppointmentReportValidator : AbstractValidator<SubmitAppointmentModel>
    {
        public UpdateAppointmentReportValidator()
        {
            RuleFor(x => x.Report.GetTextWithoutHtml())
                .MaximumLength(3000);
            RuleFor(x => x.ReportImageURL)
                .MaximumLength(500);
        }
    }
}
