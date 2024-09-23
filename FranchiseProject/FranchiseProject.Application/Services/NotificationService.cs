using AutoMapper;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Repositories;
using FranchiseProject.Application.ViewModels.EmailViewModels;
using FranchiseProject.Application.ViewModels.NotificationViewModel;
using FranchiseProject.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Services
{
    public class NotificationService:INotificationService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IClaimsService _claimsService;
        private readonly IMapper _mapper;
        public NotificationService(IUnitOfWork unitOfWork, IClaimsService claimsService,IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _claimsService = claimsService;
            _mapper = mapper;
        }

   

        public async Task<ApiResponse<bool>> CreateAndSendNotificationAsync(SendNotificationViewModel sendNotificationViewModel)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var senderId = _claimsService.GetCurrentUserId.ToString();
                await _unitOfWork.NotificationRepository.SendNotificationsAsync(sendNotificationViewModel.userIds, sendNotificationViewModel.message, senderId);
                response.Data = true;
                response.isSuccess = true;
                response.Message = "Gửi thông báo Thành Công !";
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
        public async Task<ApiResponse<int>> GetUnreadNotificationCountAsync()
        {
            var response = new ApiResponse<int>();
            try
            {
                var userId = _claimsService.GetCurrentUserId.ToString();
                var count = await _unitOfWork.NotificationRepository.GetUnreadNotificationCountByUserIdAsync(userId);
               
                response.Data = count;
                response.isSuccess = true;
                response.Message = "Truy xuất số thông báo chưa đọc thành công !";
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
        public async Task<ApiResponse<bool>> MarkNotificationAsReadAsync(string notificationId)
        {
            var response = new ApiResponse<bool>();
            try
            {
                var id = Guid.Parse(notificationId);
                await _unitOfWork.NotificationRepository.MarkNotificationAsReadAsync(id);
                response.Data = true;
                response.isSuccess = true;
                response.Message = "đánh dấu  thông báo đã đọc thành công !";
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
    
        public async Task<ApiResponse<List<NotificationViewModel>>> GetUserNotificationsAsync()
        {
            var response = new ApiResponse<List<NotificationViewModel>>();
            try
            {
                var userId=_claimsService.GetCurrentUserId.ToString();

                var notifications = await _unitOfWork.NotificationRepository.GetNotificationsByUserIdAsync(userId); 
                var notificationViewModels = _mapper.Map<List<NotificationViewModel>>(notifications);
                
                response.Data = notificationViewModels;
                response.isSuccess = true;
                response.Message = "truy xuất thành công !";
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
