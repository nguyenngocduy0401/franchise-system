using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.ViewModels.NotificationViewModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;
using static iText.StyledXmlParser.Jsoup.Select.Evaluator;

namespace FranchiseProject.API.Controllers
{
     [Route("api/v1/notifications")]
    [ApiController]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationService _notificationService;

        public NotificationController(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        [SwaggerOperation(Summary = "Admin tạo và gửi thông báo đến người dùng{Authorize= Manager,Admin,FranchiseManager,Instructor}")]
        [HttpPost("")]
        [Authorize(Roles = AppRole.Admin + "," + AppRole.Manager + "," + AppRole.Intructor )] 
        public async Task<ApiResponse<bool>> CreateAndSendNotificationAsync([FromBody] SendNotificationViewModel model)
        {
            return await _notificationService.CreateAndSendNotificationAsync(model);
        }

        [SwaggerOperation(Summary = "Lấy tổng số thông báo chưa đọc của người dùng")]
        [HttpGet("")]
        [Authorize]
        public async Task<ApiResponse<int>> GetUnreadNotificationCountAsync()
        {
            return await _notificationService.GetUnreadNotificationCountAsync();
        }

        [SwaggerOperation(Summary = "Đánh dấu thông báo là đã đọc")]
        [HttpPost("{id}")]
        [Authorize] 
        public async Task<ApiResponse<bool>> MarkNotificationAsReadAsync(string id) { 
            return await _notificationService.MarkNotificationAsReadAsync(id);
        }

        [SwaggerOperation(Summary = "Lấy danh sách thông báo của người dùng")]
        [HttpGet("mine")]
        [Authorize]
        public async Task<ApiResponse<List<NotificationViewModel>>> GetUserNotificationsAsync()
        {
            return await _notificationService.GetUserNotificationsAsync();
        }
    }
}
