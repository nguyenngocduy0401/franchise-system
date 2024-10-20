﻿using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Services;
using FranchiseProject.Application.ViewModels.AssessmentViewModels;
using FranchiseProject.Application.ViewModels.ChapterViewModels;
using FranchiseProject.Application.ViewModels.CourseViewModels;
using FranchiseProject.Application.ViewModels.MaterialViewModels;
using FranchiseProject.Application.ViewModels.SessionViewModels;
using FranchiseProject.Application.ViewModels.SlotViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace FranchiseProject.API.Controllers
{
    [Route("api/v1/courses")]
    [ApiController]
    public class CourseController : ControllerBase
    {
        private readonly ICourseService _courseService;
        private readonly IMaterialService _materialService;
        private readonly IAssessmentService _assessmentService;
        private readonly ISessionService _sessionService;
        private readonly IChapterService _chapterService;
        public CourseController(ICourseService courseService, IMaterialService materialService,
            IAssessmentService assessmentService, ISessionService sessionService, 
            IChapterService chapterService)
        {
            _courseService = courseService;
            _materialService = materialService;
            _assessmentService = assessmentService;
            _sessionService = sessionService;
            _chapterService = chapterService;
        }
        //[Authorize(Roles = AppRole.Admin + "," + AppRole.Manager)]
        [SwaggerOperation(Summary = "xóa khoá học bằng id {Authorize = Admin, Manager}")]
        [HttpDelete("{id}")]
        public async Task<ApiResponse<bool>> DeleteCourseAsync(Guid id)
        {
            return await _courseService.DeleteCourseByIdAsync(id);
        }
        //[Authorize(Roles = AppRole.Admin + "," + AppRole.Manager)]
        [SwaggerOperation(Summary = "tạo mới khoá học {Authorize = Admin, Manager}")]
        [HttpPost()]
        public async Task<ApiResponse<bool>> CreateCourseAsync(CreateCourseModel createCourseModel)
        {
            return await _courseService.CreateCourseAsync(createCourseModel);
        }
        //[Authorize(Roles = AppRole.Admin + "," + AppRole.Manager)]
        [SwaggerOperation(Summary = "cập nhật khoá học {Authorize = Admin, Manager}")]
        [HttpPut("{id}")]
        public async Task<ApiResponse<bool>> UpdateCourseAsync(Guid id, UpdateCourseModel updateCourseModel)
        {
            return await _courseService.UpdateCourseAsync(id, updateCourseModel);
        }
        [SwaggerOperation(Summary = "cập nhật tài nguyên của khoá học {Authorize = Admin, Manager}")]
        [HttpPost("{id}/materials")]
        public async Task<ApiResponse<bool>> CreateMaterialByCourseIdAsync(Guid id, List<CreateMaterialArrangeModel> createMaterialArrangeModel)
        {
            return await _materialService.CreateMaterialArrangeAsync(id, createMaterialArrangeModel);
        }
        [SwaggerOperation(Summary = "cập nhật đánh giá của khoá học {Authorize = Admin, Manager}")]
        [HttpPost("{id}/assessments")]
        public async Task<ApiResponse<bool>> CreateAssessmentByCourseIdAsync(Guid id, List<CreateAssessmentArrangeModel> createAssessmentArrangeModel)
        {
            return await _assessmentService.CreateAssessmentArangeAsync(id, createAssessmentArrangeModel);
        }
        [SwaggerOperation(Summary = "cập nhật phiên của khoá học {Authorize = Admin, Manager}")]
        [HttpPost("{id}/sessions")]
        public async Task<ApiResponse<bool>> CreateSessionByCourseIdAsync(Guid id, List<CreateSessionArrangeModel> createSessionArrangeModel)
        {
            return await _sessionService.CreateSessionArrangeAsync(id, createSessionArrangeModel);
        }
        [SwaggerOperation(Summary = "cập nhật chương của khoá học {Authorize = Admin, Manager}")]
        [HttpPost("{id}/chapters")]
        public async Task<ApiResponse<bool>> CreateChapterByCourseIdAsync(Guid id, List<CreateChapterArrangeModel> createChapterArrangeModel)
        {
            return await _chapterService.CreateChapterArrangeAsync(id, createChapterArrangeModel);
        }
        [SwaggerOperation(Summary = "tìm khoá học bằng id")]
        [HttpGet("{id}")]
        public async Task<ApiResponse<CourseDetailViewModel>> GetCourseByIdAsync(Guid id)
        {
            return await _courseService.GetCourseByIdAsync(id);
        }
        [SwaggerOperation(Summary = "tìm kiếm khoá học")]
        [HttpGet("")]
        public async Task<ApiResponse<Pagination<CourseViewModel>>> FilterCourseAsync([FromQuery] FilterCourseModel filterCourseModel)
        {
            return await _courseService.FilterCourseAsync(filterCourseModel);
        }
    }
}
