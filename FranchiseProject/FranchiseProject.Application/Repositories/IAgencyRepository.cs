﻿using FranchiseProject.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Repositories
{
    public interface IAgencyRepository : IGenericRepository<Agency>
    { 
        Task<IEnumerable<Agency>> GetAgencyExpiredAsync();
    }
}
