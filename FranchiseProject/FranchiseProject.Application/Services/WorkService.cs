﻿using AutoMapper;
using DocumentFormat.OpenXml.Spreadsheet;
using FluentValidation;
using FluentValidation.Results;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Handler;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.ViewModels.AppointmentViewModels;
using FranchiseProject.Application.ViewModels.WorkViewModels;
using FranchiseProject.Domain.Entity;
using FranchiseProject.Domain.Enums;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Services
{
    public class WorkService : IWorkService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly UserManager<User> _userManager;
        private readonly IClaimsService _claimsService;
        private readonly IValidator<CreateWorkModel> _createWorkValidator;
        private readonly IValidator<UpdateWorkModel> _updateWorkValidator;
        private readonly IValidator<UpdateWorkByStaffModel> _updateWorkByStaffValidator;
        public WorkService(IUnitOfWork unitOfWork, UserManager<User> userManager,
            IValidator<CreateWorkModel> createWorkValidator, IMapper mapper,
            IValidator<UpdateWorkModel> updateWorkValidator, IClaimsService claimsService,
            IValidator<UpdateWorkByStaffModel> updateWorkByStaffValidator)
        {
            _unitOfWork = unitOfWork;
            _userManager = userManager;
            _mapper = mapper;
            _createWorkValidator = createWorkValidator;
            _updateWorkValidator = updateWorkValidator;
            _claimsService = claimsService;
            _updateWorkByStaffValidator = updateWorkByStaffValidator;
        }
        public async Task<ApiResponse<Pagination<WorkViewModel>>> FilterWorksByLogin(FilterWorkByLoginModel filterWorkByLoginModel)
        {
            var response = new ApiResponse<Pagination<WorkViewModel>>();
            try
            {
                var userId = _claimsService.GetCurrentUserId.ToString();
                var filter = (Expression<Func<Work, bool>>)(e =>
                    (string.IsNullOrEmpty(filterWorkByLoginModel.Search) || e.Title.Contains(filterWorkByLoginModel.Search)
                    || e.Description.Contains(filterWorkByLoginModel.Search)) &&
                    (!filterWorkByLoginModel.Status.HasValue || e.Status == filterWorkByLoginModel.Status) &&
                    (!filterWorkByLoginModel.Level.HasValue || e.Level == filterWorkByLoginModel.Level) &&
                    (!filterWorkByLoginModel.Submit.HasValue || e.Submit == filterWorkByLoginModel.Submit)
                );
                var worksPagination = await _unitOfWork.WorkRepository.FilterWorksByUserId(
                userId: userId,
                filter: filter,
                pageIndex: filterWorkByLoginModel.PageIndex,
                pageSize: filterWorkByLoginModel.PageSize
                );
                var workModel = _mapper.Map<Pagination<WorkViewModel>>(worksPagination);

                response = ResponseHandler.Success(workModel, "Successful!");

            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<Pagination<WorkViewModel>>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<WorkDetailViewModel>> GetWorkDetailByIdAsync(Guid id) 
        {
            var response = new ApiResponse<WorkDetailViewModel>();
            try
            {
                var work = await _unitOfWork.WorkRepository.GetWorkDetailById(id);
                if (work == null) return ResponseHandler.Success(new WorkDetailViewModel(), "Nhiệm vụ không khả dụng!");
                var approvedBy = await _userManager.FindByIdAsync((work.ApproveBy).ToString());
                var workModel = _mapper.Map<WorkDetailViewModel>(work);
                if (approvedBy != null) 
                {
                    workModel.ApprovedBy = new AppointmentUserViewModel 
                    {
                        FullName = approvedBy.FullName,
                        Id = approvedBy.Id,
                        Username = approvedBy.UserName,
                    };
                }
                response = ResponseHandler.Success(workModel);
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<WorkDetailViewModel>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> DeleteWorkByIdAsync(Guid workId)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var work = await _unitOfWork.WorkRepository.GetExistByIdAsync(workId);

                var checkWork = await CheckPreWorkAvailable(work);
                if (checkWork.Data == false) return checkWork;

                _unitOfWork.WorkRepository.SoftRemove(work);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Delete failed!");

                response = ResponseHandler.Success(true, "Xoá nhiệm vụ thành công!");
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<WorkAgencyViewModel>> GetAllWorkByAgencyId(Guid agencyId)
        {
            var response = new ApiResponse<WorkAgencyViewModel>();
            try
            {
                var agency =await _unitOfWork.AgencyRepository.GetExistByIdAsync(agencyId);
                var work = _unitOfWork.WorkRepository.GetAllPreWorkByAgencyId(agencyId);
                var workModel = _mapper.Map<IEnumerable<WorkViewModel>>(work);
                var workAgencyModel = new WorkAgencyViewModel 
                {
                    Work = workModel,
                    AgencyStatus = agency.Status
                };
                response = ResponseHandler.Success(workAgencyModel, "Successful!");

            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<WorkAgencyViewModel>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<Pagination<WorkViewModel>>> FilterWorkAsync(FilterWorkModel filterWorkModel)
        {
            var response = new ApiResponse<Pagination<WorkViewModel>>();
            try
            {
                var filter = (Expression<Func<Work, bool>>)(e =>
                    (string.IsNullOrEmpty(filterWorkModel.Search) || e.Title.Contains(filterWorkModel.Search)
                    || e.Description.Contains(filterWorkModel.Search)) 
                    &&
                    ((!filterWorkModel.AgencyId.HasValue || filterWorkModel.AgencyId == null) 
                    || e.AgencyId == filterWorkModel.AgencyId) &&
                    (!filterWorkModel.Status.HasValue || e.Status == filterWorkModel.Status) &&
                    (!filterWorkModel.Level.HasValue || e.Level == filterWorkModel.Level) &&
                    (!filterWorkModel.Submit.HasValue || e.Submit == filterWorkModel.Submit)
                );
                var worksPagination = await _unitOfWork.WorkRepository.GetFilterAsync(
                filter: filter,
                pageIndex: filterWorkModel.PageIndex,
                pageSize: filterWorkModel.PageSize
                );
                var workModel = _mapper.Map<Pagination<WorkViewModel>>(worksPagination);
                
                response = ResponseHandler.Success(workModel, "Successful!");

            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<Pagination<WorkViewModel>>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> UpdateWorkStatusSubmitByStaffAsync(Guid workId, WorkStatusSubmitEnum workStatusSubmitEnum)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var userId = _claimsService.GetCurrentUserId.ToString();

                var checkUserExist = await _unitOfWork.WorkRepository.CheckUserWorkExist(workId, userId);
                if(checkUserExist == false) 
                    return ResponseHandler.Success(false, "Người dùng không có quyền để thao tác với nhiệm vụ!");

                var work = await _unitOfWork.WorkRepository.GetExistByIdAsync(workId);

                var checkWork = await CheckPreWorkAvailable(work);
                if (checkWork.Data == false) return checkWork;

                work.Submit = workStatusSubmitEnum;
                _unitOfWork.WorkRepository.Update(work);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Update failed!");

                response = ResponseHandler.Success(true, "Bàn giao nhiệm vụ thành công!");
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> UpdateWorkByStaffAsync(Guid workId, UpdateWorkByStaffModel updateWorkByStaffModel)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var userId = _claimsService.GetCurrentUserId.ToString();

                var checkUserExist = await _unitOfWork.WorkRepository.CheckUserWorkExist(workId, userId);
                if (checkUserExist == false)
                    return ResponseHandler.Success(false, "Người dùng không có quyền để thao tác với nhiệm vụ!");

                ValidationResult validationResult = await _updateWorkByStaffValidator.ValidateAsync(updateWorkByStaffModel                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 );
                if (!validationResult.IsValid) return ValidatorHandler.HandleValidation<bool>(validationResult);

                var work = await _unitOfWork.WorkRepository.GetExistByIdAsync(workId);

                var checkWork = await CheckPreWorkAvailable(work);
                if (checkWork.Data == false) return checkWork;

                work = _mapper.Map(updateWorkByStaffModel, work);
                _unitOfWork.WorkRepository.Update(work);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Update failed!");

                response = ResponseHandler.Success(true, "Cập nhật nhiệm vụ thành công!");
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> UpdateWorkAsync(Guid workId, UpdateWorkModel updateWorkModel)
        {
            var response = new ApiResponse<bool>();
            try
            {
                ValidationResult validationResult = await _updateWorkValidator.ValidateAsync(updateWorkModel);
                if (!validationResult.IsValid) return ValidatorHandler.HandleValidation<bool>(validationResult);

                var work = await _unitOfWork.WorkRepository.GetExistByIdAsync(workId);

                work = _mapper.Map(updateWorkModel, work);

                var checkWork = await CheckPreWorkAvailable(work);
                if (checkWork.Data == false) return checkWork;

                _unitOfWork.WorkRepository.Update(work);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Update failed!");

                response = ResponseHandler.Success(true, "Cập nhật nhiệm vụ thành công!");
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> CreateWorkAsync(CreateWorkModel createWorkModel)
        {
            var response = new ApiResponse<bool>();
            try
            {
                ValidationResult validationResult = await _createWorkValidator.ValidateAsync(createWorkModel);
                if (!validationResult.IsValid) if (!validationResult.IsValid) return ValidatorHandler.HandleValidation<bool>(validationResult);

                var work = _mapper.Map<Work>(createWorkModel);
                work.Status = WorkStatusEnum.None;
                work.Submit = WorkStatusSubmitEnum.None;

                var checkWork = await CheckPreWorkAvailable(work);
                if (checkWork.Data == false) return checkWork;

                await _unitOfWork.WorkRepository.AddAsync(work);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Create failed!");

                response = ResponseHandler.Success(true, "Tạo nhiệm vụ thành công!");

            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> UpdateStatusWorkByIdAsync(Guid workId, WorkStatusEnum status)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var userId = _claimsService.GetCurrentUserId;
                var work = await _unitOfWork.WorkRepository.GetExistByIdAsync(workId);

                var checkWork = await CheckPreWorkAvailable(work);
                if (checkWork.Data == false) return checkWork;

                if (work.Status != WorkStatusEnum.None) return ResponseHandler.Success(false, "Nhiệm vụ đã được duyệt trước đó!");
                var checkWorkBefore = (await _unitOfWork.WorkRepository
                    .FindAsync(e => e.IsDeleted != true &&
                               e.Type < work.Type && 
                               e.Status != WorkStatusEnum.Approved &&
                               e.Level == WorkLevelEnum.Compulsory &&
                               e.AgencyId == work.AgencyId
                               )).FirstOrDefault();

                if(checkWorkBefore != null) return ResponseHandler.Success(false, "Phải hoàn thành nhiệm vụ ưu tiên trước!");

                switch (status) 
                {
                    case WorkStatusEnum.None:
                        throw new Exception("Cannot update this status!");
                    case WorkStatusEnum.Approved:
                        work.Status = status;
                        break;
                    case WorkStatusEnum.Rejected:
                        work.Status = status;
                        if (work.Level == WorkLevelEnum.Compulsory)
                        {
                            var agency = await _unitOfWork.AgencyRepository.GetExistByIdAsync((Guid)work.AgencyId);
                            if (agency == null)
                            {
                                return ResponseHandler.Success(false, "Cơ sở nhượng quyền không khả dụng!");
                            }
                            agency.Status = AgencyStatusEnum.Inactive;
                            _unitOfWork.AgencyRepository.Update(agency);
                        }
                        break;
                }
                work.ApproveBy = userId;
                _unitOfWork.WorkRepository.Update(work);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Update failed!");

                response = ResponseHandler.Success(true, "Cập nhật nhiệm vụ thành công!");
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> CheckPreWorkAvailable(Work work) 
        {
            var response = new ApiResponse<bool>();
            try
            {
                var agency = await _unitOfWork.AgencyRepository.GetExistByIdAsync((Guid)work.AgencyId);
                if (agency == null || agency.Status == AgencyStatusEnum.Inactive) return ResponseHandler.Success(false, "Trung tâm không khả dụng!");
                if (work.Type <= WorkTypeEnum.SignedContract)
                {
                    if (agency.Status == AgencyStatusEnum.Suspended ||
                        agency.Status == AgencyStatusEnum.Active)
                        return ResponseHandler.Success(false, "Không thể tương tác với nhiệm vụ khi đã kết thúc quá trình nhượng quyền!");
                }

                if (work == null) return ResponseHandler.Success(false, "Nhiệm vụ không khả dụng!");
                if (work.Status != WorkStatusEnum.None) return ResponseHandler.Success(false, "Không thể thao tác với nhiệm vụ đã được kiểm duyệt!");
                response = ResponseHandler.Success(true);
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
    }
}
