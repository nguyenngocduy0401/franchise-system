using FranchiseProject.API;
using FranchiseProject.API.Middlewares;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Hubs;
using FranchiseProject.Infrastructures;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var configuration = builder.Configuration.Get<AppConfiguration>();
builder.Services.AddInfrastructuresService(configuration.DatabaseConnection);
builder.Services.AddWebAPIService();
builder.Services.AddAuthenticationServices(configuration);
builder.Services.AddStackExchangeRedisCache(options => options.Configuration = configuration.RedisConfiguration);

// Define the CORS policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin", builder =>
    {
        builder.WithOrigins("http://localhost:5173") // Thay bằng URL của frontend
               .AllowAnyHeader()
               .AllowAnyMethod()
               .AllowCredentials();
    });
});

// Add SignalR
builder.Services.AddSignalR();
builder.Services.AddSingleton(configuration);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseMiddleware<PerformanceMiddleware>();
/*app.UseMiddleware<RedisAuthenticationMiddleware>();*/

// Apply the CORS policy
app.UseCors("AllowSpecificOrigin");

// Use authentication and authorization
app.UseAuthentication();
app.UseAuthorization();

// Map SignalR hub
app.MapHub<NotificationHub>("/notificationHub").RequireCors("AllowSpecificOrigin");

// Map controllers
app.MapControllers();

app.Run();