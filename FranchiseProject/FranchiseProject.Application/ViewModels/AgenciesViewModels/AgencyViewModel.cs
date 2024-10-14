﻿using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.ViewModels.ConsultationViewModels
{
    public class AgencyViewModel
    {
        public Guid? Id { get; set; }
        public string? Name { get; set; }
        public string? Address { get; set; }
        public string? City { get; set; }
        public string? District { get; set; }
        public string? Ward { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }
        public string? PositionImageURL { get; set; }
        public AgencyStatusEnum Status {  get; set; }
    }
}
