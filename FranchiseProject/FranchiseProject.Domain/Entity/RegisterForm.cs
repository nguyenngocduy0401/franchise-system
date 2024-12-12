﻿using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Domain.Entity
{
    public class RegisterForm: BaseEntity
    {
        public string ? CustomerName {  get; set; }
        public string? Email {  get; set; }
        public string? PhoneNumber { get; set; }
        public string? Address { get; set; }
        public DateTime? ConsultTime { get; set; }
        public ConsultationStatusEnum Status { get; set; }
        public CustomerStatus? CustomerStatus { get; set; }
        public string? ConsultanId {  get; set; }
        [ForeignKey("UserId")]
        public User? User { get; set; }
       
    }
}
