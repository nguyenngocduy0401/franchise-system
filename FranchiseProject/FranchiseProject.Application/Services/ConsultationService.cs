﻿using AutoMapper;
using FluentValidation;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.ViewModels.AgencyViewModel;
using FranchiseProject.Domain.Entity;
using FranchiseProject.Domain.Enums;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Services
{
    public class ConsultationService :IConsultationService
    {
        private readonly IClaimsService _claimsService;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IValidator<RegisterConsultationViewModel> _validator;
        private readonly UserManager<User> _userManager;
        private readonly IEmailService _emailService;
        public ConsultationService(IEmailService emailService,IUnitOfWork unitOfWork,IClaimsService claimsService, IValidator<RegisterConsultationViewModel> validator,
            IMapper mapper,UserManager<User> userManager)
        {
            _unitOfWork = unitOfWork;
                _claimsService = claimsService;
                _validator = validator;
            _mapper = mapper;
            _userManager = userManager;
            _emailService = emailService;
        }
        public async Task<ApiResponse<bool>> RegisterConsultationAsync(RegisterConsultationViewModel regis)
        {
            var response = new ApiResponse<bool>();
            try
            {
                FluentValidation.Results.ValidationResult validationResult = await _validator.ValidateAsync(regis);
                if (!validationResult.IsValid)
                {
                    response.isSuccess = false;
                    response.Message = string.Join(", ", validationResult.Errors.Select(error => error.ErrorMessage));
                    return response;
                }
                var franchiseRequest = _mapper.Map<FranchiseRegistrationRequests>(regis);
                franchiseRequest.Status = ConsultationStatusEnum.NotConsulted;
                await _unitOfWork.FranchiseRegistrationRequestRepository.AddAsync(franchiseRequest);
                var isSuccess = await _unitOfWork.SaveChangeAsync();
               if (isSuccess > 0)
                {
                    var emailResponse = await _emailService.SendRegistrationSuccessEmailAsync(regis.Email); 
                    if (!emailResponse.isSuccess)
                    {
                     response.Message = "Tạo Thành Công, nhưng không thể gửi email xác nhận.";
                    }
                    response.Data = true;
                    response.isSuccess = true;
                    response.Message = "Tạo Thành Công !";
                }
                else
                {
                    throw new Exception("Create unsuccessfully");
                }
            }
            catch (DbException ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;

            }
            catch (Exception ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
          
        }

        public async Task<ApiResponse<bool>> UpdateConsultationStatusAsync(string requestId)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var userId= _claimsService.GetCurrentUserId.ToString();
                
                var id= Guid.Parse(requestId);
                var exist = await _unitOfWork.FranchiseRegistrationRequestRepository.GetByIdAsync(id);
                if (exist == null)
                {
                 
                    response.Data = false;
                    response.isSuccess = true;
                    response.Message = "không tìm thấy";

                }
                exist.Status = ConsultationStatusEnum.Consulted;
                var currentUser = await _userManager.FindByIdAsync(userId);
                if (currentUser == null)
                {

                    response.isSuccess = false;
                    response.Message = "Current user not found.";
                    
                }
                exist.ConsultantUserName = currentUser.FullName;
               await _unitOfWork.FranchiseRegistrationRequestRepository.Update(exist);
                var result = await _unitOfWork.SaveChangeAsync();
                if (result > 0)
                {
                    response.Data = true;
                    response.isSuccess = true;
                    response.Message = "Cập nhật trạng thái thành công.";
                }
                else
                {
                    throw new Exception("Update failed!");
                }
            }
            catch (DbException ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;

            }
            catch (Exception ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
        }
        public async Task<ApiResponse<Pagination<ConsultationViewModel>>> FilterConsultationAsync(FilterConsultationViewModel filterModel)
        {
            var response = new ApiResponse<Pagination<ConsultationViewModel>>();

            try
            {
                var filteredRequests = await _unitOfWork.FranchiseRegistrationRequestRepository
                    .GetFilteredRequestsAsync(filterModel.Status.HasValue ? filterModel.Status : null);

                if (filteredRequests == null || !filteredRequests.Any())
                {
                    response.isSuccess = true;
                    response.Data = new Pagination<ConsultationViewModel>
                    {
                        Items = new List<ConsultationViewModel>(),
                        TotalItemsCount = 0,
                        PageIndex = filterModel.PageIndex,
                        PageSize = filterModel.PageSize
                    };
                    return response;
                }
                var pagedRequests = filteredRequests
                    .Skip((filterModel.PageIndex - 1) * filterModel.PageSize)
                    .Take(filterModel.PageSize)
                    .ToList();

                var result = _mapper.Map<List<ConsultationViewModel>>(pagedRequests);

                response.isSuccess = true;
                response.Data = new Pagination<ConsultationViewModel>
                {
                    Items = result,
                    TotalItemsCount = filteredRequests.Count,
                    PageIndex = filterModel.PageIndex,
                    PageSize = filterModel.PageSize
                };
            }
            catch (DbException ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            catch (Exception ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
        }
        public async Task<ApiResponse<ConsultationViewModel>> GetByIdAsync(Guid id)
        {
            var response = new ApiResponse<ConsultationViewModel>();

            try
            {
              
                var franchiseRequest = await _unitOfWork.FranchiseRegistrationRequestRepository.GetByIdAsync(id);

                if (franchiseRequest == null)
                {
                    response.isSuccess = false;
                    response.Message = "Franchise registration request not found.";
                    return response;
                }
                var result = _mapper.Map<ConsultationViewModel>(franchiseRequest);

                response.isSuccess = true;
                response.Data = result;
            }
            catch (DbException ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;

            }
            catch (Exception ex)
            {
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
        }
    }
}