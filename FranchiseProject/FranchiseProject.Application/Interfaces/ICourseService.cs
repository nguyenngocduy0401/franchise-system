﻿using FranchiseProject.Application.Commons;
using FranchiseProject.Application.ViewModels.CourseViewModels;
using FranchiseProject.Application.ViewModels.MaterialViewModels;
using FranchiseProject.Application.ViewModels.SlotViewModels;
using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Interfaces
{
    public interface ICourseService
    {
        Task<ApiResponse<bool>> CreateCourseVersionAsync(Guid courseId);
        Task<ApiResponse<List<CourseViewModel>>> GetAllCourseAsync();
        Task<ApiResponse<Pagination<CourseViewModel>>> FilterCourseAsync(FilterCourseModel filterCourseViewModel);
        Task<ApiResponse<bool>> DeleteCourseByIdAsync(Guid courseId);
        Task<ApiResponse<CourseDetailViewModel>> GetCourseByIdAsync(Guid courseId);
        Task<ApiResponse<bool>> UpdateCourseAsync(Guid courseId, UpdateCourseModel updateCourseModel);
        Task<ApiResponse<bool>> CreateCourseAsync(CreateCourseModel createCourseModel);
        Task<ApiResponse<bool>> CheckCourseAvailableAsync(Guid? courseId, CourseStatusEnum courseStatus);
    }
}
