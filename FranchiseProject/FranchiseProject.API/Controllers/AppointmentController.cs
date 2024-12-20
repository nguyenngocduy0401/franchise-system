﻿using AutoMapper;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Services;
using FranchiseProject.Application.ViewModels.AppointmentViewModels;
using FranchiseProject.Application.ViewModels.WorkViewModels;
using FranchiseProject.Domain.Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace FranchiseProject.API.Controllers
{
    [Route("api/v1/appointments")]
    [ApiController]
    public class AppointmentController : ControllerBase
    {
        private readonly IAppointmentService _appointmentService;
        private readonly IUserAppointmentService _userAppointmentService;
        public AppointmentController(IAppointmentService appointmentService, IUserAppointmentService userAppointmentService)
        {
            _appointmentService = appointmentService;
            _userAppointmentService = userAppointmentService;
        }
        [SwaggerOperation(Summary = "lấy chi tiết cuộc hẹn bằng id")]
        [HttpGet("{id}")]
        public async Task<ApiResponse<AppointmentDetailViewModel>> GetAppointmentDetailByIdAsync(Guid id)
        {
            return await _appointmentService.GetAppointmentDetailByIdAsync(id);
        }
        [Authorize(Roles = AppRole.Manager)]
        [SwaggerOperation(Summary = "tạo cuộc hẹn{Authorize = Manager}")]
        [HttpPost()]
        public async Task<ApiResponse<bool>> CreateAppointmentAsync(CreateAppointmentModel createAppointmentModel)
        {
            return await _appointmentService.CreateAppointmentAsync(createAppointmentModel);
        }
        [Authorize(Roles = AppRole.Manager)]
        [SwaggerOperation(Summary = "cập nhật cuộc hẹn{Authorize = Manager}")]
        [HttpPut("{id}")]
        public async Task<ApiResponse<bool>> UpdateAppointmentAsync(Guid id, UpdateAppointmentModel updateAppointmentModel)
        {
            return await _appointmentService.UpdateAppointmentAsync(id, updateAppointmentModel);
        }
        [Authorize(Roles = AppRole.Manager)]
        [SwaggerOperation(Summary = "Nộp báo cáo cuộc hẹn{Authorize = Manager}")]
        [HttpPut("~/staff/api/v1/appointments/{id}")]
        public async Task<ApiResponse<bool>> SubmitAppointmentReportAsync(Guid id, SubmitAppointmentModel submitAppointmentModel)
        {
            return await _appointmentService.SubmitAppointmentReportAsync(id, submitAppointmentModel);
        }
        [Authorize(Roles = AppRole.Manager)]
        [SwaggerOperation(Summary = "xóa cuộc hẹn{Authorize = Manager}")]
        [HttpDelete("{id}")]
        public async Task<ApiResponse<bool>> DeleteAppointmentAsync(Guid id)
        {
            return await _appointmentService.DeleteAppointmentAsync(id);
        }
        [SwaggerOperation(Summary = "cập nhật danh sách user trong cuộc hẹn{Authorize = Manager}")]
        [HttpPost("{id}/users")]
        public async Task<ApiResponse<bool>> CreateUserAppointmentAsync(Guid id, List<string> userIds)
        {
            return await _userAppointmentService.CreateUserAppointmentAsync(id, userIds);
        }
        [Authorize(Roles = AppRole.Manager + "," +
            AppRole.SystemConsultant + "," + AppRole.SystemTechnician + ","
            + AppRole.SystemInstructor)]
        [SwaggerOperation(Summary = "Lấy cuộc hẹn của nhân viên {Authorize = Manager, SystenConsultant, SystemTechniciaan, SystemInstructor}")]
        [HttpGet("~/staff/api/v1/appointments")]
        public async Task<ApiResponse<IEnumerable<AppointmentViewModel>>> GetScheduleByLoginAsync([FromQuery] FilterScheduleAppointmentViewModel search)
        {
            return await _appointmentService.GetScheduleByLoginAsync(search);
        }
        [SwaggerOperation(Summary = "Lấy cuộc hẹn của nhân viên {Authorize = Manager, SystenConsultant, SystemTechniciaan, SystemInstructor}")]
        [HttpGet("~/agency/api/v1/appointments")]
        public async Task<ApiResponse<IEnumerable<AppointmentViewModel>>> GetScheduleAgencyByLoginAsync([FromQuery] FilterScheduleAppointmentViewModel search)
        {
            return await _appointmentService.GetScheduleAgencyByLoginAsync(search);
        }
    }
}
