﻿using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Repositories;
using FranchiseProject.Domain.Entity;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Infrastructures.Repositories
{
    public class ClassRoomRepository : IClassRoomRepository
    {
        private readonly AppDbContext _dbContext;
        private readonly ICurrentTime _timeService;
        private readonly IClaimsService _claimsService;
        private readonly UserManager<User> _userManager;

        private readonly RoleManager<Role> _roleManager;
        public ClassRoomRepository(
            AppDbContext context,
            ICurrentTime timeService,
            IClaimsService claimsService,
             UserManager<User> userManager,
             RoleManager<Role> roleManager
        ) 
        {
            _dbContext = context;
            _timeService = timeService;
            _claimsService = claimsService;
            _userManager = userManager;
            _roleManager = roleManager;
        }
        public async Task<IEnumerable<ClassRoom>> GetFilterAsync(Expression<Func<ClassRoom, bool>> filter)
        {
            return await _dbContext.ClassRooms
                .Include(sc => sc.User)  
                .Include(sc => sc.Class)    
                .Where(filter)
                .ToListAsync();
        }
        public async Task<int> CountStudentsByClassIdAsync(Guid classId)
        {
            var roles = await _roleManager.Roles.ToListAsync();
            var studentRole = roles.FirstOrDefault(r => r.Name == "Student");
            if (studentRole == null) return 0; 
            var usersInRole = await _userManager.GetUsersInRoleAsync(studentRole.Name);
            var userIdsInRole = usersInRole.Select(u => u.Id).ToList();
            var studentCount = await _dbContext.ClassRooms
                .Where(sc => sc.ClassId == classId && userIdsInRole.Contains(sc.UserId))
                .CountAsync();

            return studentCount;
        }
        public async Task<List<ClassRoom>> GetAllAsync(Expression<Func<ClassRoom, bool>> predicate)
        {
            return await _dbContext.ClassRooms.Where(predicate).ToListAsync();
        }
      
   
    }
}
