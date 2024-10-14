﻿using FranchiseProject.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Repositories
{
    public interface IClassRepository : IGenericRepository<Class>
    {
        Task<bool> CheckNameExistAsync(string name);
    }
}
