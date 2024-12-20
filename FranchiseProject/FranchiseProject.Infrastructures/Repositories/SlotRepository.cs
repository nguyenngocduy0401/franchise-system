﻿using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.Repositories;
using FranchiseProject.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Infrastructures.Repositories
{
    public class SlotRepository : GenericRepository<Slot>, ISlotRepository
    {
        private readonly AppDbContext _dbContext;
        private readonly ICurrentTime _timeService;
        private readonly IClaimsService _claimsService;
        public SlotRepository(
            AppDbContext context,
            ICurrentTime timeService,
            IClaimsService claimsService
        ) : base(context, timeService, claimsService)
        {
            _dbContext = context;
            _timeService = timeService;
            _claimsService = claimsService;
        }
        public async Task<Slot?> GetFirstOrDefaultAsync(Expression<Func<Slot, bool>> filter)
        {
            return await _dbContext.Slots.FirstOrDefaultAsync(filter);
        }
        public async Task<IEnumerable<ClassSchedule>> GetAllSlotAsync(Expression<Func<ClassSchedule, bool>> predicate)
        {
            return await _dbContext.ClassSchedules.Where(predicate).ToListAsync();
        }
        public async Task<bool> IsOverlappingAsync(Guid agencyId, TimeSpan  startTime, TimeSpan endTime, Guid? excludeSlotId = null)
        {
            return await _dbContext.Slots
                .AnyAsync(s => s.AgencyId == agencyId &&
                               s.Id != excludeSlotId &&
                               ((s.StartTime <= startTime && startTime < s.EndTime) ||
                                (s.StartTime < endTime && endTime <= s.EndTime) ||
                                (startTime <= s.StartTime && s.EndTime <= endTime)));
        }
    }
}
