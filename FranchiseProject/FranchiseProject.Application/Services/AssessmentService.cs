﻿using AutoMapper;
using FluentValidation;
using FluentValidation.Results;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Handler;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Repositories;
using FranchiseProject.Application.ViewModels.AssessmentViewModels;
using FranchiseProject.Application.ViewModels.MaterialViewModels;
using FranchiseProject.Application.ViewModels.SessionViewModels;
using FranchiseProject.Domain.Entity;
using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Services
{
    public class AssessmentService : IAssessmentService
    {
        private readonly ICourseService _courseService;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IValidator<CreateAssessmentModel> _createAssessmentValidator;
        private readonly IValidator<UpdateAssessmentModel> _updateAssessmentvalidator;
        public AssessmentService(IUnitOfWork unitOfWork, IMapper mapper, ICourseService courseService,
            IValidator<UpdateAssessmentModel> updateAssessmentValidator, IValidator<CreateAssessmentModel> createAssessmentValidator)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _courseService = courseService;
            _updateAssessmentvalidator = updateAssessmentValidator;
            _createAssessmentValidator = createAssessmentValidator;
        }
        public async Task<ApiResponse<bool>> CreateAssessmentAsync(CreateAssessmentModel createAssessmentModel)
        {
            var response = new ApiResponse<bool>();
            try
            {
                ValidationResult validationResult = await _createAssessmentValidator.ValidateAsync(createAssessmentModel);
                if (!validationResult.IsValid) return ValidatorHandler.HandleValidation<bool>(validationResult);

                var checkCourse = await _courseService.CheckCourseAvailableAsync(
                    createAssessmentModel.CourseId,
                    CourseStatusEnum.Draft
                    );
                if (!checkCourse.Data) return checkCourse;

                var assessment = _mapper.Map<Assessment>(createAssessmentModel);
                await _unitOfWork.AssessmentRepository.AddAsync(assessment);

                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Create failed!");
                response = ResponseHandler.Success(true, "Successful!");

            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }

        public async Task<ApiResponse<bool>> DeleteAssessmentByIdAsync(Guid assessmentId)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var assessment = await _unitOfWork.AssessmentRepository.GetExistByIdAsync(assessmentId);
                if (assessment == null)
                {
                    response.Data = false;
                    response.isSuccess = true;
                    response.Message = "Không tìm thấy đánh giá của khóa học!";
                    return response;
                }
                var checkCourse = await _courseService.CheckCourseAvailableAsync(assessment.CourseId,
                    CourseStatusEnum.Draft);

                if (!checkCourse.isSuccess) return checkCourse;
                _unitOfWork.AssessmentRepository.SoftRemove(assessment);
                response.Message = "Xoá đánh giá của khóa học thành công!";
                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Delete failed!");
                response.Data = true;
                response.isSuccess = true;
            }
            catch (Exception ex)
            {
                response.Data = false;
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
        }

        public  async Task<ApiResponse<AssessmentViewModel>> GetAssessmentByIdAsync(Guid assessmentId)
        {
            var response = new ApiResponse<AssessmentViewModel>();
            try
            {
                var assessment = await _unitOfWork.AssessmentRepository.GetByIdAsync(assessmentId);
                var assessmentModel = _mapper.Map<AssessmentViewModel>(assessment);
                response.Data = assessmentModel;
                response.isSuccess = true;
                response.Message = "Successful!";
            }
            catch (Exception ex)
            {
                response.Data = null;
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
        }

        public async Task<ApiResponse<bool>> UpdateAssessmentAsync(Guid assessmentId, UpdateAssessmentModel updateAssessmentModel)
        {
            var response = new ApiResponse<bool>();
            try
            {
                ValidationResult validationResult = await _updateAssessmentvalidator.ValidateAsync(updateAssessmentModel);
                if (!validationResult.IsValid)
                {
                    response.Data = false;
                    response.isSuccess = false;
                    response.Message = string.Join(", ", validationResult.Errors.Select(error => error.ErrorMessage));
                    return response;
                }
                var assessment = await _unitOfWork.AssessmentRepository.GetExistByIdAsync(assessmentId);
                var checkCourse = await _courseService.CheckCourseAvailableAsync(assessment.CourseId, CourseStatusEnum.Draft);
                if (!checkCourse.isSuccess) return checkCourse;
                assessment = _mapper.Map(updateAssessmentModel, assessment);
                await _unitOfWork.AssessmentRepository.AddAsync(assessment);
                var isSuccess = await _unitOfWork.SaveChangeAsync() > 0;
                if (!isSuccess) throw new Exception("Update failed!");
                response.Data = true;
                response.isSuccess = true;
                response.Message = "cập nhật đánh giá của khóa học thành công!";

            }
            catch (Exception ex)
            {
                response.Data = false;
                response.isSuccess = false;
                response.Message = ex.Message;
            }
            return response;
        }
    }
}
