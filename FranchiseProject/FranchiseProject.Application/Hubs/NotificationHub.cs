using Microsoft.AspNetCore.SignalR;
using System;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Hubs
{
    public class NotificationHub : Hub
    {
        public override async Task OnConnectedAsync()
        {
            Console.WriteLine($"Client connected: {Context.ConnectionId}");
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            Console.WriteLine($"Client disconnected: {Context.ConnectionId}");
            await base.OnDisconnectedAsync(exception);
        }

        public async Task SendNotification(string userId, string message)
        {
            await Clients.User(userId).SendAsync("ReceivedNotification", message);
        }

        public async Task UpdateUnreadNotificationCount(string userId, int unreadCount)
        {
            if (string.IsNullOrEmpty(userId))
            {
                Console.WriteLine("UserId cannot be null or empty.");
                return;
            }

            try
            {
                await Clients.User(userId).SendAsync("UpdateUnreadNotificationCount", unreadCount);
                Console.WriteLine($"Updated unread notification count for user {userId}: {unreadCount}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating unread notification count for user {userId}: {ex.Message}");
            }
        }
    }
}
