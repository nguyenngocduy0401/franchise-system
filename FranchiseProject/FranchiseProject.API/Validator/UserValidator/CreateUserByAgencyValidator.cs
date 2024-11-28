﻿using FluentValidation;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.ViewModels.UserViewModels;
using FranchiseProject.Domain.Enums;

namespace FranchiseProject.API.Validator.UserValidator
{
    public class CreateUserByAgencyValidator : AbstractValidator<CreateUserByAgencyModel>
    {
        public CreateUserByAgencyValidator()
        {
            RuleFor(x => x.FullName)
                .NotEmpty()
                .WithMessage("Tên đầy đủ là bắt buộc.");

            RuleFor(x => x.Role)
                .NotEmpty()
                .Must(role => role == RolesEnum.Student.ToString() || role == RolesEnum.Instructor.ToString())
                .WithMessage("Vai trò phải là học sinh hoặc giáo viên hướng dẫn.");

            RuleFor(x => x.Email)
                .NotEmpty()
                .EmailAddress()
                .WithMessage("Email không hợp lệ.");

            RuleFor(x => x.PhoneNumber)
                .NotEmpty()
                .Matches(@"^0[0-9]{9}$")
                .WithMessage("Số điện thoại phải có 10 chữ số và bắt đầu bằng 0.");
        }
    }
}
