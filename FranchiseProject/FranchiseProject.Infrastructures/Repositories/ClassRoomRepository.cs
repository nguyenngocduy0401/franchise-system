﻿using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Repositories;
using FranchiseProject.Domain.Entity;
using FranchiseProject.Domain.Enums;
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
     
        public async Task<List<ClassRoom>> GetAllAsync(Expression<Func<ClassRoom, bool>> predicate)
        {
            return await _dbContext.ClassRooms.Where(predicate).ToListAsync();
        }
        public async Task AddAsync(ClassRoom classRoom)
        {
            await _dbContext.Set<ClassRoom>().AddAsync(classRoom);
        }
        public async Task<List<User>> GetWaitlistedStudentsAsync(List<string> studentIds)
        {
            return await _dbContext.Users
                .Where(u => studentIds.Contains(u.Id) && u.StudentStatus == StudentStatusEnum.Waitlisted)
                .ToListAsync();
        }


        public async Task<List<string>> GetInvalidStudentsAsync(List<string> studentIds)
        {
            return await _dbContext.Users
                .Where(u => studentIds.Contains(u.Id) && u.StudentStatus != StudentStatusEnum.Waitlisted)
                .Select(u => u.FullName)
                .ToListAsync();
        }
    }
}
