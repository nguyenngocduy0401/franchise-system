﻿using FranchiseProject.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Repositories
{
    public interface IClassScheduleRepository : IGenericRepository<ClassSchedule>
    {
        Task<ClassSchedule?> GetExistingScheduleAsync(DateTime date, string room, Guid slotId);
    }
}
