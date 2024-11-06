﻿using FranchiseProject.Application.ViewModels.ScoreViewModels;
using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.ViewModels.QuizViewModels
{
    public class QuizStudentViewModel
    {
        public Guid? Id { get; set; }
        public int Quantity { get; set; }
        public int? Duration { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public DateTime? StartTime { get; set; }
        public Guid? ClassId { get; set; }
        public ScoreViewModel? Scores { get; set; }
    }
}