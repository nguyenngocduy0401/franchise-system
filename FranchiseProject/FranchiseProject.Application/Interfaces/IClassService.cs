﻿using FranchiseProject.Application.Commons;
using FranchiseProject.Application.ViewModels.ClassScheduleViewModel;
using FranchiseProject.Application.ViewModels.ClassScheduleViewModels;
using FranchiseProject.Application.ViewModels.ClassViewModel;
using FranchiseProject.Application.ViewModels.ClassViewModels;
using FranchiseProject.Domain.Entity;
using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Interfaces
{
    public interface IClassService
    {
        Task<ApiResponse<bool>> CreateClassAsync(CreateClassViewModel model);
        Task<ApiResponse<bool>> UpdateClassAsync(string id, UpdateClassViewModel model);
        Task<ApiResponse<Pagination<ClassViewModel>>> FilterClassAsync(FilterClassViewModel filterClassModel);
    
         Task<ApiResponse<ClassViewModel>> GetClassByIdAsync(string id);
        Task<ApiResponse<bool>> UpdateClassStatusAsync(ClassStatusEnum status,string id);
         Task<ApiResponse<Pagination<ClassStudentViewModel>>> GetClassDetailAsync(string id);
        Task<ApiResponse<bool>> AddStudentAsync(string ClassId, AddStudentViewModel model);
         Task<ApiResponse<bool>> RemoveStudentAsync(string studentId, string classId);
        Task<ApiResponse<bool>> DeleteClassAsync(string classId);
        Task<ApiResponse<List<ClassScheduleViewModel>>> GetClassSchedulesByClassIdAsync(string classId);
        Task<ApiResponse<List<InstructorViewModel>>> GetInstructorsByAgencyAsync();

    }
}
