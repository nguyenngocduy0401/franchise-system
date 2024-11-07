﻿using FranchiseProject.Application.Commons;
using FranchiseProject.Application.ViewModels.AgencyDashboardViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Interfaces
{
    public interface IAgencyDashboardService
    {
        Task<ApiResponse<int>> GetTotalRevenueFromRegisterCourseAsync(DateTime startDate, DateTime endDate);
        Task<ApiResponse<List<CourseRevenueViewModel>>> GetCourseRevenueAsync(DateTime startDate, DateTime endDate);
    }
}
