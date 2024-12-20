﻿using AutoMapper;
using DocumentFormat.OpenXml.Spreadsheet;
using FluentValidation;
using FluentValidation.Results;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Handler;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.ViewModels.AppointmentViewModels;
using FranchiseProject.Application.ViewModels.NotificationViewModels;
using FranchiseProject.Application.ViewModels.UserViewModels;
using FranchiseProject.Application.ViewModels.WorkViewModels;
using FranchiseProject.Domain.Entity;
using FranchiseProject.Domain.Enums;
using MailKit.Search;
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
using static Google.Apis.Requests.BatchRequest;

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
        private readonly INotificationService _notificationService;
        public WorkService(IUnitOfWork unitOfWork, UserManager<User> userManager,
            IValidator<CreateWorkModel> createWorkValidator, IMapper mapper,
            IValidator<UpdateWorkModel> updateWorkValidator, IClaimsService claimsService,
            IValidator<UpdateWorkByStaffModel> updateWorkByStaffValidator,
            INotificationService notificationService)
        {
            _unitOfWork = unitOfWork;
            _userManager = userManager;
            _mapper = mapper;
            _createWorkValidator = createWorkValidator;
            _updateWorkValidator = updateWorkValidator;
            _claimsService = claimsService;
            _updateWorkByStaffValidator = updateWorkByStaffValidator;
            _notificationService = notificationService;
        }

        public async Task<ApiResponse<Pagination<WorkViewModel>>> GetWorksAgencyAsync(FilterWorkByLoginModel filterWorkByLoginModel)
        {
            var response = new ApiResponse<Pagination<WorkViewModel>>();
            try
            {
                var userId = _claimsService.GetCurrentUserId.ToString();

                var user = await _userManager.FindByIdAsync(userId);

                if (user.AgencyId != null) ResponseHandler.Success(new Pagination<WorkViewModel>(), "Người dùng không nằm trong trung tâm nào cả!");

                var filter = (Expression<Func<Work, bool>>)(e =>
                    (string.IsNullOrEmpty(filterWorkByLoginModel.Search) || e.Title.Contains(filterWorkByLoginModel.Search)
                    || e.Description.Contains(filterWorkByLoginModel.Search)) &&
                    (!filterWorkByLoginModel.Status.HasValue || e.Status == filterWorkByLoginModel.Status) &&
                    (!filterWorkByLoginModel.Level.HasValue || e.Level == filterWorkByLoginModel.Level) &&
                    (!filterWorkByLoginModel.Submit.HasValue || e.Submit == filterWorkByLoginModel.Submit) &&
                    (!filterWorkByLoginModel.Type.HasValue || e.Type == filterWorkByLoginModel.Type)
                );

                Func<IQueryable<Work>, IOrderedQueryable<Work>> orderBy = query => query.OrderBy(p => p.StartDate);
                if (filterWorkByLoginModel.SortBy.HasValue && filterWorkByLoginModel.SortDirection.HasValue)
                {
                    switch (filterWorkByLoginModel.SortBy.Value)
                    {
                        case WorkSortByEnum.CreateDate:
                            orderBy = filterWorkByLoginModel.SortDirection == SortDirectionEnum.Descending ?
                                query => query.OrderByDescending(p => p.CreationDate) :
                                query => query.OrderBy(p => p.CreationDate);
                            break;
                        case WorkSortByEnum.StartDate:
                            orderBy = filterWorkByLoginModel.SortDirection == SortDirectionEnum.Descending ?
                                query => query.OrderByDescending(p => p.StartDate) :
                                query => query.OrderBy(p => p.StartDate);
                            break;
                        case WorkSortByEnum.EndDate:
                            orderBy = filterWorkByLoginModel.SortDirection == SortDirectionEnum.Descending ?
                                query => query.OrderByDescending(p => p.EndDate) :
                                query => query.OrderBy(p => p.EndDate);
                            break;
                    }
                }

                var worksPagination = await _unitOfWork.WorkRepository.FilterWorksByAgencyId(
                agencyId: (Guid)user.AgencyId,
                filter: filter,
                type: AppointmentTypeEnum.WithAgency,
                orderBy: orderBy,
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
                    (!filterWorkByLoginModel.Submit.HasValue || e.Submit == filterWorkByLoginModel.Submit) &&
                    (!filterWorkByLoginModel.Type.HasValue || e.Type == filterWorkByLoginModel.Type)
                );
                Func<IQueryable<Work>, IOrderedQueryable<Work>>? orderBy = null;
                if (filterWorkByLoginModel.SortBy.HasValue && filterWorkByLoginModel.SortDirection.HasValue)
                {
                    switch (filterWorkByLoginModel.SortBy.Value)
                    {
                        case WorkSortByEnum.CreateDate:
                            orderBy = filterWorkByLoginModel.SortDirection == SortDirectionEnum.Descending ?
                                query => query.OrderByDescending(p => p.CreationDate) :
                                query => query.OrderBy(p => p.CreationDate);
                            break;
                        case WorkSortByEnum.StartDate:
                            orderBy = filterWorkByLoginModel.SortDirection == SortDirectionEnum.Descending ?
                                query => query.OrderByDescending(p => p.StartDate) :
                                query => query.OrderBy(p => p.StartDate);
                            break;
                        case WorkSortByEnum.EndDate:
                            orderBy = filterWorkByLoginModel.SortDirection == SortDirectionEnum.Descending ?
                                query => query.OrderByDescending(p => p.EndDate) :
                                query => query.OrderBy(p => p.EndDate);
                            break;
                    }
                }

                var worksPagination = await _unitOfWork.WorkRepository.FilterWorksByUserId(
                userId: userId,
                filter: filter,
                includeProperties: "Agency",
                orderBy: orderBy,
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
                var contract = await _unitOfWork.ContractRepository.GetMostRecentContractByAgencyIdAsync(work.AgencyId.Value);

                var workModel = _mapper.Map<WorkDetailViewModel>(work);
                workModel.DesignFee = contract?.DesignFee ?? 0;
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
                var agency = await _unitOfWork.AgencyRepository.GetExistByIdAsync(agencyId);
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
                    (!filterWorkModel.Submit.HasValue || e.Submit == filterWorkModel.Submit) &&
                    (!filterWorkModel.Type.HasValue || e.Type == filterWorkModel.Type)
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
                if (checkUserExist == false)
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

                ValidationResult validationResult = await _updateWorkByStaffValidator.ValidateAsync(updateWorkByStaffModel);
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
                var checkDate = await CheckPreviousWorkDateValidation(work);
                if (checkDate.Data == false) return checkDate;

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

                var checkDate = await CheckPreviousWorkDateValidation(work);
                if (checkDate.Data == false) return checkDate;

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
                if (work.Type <= WorkTypeEnum.SignedContract)
                {
                    var checkWorkBefore = (await _unitOfWork.WorkRepository
                        .FindAsync(e => e.IsDeleted != true &&
                                   e.Type < work.Type &&
                                   e.Status != WorkStatusEnum.Approved &&
                                   e.Level == WorkLevelEnum.Compulsory &&
                                   e.AgencyId == work.AgencyId
                                   )).FirstOrDefault();

                    if (checkWorkBefore != null) return ResponseHandler.Success(false, "Phải hoàn thành nhiệm vụ ưu tiên trước!");
                }
                if (work.Type > WorkTypeEnum.SignedContract)
                {
                    var agency = await _unitOfWork.AgencyRepository.GetExistByIdAsync((Guid)work.AgencyId);
                    if (agency.Status == AgencyStatusEnum.Inactive || agency.Status == AgencyStatusEnum.Processing)
                        return ResponseHandler.Success(false, "Không thể phê duyệt khi trung tâm ở trạng thái này!");

                }
                switch (status)
                {
                    case WorkStatusEnum.None:
                        throw new Exception("Cannot update this status!");
                    case WorkStatusEnum.Approved:
                        {
                            work.Status = status;
                            if (work.Level == WorkLevelEnum.Compulsory)
                            {
                                if (work.Submit != WorkStatusSubmitEnum.Submited)
                                    return ResponseHandler.Success(false, "Nhiệm vụ bắt buộc chưa được xử lí. Không thể duyệt lúc này!");
                                switch (work.Type)
                                {
                                    case WorkTypeEnum.BusinessRegistered:
                                        {
                                            var hasActiveAgreementContract = await _unitOfWork.DocumentRepository.HasActiveBusinessLicenseAsync(work.AgencyId.Value);
                                            if (!hasActiveAgreementContract)
                                            {
                                                return ResponseHandler.Success(false, "Không thể phê duyệt khi chưa có giấy đăng kí doanh nghiệp hoạt động!");
                                            }
                                            var doc = await _unitOfWork.DocumentRepository.GetMostRecentAgreeSignByAgencyIdAsync(work.AgencyId.Value, DocumentType.BusinessLicense);
                                            doc.Appoved = true;
                                            _unitOfWork.DocumentRepository.Update(doc);
                                            break;
                                        }
                                    case WorkTypeEnum.AgreementSigned:
                                        {
                                            var work1 = _unitOfWork.WorkRepository.GetExistByIdAsync(workId);
                                            var hasActiveAgreementContract = await _unitOfWork.DocumentRepository.HasActiveAgreementContractAsync(work.AgencyId.Value);
                                            var doc = await _unitOfWork.DocumentRepository.GetMostRecentAgreeSignByAgencyIdAsync(work.AgencyId.Value, DocumentType.AgreementContract);
                                            doc.URLFile = work.CustomerSubmit;
                                            doc.Appoved = true;
                                            var fee = await _unitOfWork.FranchiseFeesRepository.GetAllAsync();
                                            var contract = new Contract
                                            {
                                                AgencyId = work.AgencyId.Value,
                                                Status = ContractStatusEnum.None,
                                                FrachiseFee = fee.Sum(f => f.FeeAmount),

                                            };
                                            await _unitOfWork.ContractRepository.AddAsync(contract);
                                            _unitOfWork.DocumentRepository.Update(doc);
                                            if (!hasActiveAgreementContract)
                                            {
                                                return ResponseHandler.Success(false, "Không thể phê duyệt khi chưa có hợp đồng thỏa thuận!");
                                            }
                                        }
                                        break;

                                    case WorkTypeEnum.SignedContract:
                                        {
                                            var contract = await _unitOfWork.ContractRepository.GetMostRecentContractByAgencyIdAsync(work.AgencyId.Value);
                                            if (string.IsNullOrEmpty(contract.ContractDocumentImageURL))
                                            {
                                                return ResponseHandler.Success(false, "Không thể phê duyệt khi chưa có hợp đồng!");
                                            }
                                            contract.Status = ContractStatusEnum.Active;
                                            contract.ContractDocumentImageURL = work.CustomerSubmit;
                                            //    _unitOfWork.WorkRepository.Update(work);
                                            _unitOfWork.ContractRepository.Update(contract);

                                        }
                                        break;
                                    case WorkTypeEnum.Handover:
                                        {
                                            var contract = await _unitOfWork.ContractRepository.GetMostRecentContractByAgencyIdAsync(work.AgencyId.Value);
                                            var equipments = await _unitOfWork.EquipmentRepository.GetEquipmentByContractIdAsync(contract.Id);
                                            foreach (var equipment in equipments)
                                            {
                                                var equipmentHistory = await _unitOfWork.EquipmentSerialNumberHistoryRepository
                                                    .FindAsync(e => e.EquipmentId == equipment.Id &&
                                                                    e.StartDate == null);

                                                foreach (var history in equipmentHistory)
                                                {
                                                    history.StartDate = DateTime.Now;
                                                    _unitOfWork.EquipmentSerialNumberHistoryRepository.Update(history);
                                                }
                                            }
                                            var doc = await _unitOfWork.DocumentRepository.GetMostRecentAgreeSignByAgencyIdAsync(work.AgencyId.Value, DocumentType.Handover);
                                            doc.URLFile = work.CustomerSubmit;
                                            _unitOfWork.DocumentRepository.Update(doc);
                                        }
                                        break;
                                    case WorkTypeEnum.EducationLicenseRegistered:
                                        {
                                            var document = await _unitOfWork.DocumentRepository
                                                .GetMostRecentAgreeSignByAgencyIdAsync((Guid)work.AgencyId, DocumentType.EducationalOperationLicense);
                                            if (document == null)
                                            {
                                                return ResponseHandler.Success(false, "Không thể phê duyệt khi chưa có giấy phép giáo dục!");
                                            }
                                            var doc = await _unitOfWork.DocumentRepository.GetMostRecentAgreeSignByAgencyIdAsync(work.AgencyId.Value, DocumentType.EducationalOperationLicense);
                                            doc.Appoved = true;
                                            _unitOfWork.DocumentRepository.Update(doc);
                                        }
                                        break;
                                }
                            }
                            if (work.Level == WorkLevelEnum.Optional)
                            {
                                switch (work.Type)
                                {
                                    case WorkTypeEnum.Quotation:
                                        {
                                            var contract = await _unitOfWork.ContractRepository.GetMostRecentContractByAgencyIdAsync(work.AgencyId.Value);
                                            contract.EquipmentFee = await _unitOfWork.EquipmentRepository.GetTotalEquipmentAmountByContractIdAsync(contract.Id);

                                            contract.Total = contract.DesignFee + contract.FrachiseFee + contract.EquipmentFee;
                                            _unitOfWork.ContractRepository.Update(contract);

                                        }
                                        break;
                                    case WorkTypeEnum.SignedContract:
                                        {
                                            var contract = await _unitOfWork.ContractRepository.GetMostRecentContractByAgencyIdAsync(work.AgencyId.Value);
                                            //  contract.Status = ContractStatusEnum.Active;
                                            contract.ContractDocumentImageURL = work.ReportImageURL;
                                            //   _unitOfWork.WorkRepository.Update(work);
                                            _unitOfWork.ContractRepository.Update(contract);
                                        }
                                        break;
                                }
                            }
                        }
                        break;
                    case WorkStatusEnum.Rejected:
                        work.Status = status;
                        if (work.Level == WorkLevelEnum.Compulsory)
                        {
                            if (work.Submit != WorkStatusSubmitEnum.Submited)
                                return ResponseHandler.Success(false, "Nhiệm vụ bắt buộc chưa được xử lí. Không thể duyệt lúc này!");

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
                if (work.Type <= WorkTypeEnum.EducationLicenseRegistered)
                {
                    if (work.Type <= WorkTypeEnum.SignedContract)
                    {
                        if (agency.Status == AgencyStatusEnum.Suspended ||
                            agency.Status == AgencyStatusEnum.Active ||
                            agency.Status == AgencyStatusEnum.Approved)
                            return ResponseHandler.Success(false, "Trung tâm đã kí hợp đồng không thể tương tác với các nhiệm vụ trước đó!");
                    }

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
        private async Task<ApiResponse<bool>> CheckPreviousWorkDateValidation(Work work)
        {
            var response = new ApiResponse<bool>();
            try
            {
                if (work.Type > WorkTypeEnum.Interview && work.Type <= WorkTypeEnum.EducationLicenseRegistered)
                {
                    var filter = (Expression<Func<Work, bool>>)(e => e.IsDeleted != true &&
                    e.Type < work.Type &&
                    work.Level == WorkLevelEnum.Compulsory);
                    var previousWork = await _unitOfWork.WorkRepository.GetPreviousWorkByAgencyId((Guid)work.AgencyId, filter);
                    if (previousWork != null)
                    {
                        if (previousWork.EndDate > work.StartDate)
                            return ResponseHandler.Success(false, "Ngày bắt đầu phải lớn hơn ngày kết thúc của nhiệm vụ được ràng buộc ở quy trình trước!");
                    }
                }
                response = ResponseHandler.Success(true);
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }
        public async Task<ApiResponse<bool>> UploadFileByAgencyManager(Guid id, string fileURL)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var work = await _unitOfWork.WorkRepository.GetExistByIdAsync(id);
                work.CustomerSubmit = fileURL;
                _unitOfWork.WorkRepository.Update(work);
                var agencyManagerUserIds = await _unitOfWork.WorkRepository.GetListUserByWorkId(id);
                var agency = await _unitOfWork.AgencyRepository.GetExistByIdAsync(work.AgencyId.Value);
          
                string actionMessage = GetActionMessageByWorkType(work.Type.Value);
                foreach (var agencyManagerUserId in agencyManagerUserIds)
                {
                    if (agencyManagerUserId != string.Empty)
                    {
                        var noti = new SendNotificationViewModel
                        {
                            message = $"Đối tác {agency.Name} đã tải {actionMessage} !",
                            userIds = new List<string> { agencyManagerUserId }
                        };
                        await _notificationService.CreateAndSendNotificationNoReponseAsync(noti);

                    }
                }
                await _unitOfWork.SaveChangeAsync();
                return ResponseHandler.Success(true, "Cập nhật thành công !");
            }
            catch (Exception ex)
            {
                response = ResponseHandler.Failure<bool>(ex.Message);
            }
            return response;
        }

        private string GetActionMessageByWorkType(WorkTypeEnum workType)
        {
            switch (workType)
            {
                case WorkTypeEnum.AgreementSigned:
                    return "tải lên biên bản thỏa thuận.";
                case WorkTypeEnum.BusinessRegistered:
                    return "tải lên giấy đăng kí doanh nghiệp.";
                case WorkTypeEnum.SignedContract:
                    return "tải lên hợp đồng đã ký";
                case WorkTypeEnum.Handover:
                    return "tải lên biên bản bàn giao";
                case WorkTypeEnum.EducationLicenseRegistered:
                    return "tải lên giấy phép đăng ký giáo dục";
            
           
                default:
                    return "tải lên tài liệu";
            }
        } 
    } 
}

