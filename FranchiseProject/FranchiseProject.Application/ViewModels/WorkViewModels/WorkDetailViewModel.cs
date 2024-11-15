﻿using FranchiseProject.Application.ViewModels.AppointmentViewModels;
using FranchiseProject.Domain.Enums;

namespace FranchiseProject.Application.ViewModels.WorkViewModels
{
    public class WorkDetailViewModel
    {
        public Guid? Id { get; set; }
        public string? Description { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public WorkTypeEnum? Type { get; set; }
        public List<AppointmentViewModel>? Appointments { get; set; }
        public Guid? AgencyId { get; set; }
    }
}